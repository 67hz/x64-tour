$(P): $(P).o
	gcc -o $P $(P).o -no-pie


$(P).o: $(P).asm
	nasm -felf64 -ggdb3 -F dwarf  $(P).asm -l $(P).lst

clean:
	rm -f *.o


