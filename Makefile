ARCH:=$(shell dpkg-architecture -qDEB_BUILD_ARCH)
FC=gfortran
FFLAGS+=-ff2c

libzsvjmp.a: zdojmp.o zsvjmp-$(ARCH).o
	$(AR) cr $@ $^

jmptest: jmptest.o libzsvjmp.a
	$(FC) -o $@ $< -L. -lzsvjmp

zzdebug: zzdebug.o libzsvjmp.a
	$(CC) -o $@ $< -L. -lzsvjmp

test: jmptest zzdebug
	./zzdebug
	./jmptest

clean:
	rm -f *.o jmptest zzdebug *.a

