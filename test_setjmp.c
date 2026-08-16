#include <setjmp.h>

jmp_buf buf;

int test() {
    if (setjmp(buf) == 0) {
        return 1;
    }
    return 0;
}
