P=print_rax

$(P): $(P).o
	ld -o $@ $<

$(P).o: $(P).asm
	nasm -felf64 -ggdb3 -Fdwarf $(P).asm -l $(P).lst

