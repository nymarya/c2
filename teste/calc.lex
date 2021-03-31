
digit      [0-9]
letter     [a-zA-Z]
ID         [a-zA-Z][a-zA-Z0-9]*
WHITESPACE [ ]
newline    [\n]
TAB        [\t]
STR        \"(\\.|[^"\\])*\"

bool       (true)|(false)
float      {digit}+"."{digit}+

%{
 
#include <stdio.h>
#include "y.tab.h"
int c;
extern int yylval;

enum terminal{
        ELSE = 0,
        IF,
        RETURN,
        LOOP,
        BREAK,
        WHEN,
        STRUCT,
        PRINT_FUNCTION,
        INPUT_FUNCTION,
        MALLOC_FUNCTION,
        POW_FUNCTION,
        FREE_FUNCTION,
        INT_TYPE,
        FLOAT_TYPE,
        CHAR_TYPE,
        VOID_TYPE,
        BOOL_TYPE,
        STRING_TYPE,
        SUM_OP,
        DIF_OP,
        MULTI_OP,
        DIV_OP,
        MOD_OP,
        LESSER_OP,
        LEQ_OP,
        GREATER_OP,
        GEQ_OP,
        EQUAL_OP,
        DIFF_OP,
        ASSIGN_OP,
        AND_OP,
        OR_OP,
        NOT_OP,
        SEMICOLON,
        COMMA,
        DOT,
        LEFT_PARENTHESIS,
        RIGHT_PARENTHESIS,
        LEFT_BRACKET,
        RIGHT_BRACKET,
        LEFT_BRACE,
        RIGHT_BRACE,
        INT,
        FLOAT,
        BOOL,
        STRING,
        ID,
        EOFF
    } TERMINAL;

    int coluna = 1;
    int yycol = 0;
%}
%%
" "       ;
     /* OPERADORES */

"+" {yycol = coluna;
coluna+=yyleng;
yylval='+';
return SUM_OP;}

"-" {yycol = coluna;
coluna+=yyleng;
return DIF_OP;}

"*" {yycol = coluna;
coluna+=yyleng;
return MULTI_OP;}

"/" {yycol = coluna;
coluna+=yyleng;
return DIV_OP;}

"%" {yycol = coluna;
coluna+=yyleng;
return MOD_OP;}

"<=" {yycol = coluna;
coluna+=yyleng;
return LEQ_OP;}

"<" {yycol = coluna;
coluna+=yyleng;
return LESSER_OP;}

">=" {yycol = coluna;
coluna+=yyleng;
return GEQ_OP;}

">" {yycol = coluna;
coluna+=yyleng;
return GREATER_OP;}

"==" {yycol = coluna;
coluna+=yyleng;
return EQUAL_OP;}

"!=" {yycol = coluna;
coluna+=yyleng;
return DIFF_OP;}

"=" {yycol = coluna;
coluna+=yyleng;
return ASSIGN_OP;}

"&&" {yycol = coluna;
coluna+=yyleng;
return AND_OP;}

"||" {yycol = coluna;
coluna+=yyleng;
return OR_OP;}

"!" {yycol = coluna;
coluna+=yyleng;
return NOT_OP;}

    /* SÍMBOLOS */

";" {yycol = coluna;
coluna+=yyleng;
return SEMICOLON;}

"," {yycol = coluna;
coluna+=yyleng;
return COMMA;}

"." {yycol = coluna;
coluna+=yyleng;
return DOT;}

"(" {yycol = coluna;
coluna+=yyleng;
return LEFT_PARENTHESIS;}

")" {yycol = coluna;
coluna+=yyleng;
return RIGHT_PARENTHESIS;}

   /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;}
 
{digit}+ {yycol = coluna;
coluna+=yyleng;
c = yytext[0];
yylval = c - '0';
return INT;}

{float} {yycol = coluna;
coluna+=yyleng;
return FLOAT;}

{bool} {yycol = coluna;
coluna+=yyleng;
return BOOL;}

{STR} {yycol = coluna;
coluna+=yyleng;
return STRING;}

{ID} {yycol = coluna;
coluna+=yyleng;
return ID;}

<<EOF>> {yycol = coluna;
coluna+=yyleng;
return EOFF;}


%%