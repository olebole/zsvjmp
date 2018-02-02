#include <stdio.h>
#include <stdlib.h>


void zsvjmp_(void*, volatile long *);
void zdojmp_(void*, volatile long *);

int main(void) {
    long jmpbuf[180];
    volatile long status = 9;
    volatile long step = 0;
    zsvjmp_((void *)jmpbuf, &status);
    printf("Status = %li, step = %li\n", status, step);
    if (status == 0) {
	if (step == 1) {
	    printf("Error: Called zsvjmp a second time\n");
	    exit(3);
	}
	step = 1;
	printf("Calling zdojmp\n");
	zdojmp_((void *)jmpbuf, &status);
	printf("Error: return from zdojmp\n");
	exit(1);
    }
    if (step == 0) {
	printf("Error: zsvjmp was not called successfully\n");
	exit(2);
    }
    printf("All OK\n");
    exit (0);
}


