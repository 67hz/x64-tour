$(P): $(P).o
	gcc -o $P $(P).o -no-pie


$(P).o: $(P).asm
	nasm -felf64 -g -F dwarf  $(P).asm -l $(P).lst



run:
	P="fcalc" make && ./fcalc
