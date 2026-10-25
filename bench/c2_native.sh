#!/usr/bin/env bash
set -u
cd /c/msys64/tmp/b
BIN=./bin; RUN=$BIN/runner.exe
fl(){ timeout 120 $RUN f 30 4 -- $BIN/$1 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2; }
declare -A FL
FL[gccO2]=$(fl empty_gcc_O2.exe); FL[gccO3]=$(fl empty_gcc_O3.exe); FL[clangO3]=$(fl empty_clang_O3.exe)
FL[sutraX86]=$(fl empty_sutra_x86.exe); FL[sutraRel]=$(fl empty_sutra_rel.exe); FL[sutraRelNat]=$(fl empty_sutra_relnative.exe)
echo "floors: g2=${FL[gccO2]} g3=${FL[gccO3]} c=${FL[clangO3]} sx=${FL[sutraX86]} sr=${FL[sutraRel]} srn=${FL[sutraRelNat]}"
echo "row,variant,args,median,rsd,floor,net,out" > results/c2_native.csv
T(){ local v=$1 args=$2 it=$3 wu=$4 tmo=${5:-400}
  local exe=$BIN/c2_fp_dot_${v}.exe
  local L=$(timeout $tmo $RUN x $it $wu -- $exe $args 2>&1 >/dev/null | grep SUMMARY)
  [ -z "$L" ] && { printf "  %-14s DNF\n" "$v"; return; }
  local med=$(echo "$L"|grep -oE 'median=[0-9.]+'|cut -d= -f2) rsd=$(echo "$L"|grep -oE 'rsd=[0-9.]+'|cut -d= -f2) f=${FL[$v]}
  local net=$(awk -v m=$med -v x=$f 'BEGIN{printf "%.4f",m-x}')
  local out=$($exe $args 2>/dev/null | tr -d '\r\n')
  printf "  %-14s med=%-10s net=%-10s rsd=%-6s out=%s\n" "$v" "$med" "$net" "${rsd}%" "$out"
  echo "C2,$v,\"$args\",$med,$rsd,$f,$net,$out" >> results/c2_native.csv
}
echo "### C2  FP dot product  N=4e8"
T gccO2       400000000 15 4
T gccO3       400000000 15 4
T clangO3     400000000 15 4
T sutraRel    400000000 15 4
T sutraRelNat 400000000 15 4
T sutraX86    400000000 6 2 300
echo "### C2 scaling N=2e8 / 8e8 (gccO3/clangO3/sutraRel/sutraRelNat)"
for N in 200000000 800000000; do
  T gccO3       $N 10 3
  T clangO3     $N 10 3
  T sutraRel    $N 10 3
  T sutraRelNat $N 10 3
done
echo "=== C2-NATIVE DONE ==="
