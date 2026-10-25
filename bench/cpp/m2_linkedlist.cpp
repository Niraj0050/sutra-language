#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <windows.h>
struct Node { int64_t v; Node* next; };
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):1000000LL; int R=argc>2?atoi(argv[2]):400;
    Node* head=nullptr;
    for(long long i=0;i<N;i++){ Node* n=new Node{ i%13, head }; head=n; }
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    uint64_t chk=0;
    for(int r=0;r<R;r++){ for(Node* p=head;p;p=p->next) chk+=p->v; }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\n",(unsigned long long)(chk&65535u)); std::_Exit((int)(chk&0xFF));
}
