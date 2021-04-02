
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
return ELSE;} 

if {yycol = coluna;
coluna+=yyleng;
return IF;} 

return {yycol = coluna;
coluna+=yyleng;
return RETURN;} 

loop {yycol = coluna;
coluna+=yyleng;
return LOOP;} 

break {yycol = coluna;
coluna+=yyleng;
return BREAK;} 

when {yycol = coluna;
coluna+=yyleng;
return WHEN;} 

struct {yycol = coluna;
coluna+=yyleng;
return STRUCT;}

print {yycol = coluna;
coluna+=yyleng;
return PRINT_FUNCTION;}

input {yycol = coluna;
coluna+=yyleng;
return INPUT_FUNCTION;}

malloc {yycol = coluna;
coluna+=yyleng;
return MALLOC_FUNCTION;} 

pow {yycol = coluna;
coluna+=yyleng;
return POW_FUNCTION;}

free {yycol = coluna;
coluna+=yyleng;
return FREE_FUNCTION;} 


    /* TIPOS PRIMITIVOS */

int {yycol = coluna;
coluna+=yyleng;
return INT_TYPE;}

float {yycol = coluna;
coluna+=yyleng;
return FLOAT_TYPE;}

char {yycol = coluna;
coluna+=yyleng;
return CHAR_TYPE;}

void {yycol = coluna;
coluna+=yyleng;
return VOID_TYPE;}

bool {yycol = coluna;
coluna+=yyleng;
return BOOL_TYPE;}

"string" {yycol = coluna;
coluna+=yyleng;
return STRING_TYPE;}

     /* OPERADORES */

"+" {yycol = coluna;
coluna+=yyleng;
//yylval='+';
return '+';}

"-" {yycol = coluna;
coluna+=yyleng;
//yylval='-';
return '-';}

"*" {yycol = coluna;
coluna+=yyleng;
return '*';}

"/" {yycol = coluna;
coluna+=yyleng;
return '/';}

"%" {yycol = coluna;
coluna+=yyleng;
return '%';}

"<=" {yycol = coluna;
coluna+=yyleng;
return LEQ;}

"<" {yycol = coluna;
coluna+=yyleng;
return '<';}

">=" {yycol = coluna;
coluna+=yyleng;
return GEQ;}

">" {yycol = coluna;
coluna+=yyleng;
return '>';}

"==" {yycol = coluna;
coluna+=yyleng;
return EQUAL;}

"!=" {yycol = coluna;
coluna+=yyleng;
return DIFF;}

"=" {yycol = coluna;
coluna+=yyleng;
return '=';}

"&&" {yycol = coluna;
coluna+=yyleng;
return AND;}

"||" {yycol = coluna;
coluna+=yyleng;
return OR;}

"!" {yycol = coluna;
coluna+=yyleng;
return NOT;}

    /* SÍMBOLOS */

";" {yycol = coluna;
coluna+=yyleng;
return ';';}

"," {yycol = coluna;
coluna+=yyleng;
return ',';}

"." {yycol = coluna;
coluna+=yyleng;
return '.';}

"(" {yycol = coluna;
coluna+=yyleng;
return '(';}

")" {yycol = coluna;
coluna+=yyleng;
return ')';}

"[" {yycol = coluna;
coluna+=yyleng;
return '[';}

"]" {yycol = coluna;
coluna+=yyleng;
return ']';}

"{" {yycol = coluna;
coluna+=yyleng;
return '}';}

"}" {yycol = coluna;
coluna+=yyleng;
return '}';}

   /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;}
 
{digit}+ {yycol = coluna;
coluna+=yyleng;
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

. {printf("(%d,%d,LEXICAL_ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%