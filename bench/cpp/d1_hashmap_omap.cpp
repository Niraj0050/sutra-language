#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <string>
#include <map>
#include <windows.h>
static std::string key(long long i){ long long h=(i*2654435LL)%1000000000LL; return "k"+std::to_string(h); }
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):3000000LL;
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    std::map<std::string,int64_t> m;
    for(long long i=0;i<N;i++) m[key(i)]=i;
    uint64_t s=0;
    for(long long i=0;i<N;i++){ auto it=m.find(key(i)); if(it!=m.end()) s+=it->second; }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\n",(unsigned long long)(s&65535u)); std::_Exit((int)(s&0xFF));
}
