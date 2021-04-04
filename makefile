FILES = lexical/mlex.c
CC = g++
CFLAGS = -lfl

Recursivo: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Recursivo -o Sintatico.bin

Tabela: lexical/lexer.l
	@make Lexer.c
	$(CC) $(CFLAGS) $(FILES) -D Tabela -o Sintatico.bin

Left: y.tab.c lex.yy.c
	@cc y.tab.c lex.yy.c

lex.yy.c: Left/calc.lex
	@lex Left/calc.lex

y.tab.c: Left/calc.yacc
	@yacc -d Left/calc.yacc

Lexer.c: lexical/lexer.l
	flex lexical/lexer.l

run_left:
	@./a.out < $(file)

run:
	@./Sintatico.bin $(file)

clean:
	@rm -f *.h Sintatico.bin *.c *.out