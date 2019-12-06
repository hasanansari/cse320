project = tictac

objs = $(project).o
filesdir = /user/cse320/files
testdir = $(filesdir)/tests/$(project)

CC=gcc
CFLAGS := $(CFLAGS) -Wall -I$(filesdir)/include
CPPFLAGS := $(CPPFLAGS)
LDLIBS := $(LDLIBS) -lm -L$(filesdir)/lib -l320

CLEANEXTS   = o

outputfile  = $(project)

# Default target
.PHONY: all
all: $(outputfile)

$(project): main.o $(objs)
tester: tester.o $(objs)

.PHONY: clean 
clean:
	rm -f $(outputfile)
	rm -f tester
	for file in $(CLEANEXTS); do rm -f *.$$file; done

.PHONY: test
test: tester
	@./tester
	@valgrind --leak-check=yes --suppressions=/user/cse320/files/valgrind.suppress --error-exitcode=1 ./tester

.PHONY: tests
tests: test

tester.o: $(testdir)/tester.c
	gcc -c $(CFLAGS) $(testdir)/tester.c
