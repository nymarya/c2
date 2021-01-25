%{
#include <stdio.h>
%}

%token NUMBER
%token FLOAT
%token ID

%token EOL

%%
line : NUMBER \n { printf("%d\n",$1); }
;
%%

int main()
{
  yyparse();
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}