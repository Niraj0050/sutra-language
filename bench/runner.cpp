#include <windows.h>
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <cmath>
#include <string>
static double qs(LARGE_INTEGER a, LARGE_INTEGER b, LARGE_INTEGER f){
    return double(b.QuadPart - a.QuadPart) / double(f.QuadPart);
}
int main(int argc, char** argv){
    if (argc < 5){ fprintf(stderr,"usage: runner <label> <iters> <warmup> -- <exe> [args...]\n"); return 2; }
    std::string label = argv[1];
    int iters = atoi(argv[2]), warmup = atoi(argv[3]);
    int ci = 5; std::string cmd;
    for (int i = ci; i < argc; i++){ if (i>ci) cmd += " ";
        std::string a = argv[i];
        if (a.find(' ')!=std::string::npos) cmd += "\""+a+"\""; else cmd += a; }
    LARGE_INTEGER freq; QueryPerformanceFrequency(&freq);
    HANDLE nul = CreateFileA("NUL", GENERIC_WRITE, FILE_SHARE_WRITE|FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    DWORD_PTR mask = 4; // core 2
    std::vector<double> ts; int total = warmup + iters;
    for (int r = 0; r < total; r++){
        STARTUPINFOA si; ZeroMemory(&si,sizeof si); si.cb = sizeof si;
        si.dwFlags = STARTF_USESTDHANDLES; si.hStdOutput = nul; si.hStdError = nul; si.hStdInput = NULL;
        PROCESS_INFORMATION pi; ZeroMemory(&pi,sizeof pi);
        std::vector<char> cb(cmd.begin(), cmd.end()); cb.push_back(0);
        LARGE_INTEGER a,b; QueryPerformanceCounter(&a);
        if (!CreateProcessA(NULL, cb.data(), NULL, NULL, TRUE,
                CREATE_SUSPENDED|HIGH_PRIORITY_CLASS, NULL, NULL, &si, &pi)){
            fprintf(stderr,"CreateProcess failed (%lu)\n", GetLastError()); return 3; }
        SetProcessAffinityMask(pi.hProcess, mask);
        SetPriorityClass(pi.hProcess, HIGH_PRIORITY_CLASS);
        ResumeThread(pi.hThread);
        WaitForSingleObject(pi.hProcess, INFINITE);
        QueryPerformanceCounter(&b);
        DWORD ec=0; GetExitCodeProcess(pi.hProcess,&ec);
        CloseHandle(pi.hProcess); CloseHandle(pi.hThread);
        double s = qs(a,b,freq);
        if (r >= warmup){ ts.push_back(s); printf("%s,%d,%.9f,%lu\n", label.c_str(), r-warmup, s, ec); }
    }
    std::sort(ts.begin(), ts.end());
    double med = ts.size()%2 ? ts[ts.size()/2] : (ts[ts.size()/2-1]+ts[ts.size()/2])/2.0;
    double mean=0; for(double x:ts) mean+=x; mean/=ts.size();
    double var=0; for(double x:ts) var+=(x-mean)*(x-mean); var/=ts.size();
    double sd=std::sqrt(var);
    fprintf(stderr,"SUMMARY %s median=%.6f min=%.6f max=%.6f stddev=%.6f rsd=%.2f%% n=%zu\n",
        label.c_str(), med, ts.front(), ts.back(), sd, 100.0*sd/med, ts.size());
    return 0;
}
