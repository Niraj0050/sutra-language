#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <vector>
#include <windows.h>
int main(int argc,char**argv){
    long long N = argc>1? atoll(argv[1]) : 10000000LL;
    LARGE_INTEGER f,a,b; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&a);
    std::vector<uint8_t> c(N+1, 1);
    c[0]=0; if(N>=1) c[1]=0;
    for(long long p=2; p*p<=N; p++) if(c[p]) for(long long j=p*p;j<=N;j+=p) c[j]=0;
    long long cnt=0; for(long long i=0;i<=N;i++) cnt+=c[i];
    QueryPerformanceCounter(&b);
    fprintf(stderr,"INPROC %.6f\n", double(b.QuadPart-a.QuadPart)/f.QuadPart);
    printf("%lld\n",cnt);
    std::_Exit((int)(cnt & 0xFF));
}
