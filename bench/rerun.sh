#!/usr/bin/env bash
set -u
cd /c/msys64/tmp/b
BIN=./bin; R=./results
RUN=$BIN/runner.exe
fl(){ timeout 90 $RUN f 25 3 -- $BIN/$1.exe 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2; }
declare -A FL
FL[gccO2]=$(fl empty_gcc_O2); FL[gccO3]=$(fl empty_gcc_O3); FL[clangO3]=$(fl empty_clang_O3)
FL[sutraX86]=$(fl empty_sutra_x86); FL[sutraRel]=$(fl empty_sutra_rel)
echo "floor g2=${FL[gccO2]} g3=${FL[gccO3]} c=${FL[clangO3]} sx=${FL[sutraX86]} sr=${FL[sutraRel]}"
echo "row,binbase,variant,args,median,min,max,stddev,rsd,floor,net,inproc" > $R/rerun.csv
T(){ local row=$1 bb=$2 v=$3 args=$4 it=$5 wu=$6 tmo=${7:-400}
  local exe=$BIN/${bb}_${v}.exe
  [ -x "$exe" ] || { printf "  %-28s MISSING\n" "${bb}_${v}"; return; }
  local L=$(timeout $tmo $RUN x $it $wu -- $exe $args 2>&1 >/dev/null | grep SUMMARY)
  [ -z "$L" ] && { printf "  %-28s DNF>${tmo}s\n" "${bb}_${v}"; echo "$row,$bb,$v,\"$args\",DNF,,,,,,,">>$R/rerun.csv; return; }
  local med=$(echo "$L"|grep -oE 'median=[0-9.]+'|cut -d= -f2) mn=$(echo "$L"|grep -oE 'min=[0-9.]+'|cut -d= -f2)
  local mx=$(echo "$L"|grep -oE 'max=[0-9.]+'|cut -d= -f2) sd=$(echo "$L"|grep -oE 'stddev=[0-9.]+'|cut -d= -f2)
  local rsd=$(echo "$L"|grep -oE 'rsd=[0-9.]+'|cut -d= -f2) f=${FL[$v]}
  local net=$(awk -v m=$med -v x=$f 'BEGIN{printf "%.4f",m-x}')
  local ip=$($exe $args 2>&1 >/dev/null | grep -oE 'INPROC [0-9.]+'|awk '{print $2}')
  printf "  %-28s med=%-9s net=%-9s rsd=%-6s ip=%s\n" "${bb}_${v}" "$med" "$net" "${rsd}%" "${ip:-.}"
  echo "$row,$bb,$v,\"$args\",$med,$mn,$mx,$sd,$rsd,$f,$net,${ip:-}">>$R/rerun.csv
}
STD(){ local r=$1 b=$2 a=$3 it=$4 wu=$5 xit=${6:-$4} xtm=${7:-600}
  T $r $b gccO2 "$a" $it $wu; T $r $b gccO3 "$a" $it $wu; T $r $b clangO3 "$a" $it $wu
  T $r $b sutraRel "$a" $it $wu; T $r $b sutraX86 "$a" $xit $wu $xtm; echo; }

echo "### C1 (clean)"; STD C1 c1_scalar_int "1000000000" 15 3 12
echo "### C2 (clean)"; STD C2 c2_fp_dot     "400000000"  15 3 8 400
echo "### C3 (clean)"; STD C3 c3_fib        "43"         12 3 8 500
echo "### C4 n=512 R=8 (clean; +reps for >200ms C++)"; STD C4 c4_matmul "512" 10 3 3 900
echo "### C5 (clean)"; STD C5 c5_sieve      "50000000 12" 8 2 4 900
echo "### S4 fixed (clean)"; STD S4b s4_strcmp "50000000" 12 3 6
echo "### R3 2M steps (clean)"; STD R3b r3_nbody "2000000" 12 3 8
echo "RERUN DONE"
