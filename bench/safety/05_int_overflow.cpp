#include <cstdio>
#include <cstdlib>
int main(int c,char**v){ int a=c>1?atoi(v[1]):2000000000; int b=a+a+a; printf("%d\n",b); }
