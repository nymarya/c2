
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return ELSE;} 

if {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return IF;} 

return {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return RETURN;} 

loop {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return LOOP;} 

break {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return BREAK;} 

when {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return WHEN;} 

struct {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return STRUCT;}

print {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return PRINT_FUNCTION;}

input {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return INPUT_FUNCTION;}

malloc {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return MALLOC_FUNCTION;} 

pow {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return POW_FUNCTION;}

free {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return FREE_FUNCTION;} 


    /* TIPOS PRIMITIVOS */

int {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return INT_TYPE;}

float {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return FLOAT_TYPE;}

char {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return CHAR_TYPE;}

void {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return VOID_TYPE;}

bool {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return BOOL_TYPE;}

"string" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return EQUAL;}

"!=" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return AND;}

"||" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return OR;}

"!" {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
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
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return INT;}

{float} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return FLOAT;}

{bool} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return BOOL;}

{STR} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return STRING;}

{ID} {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
char * copy = malloc(strlen(yytext) + 1); 
strcpy(copy, yytext);
yylval.value = copy;
return ID;}

<<EOF>> {yycol = coluna;
coluna+=yyleng;
lin = yylineno;
col = coluna;
return 0;}

. {printf("(%d,%d,LEXICAL_ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%

