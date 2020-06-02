BIN_DIR = ./bin

bits3: bits3.o printb.o printc.o
	gcc -g -o $(BIN_DIR)/bits3 bits3.o printb.o printc.o -no-pie
	

bits3.o: bits3.asm
	nasm -f elf64 -g -F dwarf bits3.asm -l bits3.lst

printb.o: printb.c
	gcc -c printb.c

printc.o: printc.asm
	nasm -f elf64 -g -F dwarf printc.asm -l printc.lst

clean:
	rm *.o *.lst ./bin/bits3

.phony: clean
