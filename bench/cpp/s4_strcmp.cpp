#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <string>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):50000000LL;
    std::string tab[5]={"the quick brown fox jumps","the quick brown fox jumpz","the quick brown fox jump0","the quick brown fox jumps","THE QUICK BROWN FOX JUMPS"};
    std::string tgt="the quick brown fox jumps";
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    long long cnt=0;
    for(long long i=0;i<N;i++){ if(tab[i%5]==tgt) cnt++; }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%lld\n",cnt); std::_Exit((int)(cnt&0xFF));
}
