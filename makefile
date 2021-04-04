FILES = lexical/mlex.c
CC = g++
CFLAGS = -lfl

Left: y.tab.c lex.yy.c
	@cc y.tab.c lex.yy.c

Recursivo: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Recursivo -o Sintatico.bin

Tabela: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Tabela -o Sintatico.bin

lex.yy.c: bottom_up/calc.lex
	@lex bottom_up/calc.lex

y.tab.c: bottom_up/calc.yacc
	@yacc -d bottom_up/calc.yacc

Lexer.c: lexical/lexer.l
	flex lexical/lexer.l

run_bottom_up:
	@./a.out < $(file)

run:
	@./Sintatico.bin $(file)

clean:
	@rm -f *.h Sintatico.bin *.c *.out