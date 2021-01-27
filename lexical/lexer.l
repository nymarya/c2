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




else|if|return|loop|break|when|struct {fprintf(out,"(%d,%d,KEY,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;} 

int|float|char|void|bool {fprintf(out,"(%d,%d,TYPE,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

"+"|"-"|"*"|"/"|"<"|"<="|">"|">="|"=="|"!="|"=" {fprintf(out,"(%d,%d,OP,\"%s\")\n",yylineno,coluna,yytext);
coluna+=yyleng;}

";"|","|"."|"("|")"|"["|"]"|"{"|"}" {fprintf(out,"(%d,%d,SYM,\"%s\")\n",yylineno,coluna,yytext);
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