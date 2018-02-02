ARCH:=ppc64le
CC=gcc -g
FC=gfortran
FFLAGS+=-ff2c -g

libzsvjmp.a: zdojmp.o zsvjmp-$(ARCH).o
	$(AR) cr $@ $^

jmptest: jmptest.o libzsvjmp.a
	$(FC) -o $@ $< -L. -lzsvjmp

zzdebug: zzdebug.o libzsvjmp.a
	$(CC) -g -o $@ $< -L. -lzsvjmp

test: jmptest zzdebug
	./zzdebug
	./jmptest

clean:
	rm -f *.o jmptest zzdebug *.a

