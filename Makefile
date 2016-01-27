ALL=$(patsubst %.s,%,$(wildcard *.s))

all: $(ALL)

%.o: %.s
	as --32 $< -o $@

%: %.o
	ld -m elf_i386 $< -o $@
