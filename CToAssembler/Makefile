CC = gcc
CFLAGS = -g
OBJECTS = fromc.c rect.o sreverse.o asum.o adouble.o
BIN_DIR = ./bin
.SUFFIXES: .lst

fromc: $(OBJECTS)
	gcc -o $(BIN_DIR)/fromc $^ -no-pie

%.o: %.asm
	nasm -felf64 -g -F dwarf $< -l $(basename $@).lst


clean:
	rm -f *.o
	rm -f *.lst


.PHONY: clean
