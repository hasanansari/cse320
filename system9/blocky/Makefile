project = blocky

objs = $(project).o main.o image.o readimage.o writeimage.o
filesdir = /user/cse320/files

CC=gcc
CFLAGS := $(CFLAGS) -Wall -mfpu=neon -I$(filesdir)/include
CPPFLAGS := $(CPPFLAGS) -mfpu=neon
LDLIBS := $(LDLIBS) -lpng -lm -L$(filesdir)/lib -l320

outputfile  = $(project)

.PHONY: all
all: $(project)

$(outputfile): $(objs)
	gcc -o $(outputfile) $(objs) $(LDLIBS)

.PHONY: clean
clean:
	rm -f $(project)
	rm -f *.o

main.o:	image.h

leakcheck:	$(outputfile)
	valgrind --leak-check=yes ./blocky
	
