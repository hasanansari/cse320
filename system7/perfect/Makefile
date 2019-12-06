project = perfect

objs = $(project).o

CC=gcc
CFLAGS := $(CFLAGS) -Wall

filesdir = /user/cse320/files
LDLIBS := $(LDLIBS) -L$(filesdir)/lib -l320

.PHONY: all
all: $(project)

$(project): $(objs)

.PHONY: clean
clean:
				rm -f $(project)
				rm -f *.o
