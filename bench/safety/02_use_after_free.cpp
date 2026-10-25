#include <cstdio>
#include <cstdlib>
int main(){ int* p=(int*)malloc(64); free(p); p[0]=123; printf("%d\n",p[0]); }
