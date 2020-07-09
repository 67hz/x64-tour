
.SUFFIXES: .asm .txt

all: rect.o

rect.o: rect.asm
	nasm -felf64 -g -F dwarf $< -l $@.lst

foo:
	echo Gotcha
