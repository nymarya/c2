FILES = lex.yy.c
CC = g++
CFLAGS = -lfl

test: lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -o test.bin

Lexer.c: lexer.l
	flex lexer.l

run:
	@./test.bin main.c2 main.lex

clean:
	rm -f *.h test.bin