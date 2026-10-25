#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <vector>
#include <algorithm>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):2000000LL;
    std::vector<int64_t> v; v.reserve(N);
    uint64_t b=88172645463325252ull;
    for(long long i=0;i<N;i++){ b^=b<<13; b^=b>>7; b^=b<<17; v.push_back((int64_t)(b & 1073741823ull)); }
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    std::sort(v.begin(),v.end());
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    uint64_t chk=(uint64_t)v[0]+v[N/2]+v[N-1];
    printf("%llu\n",(unsigned long long)(chk&65535u)); std::_Exit((int)(chk&0xFF));
}
