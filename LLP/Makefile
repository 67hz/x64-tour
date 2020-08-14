#P=print_rax

$(P): $(P).o
	gcc -ggdb3 -nostdlib -o $@ $< -no-pie
	# ld -o $@ $<

$(P).o: $(P).asm
	nasm -felf64 -ggdb3 -Fdwarf $(P).asm -l $(P).lst

clean:
	rm -f *.o

