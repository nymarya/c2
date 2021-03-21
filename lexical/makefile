FILES = mlex.c
CC = g++
CFLAGS = -lfl

Recursivo: lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Recursivo -o test.bin

Tabela: lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Tabela -o test.bin

Lexer.c: lexer.l
	flex lexer.l

run:
	@./test.bin $(file)

clean:
	rm -f *.h test.bin