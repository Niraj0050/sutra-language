#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <windows.h>
static int64_t fib(int64_t n){ return n<2? n : fib(n-1)+fib(n-2); }
int main(int argc,char**argv){
    int64_t N = argc>1? atoll(argv[1]) : 35;
    LARGE_INTEGER f,a,b; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&a);
    int64_t r = fib(N);
    QueryPerformanceCounter(&b);
    fprintf(stderr,"INPROC %.6f\n", double(b.QuadPart-a.QuadPart)/f.QuadPart);
    printf("%lld\n",(long long)r);
    std::_Exit((int)(r & 0xFF));
}
