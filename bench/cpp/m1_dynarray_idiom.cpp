#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <vector>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):10000000LL; int R=argc>2?atoi(argv[2]):10;
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    uint64_t chk=0;
    for(int r=0;r<R;r++){ std::vector<int64_t> v; v.reserve(N);
        for(long long i=0;i<N;i++) v.push_back(i%7);
        chk += v[N-1] + v.size(); }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\n",(unsigned long long)(chk&65535u)); std::_Exit((int)(chk&0xFF));
}
