#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <string>
#include <vector>
#include <windows.h>
int main(int argc,char**argv){
    const char* path=argc>1?argv[1]:"bench/data/nums.txt";
    FILE* fp=fopen(path,"rb"); fseek(fp,0,SEEK_END); long sz=ftell(fp); fseek(fp,0,SEEK_SET);
    std::string buf(sz,0); fread(&buf[0],1,sz,fp); fclose(fp);
    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    std::vector<std::string> lines;
    size_t i=0,n=buf.size();
    while(i<n){ size_t j=buf.find('\n',i); if(j==std::string::npos) j=n; lines.push_back(buf.substr(i,j-i)); i=j+1; }
    uint64_t s=0; long cnt=0;
    for(auto& ln: lines){ if(!ln.empty()){ uint64_t v=0; for(char c: ln) if(c>='0'&&c<='9') v=v*10+(c-'0'); s+=v; } cnt++; }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n",double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    printf("%llu\nlines=%ld\n",(unsigned long long)(s&65535u),cnt);
    std::_Exit((int)(s&0xFF));
}
