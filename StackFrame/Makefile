aligned: aligned.o
	gcc -o aligned aligned.o -no-pie


aligned.o: aligned.asm
	nasm -f elf64 -g -F dwarf aligned.asm -l aligned.lst


clean:
	rm aligned.o aligned.lst aligned

.PHONY: clean


# $(P): $(P).o
# 	gcc -o $P $(P).o -no-pie
#
#
# $(P).o: $(P).asm
# 	nasm -felf64 -g -F dwarf  $(P).asm -l $(P).lst
#


