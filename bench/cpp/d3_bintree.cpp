#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <windows.h>
struct Nd { int64_t v; Nd*l; Nd*r; };
int main(int argc,char**argv){
    long long N=argc>1?atoll(argv[1]):1000000LL; int R=argc>2?atoi(argv[2]):20;
    Nd* pool=(Nd*)malloc((size_t)(N+1)*sizeof(Nd));   // pre-sized, no realloc
    size_t pn=0;
    Nd* root=&pool[pn++]; root->v=0; root->l=root->r=nullptr;
    uint64_t b=88172645463325252ull;
    for(long long i=0;i<N;i++){
        b^=b<<13; b^=b>>7; b^=b<<17;
        int64_t v=(int64_t)(b & 1073741823ull);
        Nd* c=root;
        for(;;){
            if(v < c->v){ if(!c->l){ Nd* x=&pool[pn++]; x->v=v; x->l=x->r=nullptr; c->l=x; break; } c=c->l; }
            else        { if(!c->r){ Nd* x=&pool[pn++]; x->v=v; x->l=x->r=nullptr; c->r=x; break; } c=c->r; }
        }
    }
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    uint64_t s=0;
    for(int r=0;r<R;r++){
        // iterative-ish recursion via explicit stack to match Sutra's recursive योगफल? keep simple recursion:
        struct Rec { static int64_t sum(Nd* c){ return c? c->v + sum(c->l) + sum(c->r) : 0; } };
        s += Rec::sum(root);
    }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\n",(unsigned long long)(s&65535u));
    std::_Exit((int)(s&0xFF));
}
