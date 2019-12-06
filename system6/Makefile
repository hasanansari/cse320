project = sieve

objs = $(project).o

CC=gcc
CFLAGS := $(CFLAGS) -Wall

.PHONY: all
all: $(project)

$(project): $(objs)

.PHONY: clean
clean:
				rm -f $(project)
				rm -f *.o
