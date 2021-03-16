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
        ID,
        EOFF
    } TERMINAL;


    FILE *out ;
    //int linha;
    int coluna = 1;
    int yycol = 0;
    terminal ct;


    
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

<COMMENT><<EOF>> {fprintf(out,"(%d,ERROR,\"/*\")\n",yylineno); return 0;}


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
return POW_FUNCTION}

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

    /* OPERADORES */

"+" {yycol = coluna;
coluna+=yyleng;
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

"[" {yycol = coluna;
coluna+=yyleng;
return LEFT_BRACKET;}

"]" {yycol = coluna;
coluna+=yyleng;
return RIGHT_BRACKET;}

"{" {yycol = coluna;
coluna+=yyleng;
return LEFT_BRACE;}

"}" {yycol = coluna;
coluna+=yyleng;
return RIGHT_BRACE;}

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

{ID} {yycol = coluna;
coluna+=yyleng;
return ID;}

<<EOF>> {yycol = coluna;
coluna+=yyleng;
return EOFF;}

. {fprintf(out,"(%d,%d,ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%

int yywrap();


/*
int main(int argc, char *argv[]){
    FILE *arquivo = fopen(argv[1],"r");
    if (!arquivo) {
      cout << "Arquivo inexistente" << endl;
      return -1;
    }
    yyin = arquivo;
    out = fopen(argv[2],"w");

    int x = 0;
    
    while(x != -1){

        next_token();
        scanf("%d", &x);
    }
    
    return 0;
}
*/
int yywrap(){
    return 1;
}
