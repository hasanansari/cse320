project = life

objs = main.o setbit.o getbit.o $(project).o
testobjs = tests.o setbit.o getbit.o $(project).o
filesdir = /user/cse320/files
testdir = $(filesdir)/tests/$(project)

CC=gcc
CFLAGS := $(CFLAGS) -I$(filesdir)/usr/include -Wall
LDLIBS := $(LDLIBS) -L$(filesdir)/usr/lib/arm-linux-gnueabihf -lncurses -L$(filesdir)/lib -l320

CLEANEXTS   = o

outputfile  = $(project)

# Default target
.PHONY: all
all: $(outputfile)

$(outputfile): $(objs)
	gcc -o $(outputfile) $(objs) $(LDLIBS)

.PHONY: clean 
clean:
	rm -f $(outputfile)
	rm -f test320
	for file in $(CLEANEXTS); do rm -f *.$$file; done

test320: $(testobjs)
	gcc -o test320 $(testobjs) -L$(filesdir)/lib -l320

.PHONY: test
test: test320
	./test320
	valgrind --leak-check=yes --error-exitcode=1 --suppressions=$(filesdir)/valgrind.suppress ./test320

.PHONY: tests
tests: test
 
tests.o: $(testdir)/tests.c
	gcc -c $(CFLAGS) -I. -I$(filesdir)/include $(testdir)/tests.c

%.prn: %.S
	gcc -c -g -Wa,-a,-ad $< >$@

.PHONY: prn
prn: getbit.prn setbit.prn sierpinski.prn


# Indicate dependencies of .ccp files on .h files

