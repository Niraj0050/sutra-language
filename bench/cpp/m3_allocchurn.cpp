#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):1000000LL; int R=argc>2?atoi(argv[2]):6;
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    uint64_t chk=0;
    for(int r=0;r<R;r++) for(long long i=0;i<N;i++){
        int64_t* p=(int64_t*)malloc(3*sizeof(int64_t));
        p[0]=i; p[1]=i+1; p[2]=i+2; chk+=p[1]; free(p);
    }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\n",(unsigned long long)(chk&65535u)); std::_Exit((int)(chk&0xFF));
}
