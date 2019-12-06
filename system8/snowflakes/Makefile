project = snowflakes

objs = $(project).o main.o

CC=gcc
CFLAGS := $(CFLAGS) -Wall -mfpu=neon
CPPFLAGS := $(CPPFLAGS) -mfpu=neon
LDLIBS := $(LDLIBS) -lpng -lm

outputfile  = $(project)

.PHONY: all
all: $(project)

$(outputfile): $(objs)
	gcc -o $(outputfile) $(objs) $(LDLIBS)


.PHONY: clean
clean:
	rm -f $(project)
	rm -f *.o
	
%.prn: %.S
	gcc -c -g -Wa,-a,-ad $< >$@

%.prn: %.c
	gcc -c -g -Wa,-a,-ad $< >$@

.PHONY: prn
prn: test.prn
