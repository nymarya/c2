FILES = lexical/mlex.c
CC = g++
CFLAGS = -lfl

Recursivo: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Recursivo -o Sintatico.bin

Tabela: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Tabela -o Sintatico.bin

Lexer.c: lexical/lexer.l
	flex lexical/lexer.l

run:
	@./Sintatico.bin $(file)

clean:
	rm -f *.h test.bin