ARCH:=$(shell dpkg-architecture -qDEB_BUILD_ARCH)
FC=gfortran
FFLAGS+=-ff2c

libzsvjmp.a: zdojmp.o zsvjmp.o
	$(AR) cr $@ $^

zsvjmp.s: zsvjmp-$(ARCH).s
	ln -sf $< $@

jmptest: jmptest.o libzsvjmp.a
	$(FC) -o $@ $< -L. -lzsvjmp

zzdebug: zzdebug.o libzsvjmp.a
	$(CC) -o $@ $< -L. -lzsvjmp

test: jmptest zzdebug
	./zzdebug
	./jmptest

clean:
	rm -f *.o zsvjmp.s jmptest zzdebug *.a

