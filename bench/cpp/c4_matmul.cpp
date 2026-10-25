// C4 — double matmul n×n, C = A·B, i-j-k order. Mirrors the Sutra version:
// integer-valued double inputs so products/sums stay exact in double and the
// checksum is bit-stable across toolchains and summation order. Built with
// -ffp-contract=off so a*b+c is not fused to FMA (matches Sutra's separate
// fmul/fadd float ops).
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cmath>
#include <vector>
#include <windows.h>
int main(int argc,char**argv){
    int n=argc>1?atoi(argv[1]):512;
    std::vector<double> A(n*n),B(n*n),C(n*n,0.0);
    for(int i=0;i<n*n;i++){ A[i]=(double)((i%7)+1); B[i]=(double)((i%5)+1); }
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    for(int i=0;i<n;i++) for(int j=0;j<n;j++){ double a=A[i*n+j];
        for(int k=0;k<n;k++) C[i*n+k]+=a*B[j*n+k]; }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    double chk=0; for(double x:C) chk+=x;
    long long ck=(long long)llround(chk);
    printf("%llu\n",(unsigned long long)(ck & 65535));
    std::_Exit((int)(ck&0xFF));
}
