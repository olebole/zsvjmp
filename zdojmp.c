/* Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.
 */

#include <setjmp.h>

//#define DOJMP_ORIG

/* ZDOJMP -- Restore the saved processor context (non-local goto).  See also
 * as$zsvjmp.s, where most of the work is done.
 */
void zdojmp_ (long *jmpbuf, long *status) {
    int stat = *status ? *status : 1;
    long *status_ptr = ((long **)jmpbuf)[0];
    void *jb = (long **)jmpbuf+1;
    *status_ptr = stat;
    siglongjmp (jb, stat);
}
