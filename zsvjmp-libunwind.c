/*
  Copyright (c) Ole Streicher <debian@liska.ath.cx> 
  Distributable under the same license as IRAF
  This file contains portable version of zsvjmp for use with the libunwind
  library. This code is untested and does not work with recent versions of
  glibc since glibc does not return stack information anymore now.
*/


#include <libunwind.h>
#include <setjmp.h>
#include "jmpbuf.h"

#define XINT long
#define XPOINTER long

int zsvjmp_( XPOINTER *buf, XINT *status )
{
    *status = 0;
    ((XINT **)buf)[0] = status;
    jmp_buf *env = (jmp_buf *)((XINT **)buf+1);
    void **wp = (void **) *env;
    wp[JB_SP] = __builtin_frame_address (0);
    wp[JB_RP] = (void *) __builtin_return_address (0);
    return 0;
}
