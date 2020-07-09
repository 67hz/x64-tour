CC = gcc
CFLAGS = -g
OBJECTS = rect.o sreverse.o asum.o
.SUFFIXES: .lst

all: $(OBJECTS)

%.o: %.asm
	nasm -felf64 -g -F dwarf $< -l $(basename $@).lst


clean:
	rm -f *.o
	rm -f *.lst


.PHONY: clean
