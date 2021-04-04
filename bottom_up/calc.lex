
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
//extern int yylval;

int coluna = 1;
int yycol = 0;

extern int lin;
extern int col;
%}

%option yylineno
%x COMMENT

%%

{newline} {coluna = 1;}

    /* COMENTÁRIO
     * Inicia estado "COMMENT" no início do bloco de comentario
     * Sai do estado no final do bloco de comentario
     */

"/*" { BEGIN(COMMENT);}

<COMMENT>"*/" { BEGIN(INITIAL); }

<COMMENT>(.|\n);

<COMMENT><<EOF>> { printf("(%d,ERROR,\"/*\")\n", yylineno); return 0; }


    /* COMANDOS */

else {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ELSE;} 

if {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return IF;} 

return {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return RETURN;} 

loop {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return LOOP;} 

break {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return BREAK;} 

when {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return WHEN;} 

struct {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return STRUCT;}

print {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return PRINT_FUNCTION;}

input {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return INPUT_FUNCTION;}

malloc {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return MALLOC_FUNCTION;} 

pow {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return POW_FUNCTION;}

free {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return FREE_FUNCTION;} 


    /* TIPOS PRIMITIVOS */

int {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return INT_TYPE;}

float {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return FLOAT_TYPE;}

char {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return CHAR_TYPE;}

void {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return VOID_TYPE;}

bool {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return BOOL_TYPE;}

"string" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return STRING_TYPE;}

     /* OPERADORES */

"+" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
//yylval='+';
return '+';}

"-" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
//yylval='-';
return '-';}

"*" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '*';}

"/" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '/';}

"%" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '%';}

"<=" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return LEQ;}

"<" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '<';}

">=" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return GEQ;}

">" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '>';}

"==" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return EQUAL;}

"!=" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return DIFF;}

"=" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '=';}

"&&" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return AND;}

"||" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return OR;}

"!" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return NOT;}

    /* SÍMBOLOS */

";" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ';';}

"," {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ',';}

"." {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '.';}

"(" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '(';}

")" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ')';}

"[" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '[';}

"]" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ']';}

"{" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '{';}

"}" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return '}';}

   /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;
lin = yylineno;
col = coluna;}
 
{digit}+ {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return INT;}

{float} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return FLOAT;}

{bool} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return BOOL;}

{STR} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return STRING;}

{ID} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return ID;}

<<EOF>> {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return 0;}

. {printf("(%d,%d,LEXICAL_ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%

