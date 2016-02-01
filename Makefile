ALL=$(patsubst %.s,%,$(wildcard *.s))

all: $(ALL)

# this machine uses PIC libraries, so we have to let gcc do its magic here
#   if we're going to call into libc
# without -nostdlib, the CRT's _start will collide with ours, and we'll
#   get confused looking for a main that doesn't exist 
power: power.o
	cc -nostdlib -m32 -lc -o power power.o

%.o: %.s
	as --32 $< -o $@

%: %.o
	ld -m elf_i386 $< -o $@
