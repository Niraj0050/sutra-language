#include <cstdio>
#include <cstdint>
#include <string>
int main(int argc,char**argv){
    // gen.exe words <MB>   |  gen.exe nums <count>  |  gen.exe json <objs>
    std::string mode = argv[1];
    if(mode=="words"){
        long target = atol(argv[2])*1000000L;
        const char* w[] = {"the","quick","brown","fox","lazy","dog","sutra","compiler","benchmark",
            "alpha","beta","gamma","delta","memory","speed","hash","tree","loop","vector","string"};
        uint64_t s=88172645463325252ull; long n=0;
        std::string out; out.reserve(target+64);
        while((long)out.size()<target){ s^=s<<13; s^=s>>7; s^=s<<17; out += w[s%20]; out += ' '; n++; }
        fwrite(out.data(),1,out.size(),stdout);
    } else if(mode=="nums"){
        long c = atol(argv[2]);
        uint64_t s=12345; std::string out; out.reserve(c*8);
        for(long i=0;i<c;i++){ s=s*6364136223846793005ull+1442695040888963407ull;
            out += std::to_string((uint32_t)(s>>33)%1000000); out += '\n'; }
        fwrite(out.data(),1,out.size(),stdout);
    } else if(mode=="json"){
        long c = atol(argv[2]);
        uint64_t s=999; std::string out="[\n"; out.reserve(c*40);
        for(long i=0;i<c;i++){ s=s*6364136223846793005ull+1;
            out += "  {\"id\": "; out += std::to_string(i);
            out += ", \"v\": "; out += std::to_string((uint32_t)(s>>40)%100000);
            out += ", \"f\": "; out += ((s>>7)&1?"true":"false");
            out += "}"; if(i+1<c) out += ","; out += "\n"; }
        out += "]\n";
        fwrite(out.data(),1,out.size(),stdout);
    }
}
