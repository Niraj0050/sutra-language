#include <cstdio>
#include <cstdlib>
#include <string>
#include <unordered_map>
#include <windows.h>
int main(int argc,char**argv){
    const char* path = argc>1?argv[1]:"bench/data/words.txt";
    FILE* fp=fopen(path,"rb"); fseek(fp,0,SEEK_END); long sz=ftell(fp); fseek(fp,0,SEEK_SET);
    std::string buf(sz,0); fread(&buf[0],1,sz,fp); fclose(fp);
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    std::unordered_map<std::string,long> cnt;
    size_t i=0,n=buf.size();
    while(i<n){
        while(i<n && buf[i]==' ') i++;
        size_t j=i; while(j<n && buf[j]!=' ') j++;
        if(j>i) cnt[buf.substr(i,j-i)]++;
        i=j;
    }
    long mx=0; for(auto&kv:cnt) if(kv.second>mx) mx=kv.second;
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("distinct=%zu max=%ld\n",cnt.size(),mx);
    std::_Exit((int)(cnt.size()&0xFF));
}
