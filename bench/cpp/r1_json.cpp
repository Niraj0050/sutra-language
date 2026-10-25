// Minimal recursive-descent JSON parser that builds a value tree (same work
// as Sutra's जेसन_पार्स), then sums every "v" field. Not a production parser
// but it fully tokenises and allocates a node per value, matching the Sutra
// stdlib parser's approach.
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <string>
#include <vector>
#include <memory>
#include <windows.h>

struct Val {
    int kind; // 0 null,1 bool,2 num,3 str,4 arr,5 obj
    bool b = false;
    int64_t num = 0;
    std::string str;
    std::vector<std::unique_ptr<Val>> arr;
    std::vector<std::pair<std::string,std::unique_ptr<Val>>> obj;
};

struct Parser {
    const char* s;
    const char* e;
    void ws(){ while(s<e && (*s==' '||*s=='\t'||*s=='\n'||*s=='\r')) s++; }
    std::string pstr(){
        s++; // opening quote
        std::string r;
        while(s<e && *s!='"'){
            if(*s=='\\'){ s++; if(s<e){ char c=*s++;
                switch(c){ case 'n': r.push_back('\n'); break; case 't': r.push_back('\t'); break;
                           case '"': r.push_back('"'); break; case '\\': r.push_back('\\'); break;
                           default: r.push_back(c); } } }
            else r.push_back(*s++);
        }
        s++; // closing quote
        return r;
    }
    std::unique_ptr<Val> pval(){
        ws();
        auto v = std::make_unique<Val>();
        char c = *s;
        if(c=='"'){ v->kind=3; v->str=pstr(); }
        else if(c=='{'){ v->kind=5; s++; ws();
            while(s<e && *s!='}'){
                ws(); std::string k=pstr(); ws(); s++; /* colon */
                v->obj.emplace_back(std::move(k), pval());
                ws(); if(s<e && *s==',') s++; ws();
            }
            s++;
        }
        else if(c=='['){ v->kind=4; s++; ws();
            while(s<e && *s!=']'){
                v->arr.push_back(pval());
                ws(); if(s<e && *s==',') s++; ws();
            }
            s++;
        }
        else if(c=='t'){ v->kind=1; v->b=true; s+=4; }
        else if(c=='f'){ v->kind=1; v->b=false; s+=5; }
        else if(c=='n'){ v->kind=0; s+=4; }
        else { v->kind=2; bool neg=false; if(*s=='-'){neg=true;s++;}
            int64_t n=0; while(s<e && *s>='0' && *s<='9'){ n=n*10+(*s-'0'); s++; }
            v->num = neg? -n : n;
        }
        return v;
    }
};

static uint64_t sumV(const Val* v){
    uint64_t s=0;
    if(v->kind==4) for(auto& x: v->arr) s += sumV(x.get());
    else if(v->kind==5) for(auto& kv: v->obj){ if(kv.first=="v" && kv.second->kind==2) s += (uint64_t)kv.second->num; else s += sumV(kv.second.get()); }
    return s;
}
static long countObj(const Val* v){
    long c=0;
    if(v->kind==4) for(auto& x: v->arr) c += countObj(x.get());
    else if(v->kind==5){ c=1; for(auto& kv: v->obj) c += countObj(kv.second.get()); }
    return c;
}

int main(int argc,char**argv){
    const char* path = argc>1 ? argv[1] : "bench/data/data.json";
    FILE* fp=fopen(path,"rb"); fseek(fp,0,SEEK_END); long sz=ftell(fp); fseek(fp,0,SEEK_SET);
    std::string buf(sz,0); fread(&buf[0],1,sz,fp); fclose(fp);
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    Parser p{ buf.data(), buf.data()+buf.size() };
    auto root = p.pval();
    uint64_t sv = sumV(root.get());
    long co = countObj(root.get());
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n", double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("count=%ld sumv=%llu\n", co, (unsigned long long)(sv & 65535u));
    std::_Exit((int)(sv & 0xFF));
}
