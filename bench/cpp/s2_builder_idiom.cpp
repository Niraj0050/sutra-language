#include <cstdio>
#include <cstdlib>
#include <string>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):10000000LL;
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    std::string s; s.reserve(N);
    for(long long i=0;i<N;i++) s.push_back('x');
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%zu\n",s.size()); std::_Exit((int)(s.size()&0xFF));
}
