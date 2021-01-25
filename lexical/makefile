FILES = lex.yy.c exemplo.tab.c
CC = gcc
CFLAGS = -lfl

test: input.l exemplo.y
	@make Lexer.c
	@make Parser.c
	$(CC) $(CFLAGS) $(FILES) -o test

Lexer.c: lexer.l
	flex lexer.l

Parser.c: exemplo.y 
	bison -d exemplo.y

clean:
	rm -f *.h test