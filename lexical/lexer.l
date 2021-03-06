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
        MALLOC_FUNCION,
        FREE_FUNCION,
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
        COLON,
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
        ID
    } TERMINAL;

    typedef struct{
        int lin;
        int col;
        terminal t;
        char *value; 
    }Token;

    FILE *out ;
    int linha;
    int coluna = 1;
    Token cur_token;

    void create_token(int l, int c, terminal t, char *v){
        Token token;
        token.lin = l;
        token.col = c;
        token.t = t;
        token.value = v;

        cur_token = token;

        fprintf(out, "(%d,%d,%d,%s)\n",l,c,t,v);
    }

    
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
else {create_token(yylineno, coluna, ELSE,yytext);
coluna+=yyleng;
return 50;} 

if {create_token(yylineno, coluna, IF,yytext);
coluna+=yyleng;
return 50;} 

return {create_token(yylineno, coluna, RETURN,yytext);
coluna+=yyleng;
return 50;} 

loop {create_token(yylineno, coluna, LOOP,yytext);
coluna+=yyleng;
return 50;} 

break {create_token(yylineno, coluna, BREAK,yytext);
coluna+=yyleng;
return 50;} 

when {create_token(yylineno, coluna, WHEN,yytext);
coluna+=yyleng;
return 50;} 

struct {create_token(yylineno, coluna, STRUCT,yytext);
coluna+=yyleng;
return 50;}

print {create_token(yylineno, coluna, PRINT_FUNCTION,yytext);
coluna+=yyleng;
return 50;}

input {create_token(yylineno, coluna, INPUT_FUNCTION,yytext);
coluna+=yyleng;
return 50;}

malloc {create_token(yylineno, coluna, MALLOC_FUNCION,yytext);
coluna+=yyleng;
return 50;} 


free {create_token(yylineno, coluna, FREE_FUNCION,yytext);
coluna+=yyleng;
return 50;} 


    /* TIPOS PRIMITIVOS */

int {create_token(yylineno, coluna, INT_TYPE,yytext);
coluna+=yyleng;
return 50;}

float {create_token(yylineno, coluna, FLOAT_TYPE,yytext);
coluna+=yyleng;
return 50;}

char {create_token(yylineno, coluna, CHAR_TYPE,yytext);
coluna+=yyleng;
return 50;}

void {create_token(yylineno, coluna, VOID_TYPE,yytext);
coluna+=yyleng;
return 50;}

bool {create_token(yylineno, coluna, BOOL_TYPE,yytext);
coluna+=yyleng;
return 50;}

    /* OPERADORES */

"+" {create_token(yylineno, coluna, SUM_OP,yytext);
coluna+=yyleng;
return 50;}

"-" {create_token(yylineno, coluna, DIF_OP,yytext);
coluna+=yyleng;
return 50;}

"*" {create_token(yylineno, coluna, MULTI_OP,yytext);
coluna+=yyleng;
return 50;}

"/" {create_token(yylineno, coluna, DIV_OP,yytext);
coluna+=yyleng;
return 50;}

"%" {create_token(yylineno, coluna, MOD_OP,yytext);
coluna+=yyleng;
return 50;}

"<" {create_token(yylineno, coluna, LESSER_OP,yytext);
coluna+=yyleng;
return 50;}

"<=" {create_token(yylineno, coluna, LEQ_OP,yytext);
coluna+=yyleng;
return 50;}

">" {create_token(yylineno, coluna, GREATER_OP,yytext);
coluna+=yyleng;
return 50;}

">=" {create_token(yylineno, coluna, GEQ_OP,yytext);
coluna+=yyleng;
return 50;}

"==" {create_token(yylineno, coluna, EQUAL_OP,yytext);
coluna+=yyleng;
return 50;}

"!=" {create_token(yylineno, coluna, DIFF_OP,yytext);
coluna+=yyleng;
return 50;}

"=" {create_token(yylineno, coluna, ASSIGN_OP,yytext);
coluna+=yyleng;
return 50;}

"&&" {create_token(yylineno, coluna, AND_OP,yytext);
coluna+=yyleng;
return 50;}

"||" {create_token(yylineno, coluna, OR_OP,yytext);
coluna+=yyleng;
return 50;}

"!" {create_token(yylineno, coluna, NOT_OP,yytext);
coluna+=yyleng;
return 50;}

    /* SÍMBOLOS */

";" {create_token(yylineno, coluna, SEMICOLON,yytext);
coluna+=yyleng;
return 50;}

"," {create_token(yylineno, coluna, COLON,yytext);
coluna+=yyleng;
return 50;}

"." {create_token(yylineno, coluna, DOT,yytext);
coluna+=yyleng;
return 50;}

"(" {create_token(yylineno, coluna, LEFT_PARENTHESIS,yytext);
coluna+=yyleng;
return 50;}

")" {create_token(yylineno, coluna, RIGHT_PARENTHESIS,yytext);
coluna+=yyleng;
return 50;}

"[" {create_token(yylineno, coluna, LEFT_BRACKET,yytext);
coluna+=yyleng;
return 50;}

"]" {create_token(yylineno, coluna, RIGHT_BRACKET,yytext);
coluna+=yyleng;
return 50;}

"{" {create_token(yylineno, coluna, LEFT_BRACE,yytext);
coluna+=yyleng;
return 50;}

"}" {create_token(yylineno, coluna, RIGHT_BRACE,yytext);
coluna+=yyleng;
return 50;}

    /* REGEX */

{WHITESPACE}+|{newline}|{TAB}+ {coluna+=yyleng;}
 
{digit}+ {create_token(yylineno, coluna, INT,yytext);
coluna+=yyleng;
return 50;}

{float} {create_token(yylineno, coluna, FLOAT,yytext);
coluna+=yyleng;
return 50;}

{bool} {create_token(yylineno, coluna, BOOL,yytext);
coluna+=yyleng;
return 50;}

{ID} {create_token(yylineno, coluna, ID,yytext);
coluna+=yyleng;
return 50;}

. {fprintf(out,"(%d,%d,ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;}

%%

int yywrap();

void next_token(){
    yylex();
    //printf("Current token is: %s\n",cur_token.value);
}
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
