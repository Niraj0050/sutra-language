#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <windows.h>
int main(int argc,char**argv){
    long long N = argc>1? atoll(argv[1]) : 500000000LL;
    LARGE_INTEGER f,a,b; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&a);
    uint64_t s=0, m=1000003;
    for(long long i=0;i<N;i++) s = s*m + (uint64_t)i;
    QueryPerformanceCounter(&b);
    fprintf(stderr,"INPROC %.6f\n", double(b.QuadPart-a.QuadPart)/f.QuadPart);
    printf("%llu\n", (unsigned long long)(s & 65535u));
    std::_Exit((int)(s & 0xFF));
}
