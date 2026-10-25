// R3 — 5-body (Sun + 4 giants), pos/vel/mass in arrays with a nested pair loop,
// mirroring the Sutra version exactly (which now stores दशमलव in सूची).
// -ffp-contract=off at build time so no FMA — matches Sutra's separate
// mul/add float ops. Pair order (i<j): 01 02 03 04 12 13 14 23 24 34.
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cmath>
#include <windows.h>

int main(int argc,char**argv){
    long long STEPS = argc>1 ? atoll(argv[1]) : 500000;
    const int N = 5;
    double dt = 0.01;

    double x[N]  = {0.0, 4.841431, 8.343367, 12.894369, 15.379697};
    double y[N]  = {0.0, -1.160320, 4.124798, -15.111151, -25.919314};
    double z[N]  = {0.0, -0.103622, -0.403523, -0.223308, 0.179259};
    double vx[N] = {0.0, 0.606326, -1.010774, 1.082791, 0.979091};
    double vy[N] = {0.0, 2.811986, 1.825485, 0.868989, 0.594699};
    double vz[N] = {0.0, -0.020252, 0.008415, -0.010832, -0.034756};
    double m[N]  = {39.478417, 0.037693, 0.011286, 0.001723, 0.002033};

    LARGE_INTEGER f,t0,t1; QueryPerformanceFrequency(&f); QueryPerformanceCounter(&t0);
    for(long long t=0;t<STEPS;t++){
        for(int i=0;i<N;i++){
            for(int j=i+1;j<N;j++){
                double dx = x[i]-x[j];
                double dy = y[i]-y[j];
                double dz = z[i]-z[j];
                double d2 = dx*dx + dy*dy + dz*dz;
                double mag = dt/(d2*sqrt(d2));
                double mi = m[i];
                double mj = m[j];
                vx[i] -= dx*mj*mag;  vy[i] -= dy*mj*mag;  vz[i] -= dz*mj*mag;
                vx[j] += dx*mi*mag;  vy[j] += dy*mi*mag;  vz[j] += dz*mi*mag;
            }
        }
        for(int i=0;i<N;i++){
            x[i] += dt*vx[i];
            y[i] += dt*vy[i];
            z[i] += dt*vz[i];
        }
    }
    QueryPerformanceCounter(&t1);
    fprintf(stderr,"INPROC %.6f\n", double(t1.QuadPart-t0.QuadPart)/f.QuadPart);
    double s = 0.0;
    for(int i=0;i<N;i++) s += x[i]+y[i]+z[i];
    long long chk = (long long)llround(s*1000000.0);
    printf("%lld\n", chk);
    std::_Exit((int)(chk & 0xFF));
}
