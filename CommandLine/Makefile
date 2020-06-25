EXEC = $(basename $(P))

$(EXEC): $(EXEC).o
	gcc -o $(EXEC) $(EXEC).o -no-pie


$(EXEC).o: $(EXEC).asm
	nasm -felf64 -ggdb3 -F dwarf  $(EXEC).asm -l $(EXEC).lst



