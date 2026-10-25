#!/usr/bin/env bash
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")/.."
SUT=bench/sutra; CPP=bench/cpp; BIN=bench/bin; R=bench/results
mkdir -p "$BIN" "$R"
RUNNER=$BIN/runner.exe
CSTD="-std=c++20"

echo "=========== BUILD C++ ==========="
CPPFILES=$(cd $CPP && ls *.cpp)
for src in $CPPFILES; do
  name=${src%.cpp}
  extra=""; case "$name" in r3_nbody|c4_matmul) extra="-ffp-contract=off";; esac
  g++ -O2 $CSTD $extra -o $BIN/${name}_gccO2.exe $CPP/$src 2>/dev/null || echo "  gccO2 FAIL $name"
  g++ -O3 -march=native $CSTD $extra -o $BIN/${name}_gccO3.exe $CPP/$src 2>/dev/null || echo "  gccO3 FAIL $name"
  clang++ -O3 -march=native $CSTD $extra -o $BIN/${name}_clangO3.exe $CPP/$src 2>/dev/null || echo "  clangO3 FAIL $name"
done

echo "=========== BUILD Sutra ==========="
SUTRA_BENCH="c1_scalar_int c2_fp_dot c3_fib c4_matmul c5_sieve m1_dynarray m2_linkedlist m3_allocchurn s1_concat s1_concat_escape s2_builder s3_splitparse s4_strcmp d1_hashmap d2_sort d3_bintree r1_json r2_wordfreq r3_nbody"
for n in $SUTRA_BENCH; do
  [ -f "$SUT/$n.सूत्र" ] || { echo "  MISSING src $n"; continue; }
  ./sutrac.exe "$SUT/$n.सूत्र" >/dev/null 2>&1 && cp "$SUT/${n}.सूत्र_native.exe" "$BIN/${n}_sutraX86.exe" || echo "  sutraX86 FAIL $n"
  ./sutrac.exe --release "$SUT/$n.सूत्र" >/dev/null 2>&1 && cp "$SUT/${n}.सूत्र_native.exe" "$BIN/${n}_sutraRel.exe" || echo "  sutraRel FAIL $n"
  rm -f "$SUT/${n}.सूत्र_native.exe"
done
echo "build done."

echo "=========== FLOORS ==========="
declare -A FL
FL[gccO2]=$($RUNNER f 30 3 -- $BIN/empty_gcc_O2.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[gccO3]=$($RUNNER f 30 3 -- $BIN/empty_gcc_O3.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[clangO3]=$($RUNNER f 30 3 -- $BIN/empty_clang_O3.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[sutraX86]=$($RUNNER f 30 3 -- $BIN/empty_sutra_x86.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[sutraRel]=$($RUNNER f 30 3 -- $BIN/empty_sutra_rel.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
echo "floor gccO2=${FL[gccO2]} gccO3=${FL[gccO3]} clangO3=${FL[clangO3]} sutraX86=${FL[sutraX86]} sutraRel=${FL[sutraRel]}"

echo "row,binbase,variant,args,median,min,max,stddev,rsd,floor,net,inproc,output" > $R/all.csv

T(){ # rowlabel  binbase  variant  "args"  iters  warmup
  local row=$1 bb=$2 v=$3 args=$4 it=$5 wu=$6
  local exe=$BIN/${bb}_${v}.exe
  if [ ! -x "$exe" ]; then
    printf "  %-34s MISSING\n" "${bb}_${v}"
    echo "$row,$bb,$v,\"$args\",NA,NA,NA,NA,NA,NA,NA,NA,MISSING" >> $R/all.csv; return
  fi
  local line=$($RUNNER x $it $wu -- $exe $args 2>&1 >/dev/null | grep SUMMARY)
  local med=$(echo "$line"|grep -oE 'median=[0-9.]+'|cut -d= -f2)
  local mn=$(echo "$line"|grep -oE 'min=[0-9.]+'|cut -d= -f2)
  local mx=$(echo "$line"|grep -oE 'max=[0-9.]+'|cut -d= -f2)
  local sd=$(echo "$line"|grep -oE 'stddev=[0-9.]+'|cut -d= -f2)
  local rsd=$(echo "$line"|grep -oE 'rsd=[0-9.]+'|cut -d= -f2)
  local fl=${FL[$v]}
  local net=$(awk "BEGIN{printf \"%.4f\", ($med)-($fl)}")
  local ip=$($exe $args 2>&1 >/dev/null | grep -oE 'INPROC [0-9.]+'|awk '{print $2}')
  local out=$($exe $args 2>/dev/null | tr '\n' '|')
  printf "  %-34s med=%-9s net=%-9s rsd=%-7s out=%s\n" "${bb}_${v}" "$med" "$net" "${rsd}%" "$out"
  echo "$row,$bb,$v,\"$args\",$med,$mn,$mx,$sd,$rsd,$fl,$net,${ip:-},\"$out\"" >> $R/all.csv
}

# std triple = gccO2 gccO3 clangO3 sutraRel sutraX86 on the same binbase
STD(){ local row=$1 bb=$2 args=$3 it=$4 wu=$5
  T "$row" "$bb" gccO2 "$args" $it $wu
  T "$row" "$bb" gccO3 "$args" $it $wu
  T "$row" "$bb" clangO3 "$args" $it $wu
  T "$row" "$bb" sutraRel "$args" $it $wu
  T "$row" "$bb" sutraX86 "$args" $it $wu
  echo
}

echo "=========== TIMING ==========="
STD C1 c1_scalar_int "1000000000" 12 3
STD C2 c2_fp_dot     "400000000"  12 3
STD C3 c3_fib        "43"         10 3
STD C4 c4_matmul     "1024"        6 2
STD C5 c5_sieve      "50000000 12" 6 2

echo "### M1 dynarray N=1e7 R=10 (C++ naive+idiom)"
T M1 m1_dynarray_naive gccO2 "10000000 10" 6 2
T M1 m1_dynarray_naive gccO3 "10000000 10" 6 2
T M1 m1_dynarray_naive clangO3 "10000000 10" 6 2
T M1 m1_dynarray_idiom gccO3 "10000000 10" 6 2
T M1 m1_dynarray sutraRel "10000000 10" 6 2
T M1 m1_dynarray sutraX86 "10000000 10" 6 2
echo

STD M2 m2_linkedlist "1000000 400" 6 2
STD M3 m3_allocchurn "1000000 8"   6 2

echo "### S2 builder N=1e7 (C++ naive+idiom)"
T S2 s2_builder_naive gccO3 "10000000" 8 2
T S2 s2_builder_idiom gccO3 "10000000" 8 2
T S2 s2_builder_idiom clangO3 "10000000" 8 2
T S2 s2_builder sutraRel "10000000" 8 2
T S2 s2_builder sutraX86 "10000000" 8 2
echo

STD S3 s3_splitparse "bench/data/nums.txt" 8 2
STD S4 s4_strcmp     "50000000"            10 3

echo "### D1 hashmap N=3e6 (unordered_map + map)"
T D1 d1_hashmap_umap gccO3 "3000000" 6 2
T D1 d1_hashmap_umap clangO3 "3000000" 6 2
T D1 d1_hashmap_omap gccO3 "3000000" 6 2
T D1 d1_hashmap sutraRel "3000000" 6 2
T D1 d1_hashmap sutraX86 "3000000" 6 2
echo

STD D2 d2_sort     "10000000"    8 2
STD D3 d3_bintree  "2000000 20"  6 2
STD R1 r1_json     "bench/data/data.json"  8 2
STD R2 r2_wordfreq "bench/data/words.txt"  8 2
STD R3 r3_nbody    "500000"      10 3

echo "### S1 concat scaling (naive C++ O(n^2) / idiom C++ O(n) / sutra transformed / sutra escape)"
for N in 20000 40000 80000 160000; do
  T "S1_n$N" s1_concat_naive  gccO3   "$N" 6 2
  T "S1_n$N" s1_concat_idiom  gccO3   "$N" 6 2
  T "S1_n$N" s1_concat        sutraRel "$N" 6 2
  T "S1_n$N" s1_concat        sutraX86 "$N" 6 2
  T "S1_n$N" s1_concat_escape sutraRel "$N" 6 2
done
echo "ALL DONE"
