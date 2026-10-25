#!/usr/bin/env bash
set -u
export PATH="/c/msys64/ucrt64/bin:$PATH"
cd "$(dirname "$0")/.."
BIN=bench/bin; R=bench/results
RUNNER=$BIN/runner.exe
mkdir -p "$R"

declare -A FL
FL[gccO2]=$($RUNNER f 30 3 -- $BIN/empty_gcc_O2.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[gccO3]=$($RUNNER f 30 3 -- $BIN/empty_gcc_O3.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[clangO3]=$($RUNNER f 30 3 -- $BIN/empty_clang_O3.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[sutraX86]=$($RUNNER f 30 3 -- $BIN/empty_sutra_x86.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
FL[sutraRel]=$($RUNNER f 30 3 -- $BIN/empty_sutra_rel.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2)
echo "floor gccO2=${FL[gccO2]} gccO3=${FL[gccO3]} clangO3=${FL[clangO3]} sutraX86=${FL[sutraX86]} sutraRel=${FL[sutraRel]}"
echo "row,binbase,variant,args,median,min,max,stddev,rsd,floor,net,inproc,output" > $R/all.csv

T(){ local row=$1 bb=$2 v=$3 args=$4 it=$5 wu=$6
  local exe=$BIN/${bb}_${v}.exe
  if [ ! -x "$exe" ]; then printf "  %-32s MISSING\n" "${bb}_${v}"; echo "$row,$bb,$v,\"$args\",NA,NA,NA,NA,NA,NA,NA,NA,MISSING">>$R/all.csv; return; fi
  local L=$($RUNNER x $it $wu -- $exe $args 2>&1 >/dev/null | grep SUMMARY)
  local med=$(echo "$L"|grep -oE 'median=[0-9.]+'|cut -d= -f2) mn=$(echo "$L"|grep -oE 'min=[0-9.]+'|cut -d= -f2)
  local mx=$(echo "$L"|grep -oE 'max=[0-9.]+'|cut -d= -f2) sd=$(echo "$L"|grep -oE 'stddev=[0-9.]+'|cut -d= -f2)
  local rsd=$(echo "$L"|grep -oE 'rsd=[0-9.]+'|cut -d= -f2) fl=${FL[$v]}
  local net=$(awk "BEGIN{printf \"%.4f\", ($med)-($fl)}")
  local ip=$($exe $args 2>&1 >/dev/null | grep -oE 'INPROC [0-9.]+'|awk '{print $2}')
  local out=$($exe $args 2>/dev/null | tr '\n' '|')
  printf "  %-32s med=%-9s net=%-9s rsd=%-7s out=%s\n" "${bb}_${v}" "$med" "$net" "${rsd}%" "$out"
  echo "$row,$bb,$v,\"$args\",$med,$mn,$mx,$sd,$rsd,$fl,$net,${ip:-},\"$out\"">>$R/all.csv
}
STD(){ local row=$1 bb=$2 args=$3 it=$4 wu=$5 xit=${6:-$4}
  T "$row" "$bb" gccO2 "$args" $it $wu; T "$row" "$bb" gccO3 "$args" $it $wu; T "$row" "$bb" clangO3 "$args" $it $wu
  T "$row" "$bb" sutraRel "$args" $it $wu; T "$row" "$bb" sutraX86 "$args" $xit $wu; echo; }

echo "### C1";  STD C1 c1_scalar_int "1000000000" 15 3
echo "### C2";  STD C2 c2_fp_dot     "400000000"  12 3
echo "### C3";  STD C3 c3_fib        "43"         10 3
echo "### C4 (n=512 R=1; C++ small, noted)";  STD C4 c4_matmul "512" 10 3 5
echo "### C5";  STD C5 c5_sieve      "50000000 12" 8 2 5
echo "### M1"
T M1 m1_dynarray_naive gccO2 "10000000 10" 8 2; T M1 m1_dynarray_naive gccO3 "10000000 10" 8 2
T M1 m1_dynarray_naive clangO3 "10000000 10" 8 2; T M1 m1_dynarray_idiom gccO3 "10000000 10" 8 2
T M1 m1_dynarray sutraRel "10000000 10" 8 2; T M1 m1_dynarray sutraX86 "10000000 10" 5 2; echo
echo "### M2";  STD M2 m2_linkedlist "1000000 400" 8 2 5
echo "### M3";  STD M3 m3_allocchurn "1000000 8"   8 2 5
echo "### S2"
T S2 s2_builder_naive gccO3 "10000000" 8 2; T S2 s2_builder_idiom gccO3 "10000000" 8 2
T S2 s2_builder_idiom clangO3 "10000000" 8 2
T S2 s2_builder sutraRel "10000000" 8 2; T S2 s2_builder sutraX86 "10000000" 6 2; echo
echo "### S3";  STD S3 s3_splitparse "bench/data/nums.txt" 10 2 6
echo "### S4";  STD S4 s4_strcmp     "50000000"            12 3
echo "### D1"
T D1 d1_hashmap_umap gccO3 "3000000" 8 2; T D1 d1_hashmap_umap clangO3 "3000000" 8 2
T D1 d1_hashmap_omap gccO3 "3000000" 8 2
T D1 d1_hashmap sutraRel "3000000" 8 2; T D1 d1_hashmap sutraX86 "3000000" 5 2; echo
echo "### D2 (Sutra stdlib merge sort vs std::sort)";  STD D2 d2_sort "10000000" 10 2 4
echo "### D3";  STD D3 d3_bintree "2000000 20" 8 2 4
echo "### R2 (OUTPUT MISMATCH - timing informational only)"; STD R2 r2_wordfreq "bench/data/words.txt" 8 2 5
echo "### R3";  STD R3 r3_nbody "500000" 12 3
echo "### R1: Sutra जेसन_पार्स > 60s on 4MB -> DNF, not timed"
echo "### S1 concat scaling"
for N in 20000 40000 80000 160000; do
  T "S1n$N" s1_concat_naive gccO3 "$N" 8 2
  T "S1n$N" s1_concat_idiom gccO3 "$N" 8 2
  T "S1n$N" s1_concat sutraRel "$N" 8 2
  T "S1n$N" s1_concat sutraX86 "$N" 6 2
  T "S1n$N" s1_concat_escape sutraRel "$N" 8 2
done
echo "TIMING COMPLETE"
