/**
* Código baseado em: https://eqdrs.github.io/compilers/2019/09/08/implementando-um-analisador-lexico-usando-o-flex.html
*/

digit      [0-9]
letter     [a-zA-Z]
ID         [a-zA-Z][a-zA-Z0-9]*
WHITESPACE [ ]
newline    [\n]
TAB        [\t]

bool       (true)|(false)
float      {digit}+"."{digit}+

%{
    #define YY_DECL extern "C" int yylex()
    #include<string>
    #include<iostream>
    using namespace std;
    FILE *out ;
	int linha;

    int coluna = 1;
%}
%option yylineno
%x COMMENT

%%

{newline} {coluna = 1;}

    /* COMENTÁRIO
     * Inicia estado "COMMENT" no início do bloco de comentario
     * Sai do estado no final do bloco de comentario
     */

"/*" { linha=yylineno; BEGIN(COMMENT);}

<COMMENT>"*/" { BEGIN(INITIAL); }

<COMMENT>(.|\n);

<COMMENT><<EOF>> {fprintf(out,"(%d,ERROR,\"/*\")\n",linha); return 0;}

    /* COMANDOS */

else {fprintf(out,"(%d,%d,ELSE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

if {fprintf(out,"(%d,%d,IF,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

return {fprintf(out,"(%d,%d,RETURN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

loop {fprintf(out,"(%d,%d,LOOP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

break {fprintf(out,"(%d,%d,BREAK,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

when {fprintf(out,"(%d,%d,WHEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

struct {fprintf(out,"(%d,%d,STRUCT,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

print {fprintf(out,"(%d,%d,PRINT_FUNCTION,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

input {fprintf(out,"(%d,%d,INPUT_FUNCTION,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

malloc {fprintf(out,"(%d,%d,MALLOC_FUNCION,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}  

free {fprintf(out,"(%d,%d,FREE_FUNCION,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}  

    /* TIPOS PRIMITIVOS */

int {fprintf(out,"(%d,%d,INT_TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

float {fprintf(out,"(%d,%d,FLOAT_TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

char {fprintf(out,"(%d,%d,CHAR_TYPE\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

void {fprintf(out,"(%d,%d,VOID_TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

bool {fprintf(out,"(%d,%d,BOOL_TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

    /* OPERADORES */

"+" {fprintf(out,"(%d,%d,SUM_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"-" {fprintf(out,"(%d,%d,DIF_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"*" {fprintf(out,"(%d,%d,MULTI_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"/" {fprintf(out,"(%d,%d,DIV_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"%" {fprintf(out,"(%d,%d,MOD_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"<" {fprintf(out,"(%d,%d,LESSER_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"<=" {fprintf(out,"(%d,%d,LEQ_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

">" {fprintf(out,"(%d,%d,GREATER_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

">=" {fprintf(out,"(%d,%d,GEQ_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"==" {fprintf(out,"(%d,%d,EQUAL_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"!=" {fprintf(out,"(%d,%d,DIFF_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"=" {fprintf(out,"(%d,%d,ASSIGN_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"&&" {fprintf(out,"(%d,%d,AND_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"||" {fprintf(out,"(%d,%d,OR_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"!" {fprintf(out,"(%d,%d,NOT_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

    /* SÍMBOLOS */

";" {fprintf(out,"(%d,%d,SEMICOLON,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"," {fprintf(out,"(%d,%d,COLON,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"." {fprintf(out,"(%d,%d,DOT,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"(" {fprintf(out,"(%d,%d,LEFT_PARENTHESIS,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

")" {fprintf(out,"(%d,%d,RIGHT_PARENTHESIS,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"[" {fprintf(out,"(%d,%d,LEFT_BRACKET,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"]" {fprintf(out,"(%d,%d,RIGHT_BRACKET,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"{" {fprintf(out,"(%d,%d,LEFT_BRACE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"}" {fprintf(out,"(%d,%d,RIGHT_BRACE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

    /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;}
 
{digit}+ {fprintf(out,"(%d,%d,INT,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

{float} {fprintf(out,"(%d,%d,FLOAT,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

{bool} {fprintf(out,"(%d,%d,BOOL,\"%s\")\n",yylineno,coluna,yytext); coluna+=yyleng;}

{ID} {fprintf(out,"(%d,%d,ID,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

. {fprintf(out,"(%d,%d,ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%

int yywrap();

int main(int argc, char *argv[]){
    FILE *arquivo = fopen(argv[1],"r");
    if (!arquivo) {
      cout << "Arquivo inexistente" << endl;
      return -1;
    }
    yyin = arquivo;
    out = fopen(argv[2],"w");
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}