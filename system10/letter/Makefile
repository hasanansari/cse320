project = letter

objs = $(project).o
filesdir = /user/cse320/files
testdir = $(filesdir)/tests/$(project)

CC=gcc
CFLAGS := $(CFLAGS) -Wall -I$(filesdir)/include -save-temps
CPPFLAGS := $(CPPFLAGS)
LDLIBS := $(LDLIBS) -lm -L$(filesdir)/lib -l320

CLEANEXTS   = o

outputfile  = $(project)

# Default target
.PHONY: all
all: $(outputfile)

$(project): $(objs)

.PHONY: clean 
clean:
	rm -f $(outputfile)
	rm -f tester
	for file in $(CLEANEXTS); do rm -f *.$$file; done
