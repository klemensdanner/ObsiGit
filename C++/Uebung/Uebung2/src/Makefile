CC = gcc # comiper is gcc
LD = gcc # liker ist auch gcc


# CFLAGS werden automatisch verwendet, ohne Angabe
CFLAGS = -std=c23 -pedantic
CFLAGS += -Wall -Wextra -Wconversion -Wshadow
CFLAGS += -fsanitize=address,leak,undefined
LDFLAGS = -lasan -lubsan


ALL: string test


string: main.o # std regel weiß wie man aus main.c eine main.o baut, und verwendet dabei automatisch die CFLAGS. kann mit -r verhindert werden, dann braucht man eine Regel dafür
	$(LD) -o $@ $^ $(LDFLAGS)

# $@: target name
# $^: alle abhängigkeiten -- alles was nach dem 'string:' steht

test: test.o str.o
	$(LD) -o $@ $^ $(LDFLAGS)


.PHONY: clean # so werden abhängigkeiten im makefile nicht mehr geprüft
clean:
	rm -f string main.o