#include <setjmp.h>
jmp_buf buf;
int main() {
    if (setjmp(buf) == 0) {
        return 0;
    }
    return 1;
}
