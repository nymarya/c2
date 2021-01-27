FILES = lex.yy.c
CC = g++
CFLAGS = -lfl

test:
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -o test

Lexer.c: lexer.l
	flex lexer.l

run:
	@./test main.c main.lex

clean:
	rm -f *.h test