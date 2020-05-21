BIN_DIR = ./bin

bits1: bits1.o printb.o printc.o
	gcc -g -o $(BIN_DIR)/bits1 bits1.o printb.o printc.o -no-pie
	

bits1.o: bits1.asm
	nasm -f elf64 -g -F dwarf bits1.asm -l bits1.lst

printb.o: printb.c
	gcc -c printb.c

printc.o: printc.asm
	nasm -f elf64 -g -F dwarf printc.asm -l printc.lst

clean:
	rm *.o *.lst ./bin/bits1

.phony: clean
