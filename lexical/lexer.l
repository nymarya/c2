digit[0-9]
letter[a-zA-Z]
ID[a-zA-Z][a-zA-Z0-9]*
WHITESPACE[ ]
quebra[\n]
TAB[\t]

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

{quebra} {coluna = 1;}

"/*" { linha=yylineno; BEGIN(COMMENT);}

<COMMENT>"*/" { BEGIN(INITIAL); }

<COMMENT>(.|\n);

<COMMENT><<EOF>> {fprintf(out,"(%d,ERROR,\"/*\")\n",linha); return 0;}




else|if|return|loop|break|when|struct|printf {fprintf(out,"(%d,%d,KEY,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

int|float|char|void|bool {fprintf(out,"(%d,%d,TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"+" {fprintf(out,"(%d,%d,SUM_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"-" {fprintf(out,"(%d,%d,DIF_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"*" {fprintf(out,"(%d,%d,MULTI_OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"/" {fprintf(out,"(%d,%d,DIV_OP,\"%s\")\n",yylineno,coluna,yytext);
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

";" {fprintf(out,"(%d,%d,SEMICOLON_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"," {fprintf(out,"(%d,%d,COLON_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"." {fprintf(out,"(%d,%d,DOT_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"(" {fprintf(out,"(%d,%d,LEFT_PARENTHESIS_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

")" {fprintf(out,"(%d,%d,RIGHT_PARENTHESIS_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"[" {fprintf(out,"(%d,%d,LEFT_BRACKET_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"]" {fprintf(out,"(%d,%d,RIGHT_BRACKET_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"{" {fprintf(out,"(%d,%d,LEFT_BRACE_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"}" {fprintf(out,"(%d,%d,RIGHT_BRACE_TOKEN,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

{WHITESPACE}+|{quebra}|{TAB}+ {coluna+=yyleng;}
 
{digit}+ {fprintf(out,"(%d,%d,NUM,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

{digit}+{ID}+ {fprintf(out,"(%d,%d,ERROR,\"%s\")\n",yylineno,coluna,yytext); return 0;
coluna+=yyleng;}

{ID}+ {fprintf(out,"(%d,%d,ID,\"%s\")\n",yylineno,coluna,yytext);
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