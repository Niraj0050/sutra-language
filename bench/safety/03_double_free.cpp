#include <cstdio>
#include <cstdlib>
int main(){ void* p=malloc(64); free(p); free(p); printf("survived\n"); }
