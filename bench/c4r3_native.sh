#!/usr/bin/env bash
set -u
cd /c/msys64/tmp/b
BIN=./bin; R=./results
RUN=$BIN/runner.exe
fl(){ timeout 120 $RUN f 30 4 -- $BIN/$1 2>&1 >/dev/null | grep -oE 'median=[0-9.]+'|cut -d= -f2; }
declare -A FL
FL[gccO2]=$(fl empty_gcc_O2.exe);   FL[gccO3]=$(fl empty_gcc_O3.exe)
FL[clangO3]=$(fl empty_clang_O3.exe)
FL[sutraX86]=$(fl empty_sutra_x86.exe); FL[sutraRel]=$(fl empty_sutra_rel.exe)
FL[sutraRelNat]=$(fl empty_sutra_relnative.exe)
echo "floors: g2=${FL[gccO2]} g3=${FL[gccO3]} c=${FL[clangO3]} sx=${FL[sutraX86]} sr=${FL[sutraRel]} srn=${FL[sutraRelNat]}"
echo "row,binbase,variant,args,median,min,max,stddev,rsd,floor,net,output" > $R/c4r3_native.csv
T(){ local row=$1 bb=$2 v=$3 args=$4 it=$5 wu=$6 tmo=${7:-600}
  local exe=$BIN/${bb}_${v}.exe
  [ -x "$exe" ] || { printf "  %-30s MISSING\n" "${bb}_${v}"; return; }
  local L=$(timeout $tmo $RUN x $it $wu -- $exe $args 2>&1 >/dev/null | grep SUMMARY)
  [ -z "$L" ] && { printf "  %-30s DNF>${tmo}s\n" "${bb}_${v}"; echo "$row,$bb,$v,\"$args\",DNF,,,,,,,">>$R/c4r3_native.csv; return; }
  local med=$(echo "$L"|grep -oE 'median=[0-9.]+'|cut -d= -f2)
  local mn=$(echo "$L"|grep -oE 'min=[0-9.]+'|cut -d= -f2)
  local mx=$(echo "$L"|grep -oE 'max=[0-9.]+'|cut -d= -f2)
  local sd=$(echo "$L"|grep -oE 'stddev=[0-9.]+'|cut -d= -f2)
  local rsd=$(echo "$L"|grep -oE 'rsd=[0-9.]+'|cut -d= -f2) f=${FL[$v]}
  local net=$(awk -v m=$med -v x=$f 'BEGIN{printf "%.4f",m-x}')
  local out=$($exe $args 2>/dev/null | tr -d '\r\n')
  printf "  %-30s med=%-10s net=%-10s rsd=%-6s out=%s\n" "${bb}_${v}" "$med" "$net" "${rsd}%" "$out"
  echo "$row,$bb,$v,\"$args\",$med,$mn,$mx,$sd,$rsd,$f,$net,$out">>$R/c4r3_native.csv
}
echo "### C4  double matmul  n=512"
T C4 c4_matmul gccO2       512 25 5
T C4 c4_matmul gccO3       512 25 5
T C4 c4_matmul clangO3     512 25 5
T C4 c4_matmul sutraRel    512 15 3
T C4 c4_matmul sutraRelNat 512 15 3
T C4 c4_matmul sutraX86    512 3 1 900
echo
echo "### R3  array n-body  2M steps"
T R3 r3_nbody gccO2       2000000 20 4
T R3 r3_nbody gccO3       2000000 20 4
T R3 r3_nbody clangO3     2000000 20 4
T R3 r3_nbody sutraRel    2000000 15 3
T R3 r3_nbody sutraRelNat 2000000 15 3
T R3 r3_nbody sutraX86    2000000 3 1 900
echo
echo "### C4 scaling"
for N in 256 512 1024; do
  T C4s$N c4_matmul gccO3       $N 12 3
  T C4s$N c4_matmul clangO3     $N 12 3
  T C4s$N c4_matmul sutraRel    $N 10 3
  T C4s$N c4_matmul sutraRelNat $N 10 3
done
echo
echo "### R3 scaling"
for S in 1000000 2000000 4000000; do
  T R3s$S r3_nbody gccO3       $S 12 3
  T R3s$S r3_nbody clangO3     $S 12 3
  T R3s$S r3_nbody sutraRel    $S 10 3
  T R3s$S r3_nbody sutraRelNat $S 10 3
done
echo "=== C4R3-NATIVE DONE ==="
