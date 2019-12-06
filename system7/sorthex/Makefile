project = sorthex

objs =  $(project).o gethex.o sethex.o
filesdir = /user/cse320/files
testdir = $(filesdir)/tests/$(project)

CC=gcc
CFLAGS := $(CFLAGS) -Wall -I$(filesdir)/include
LDLIBS := $(LDLIBS) -L$(filesdir)/lib -l320

CLEANEXTS   = o

outputfile  = $(project)

# Default target
.PHONY: all
all: $(outputfile)

sorthex: main.o $(objs)
tester: tester.o $(objs)

.PHONY: clean 
clean:
	rm -f $(outputfile)
	rm -f tester
	for file in $(CLEANEXTS); do rm -f *.$$file; done

.PHONY: test
test: tester
	@./tester

.PHONY: tests
tests: test

tester.o: $(testdir)/tester.c
	gcc -c $(CFLAGS) $(testdir)/tester.c

# Indicate dependencies of .ccp files on .h files

