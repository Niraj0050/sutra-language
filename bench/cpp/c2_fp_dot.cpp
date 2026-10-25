#include <cstdio>
#include <cstdlib>
#include <windows.h>
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):400000000LL;
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    double s=0;
    for(long long i=0;i<N;i++){
        double a=(double)(i%1000);
        double b=(double)((i*7+3)%1000);
        s += a*b;
    }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%.0f\n",s);
    std::_Exit((int)(((long long)s)&0xFF));
}
