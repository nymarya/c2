%{
#include <stdio.h>
int regs[26];
int base;
%}

/* https://cse.iitkgp.ac.in/~goutam/compiler/lect/lect8.pdf */

%union {        /* type of ’yylval’ (stack type) */
  int integer; /* type name is YYSTYPE */
  float real;  /* default #define YYSTYPE int ple type */
}

%token INT FLOAT /* tokens and types */

%token STR LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token EQUAL_OP LEQ_OP LESSER_OP GEQ_OP GREATER_OP DIFF_OP ASSIGN_OP
%token NOT_OP
%token SEMICOLON COMMA DOT EOFF BOOL STRING ID

%left OR_OP
%left AND_OP  
%left SUM_OP DIF_OP
%left MULTI_OP DIV_OP MOD_OP
%left UMINUS  /*supplies precedence for unary minus */
%%                   /* beginning of rules section */
lines : lines expr ';'
| lines ';'
| /* empty */
;
expr : '(' expr ')' { printf ("(%s)", $2); }
     | expr MULTI_OP expr
     | expr DIV_OP expr
     | expr MOD_OP expr
     | expr SUM_OP expr
     | expr DIF_OP expr
     | expr AND_OP expr
     | expr OR_OP expr
     | DIF_OP expr %prec UMINUS
     | simple_expr
     ;
simple_expr : INT
            | FLOAT 
            ;
%%
main()
{
 return(yyparse());
}
yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}


/*

simple_expr : STR { $$ = regs[$1]; }
            | INT {$$ = (float) $1;}
            | FLOAT 
            | BOOL {$$ = $1;}
            ;

expr : LEFT_PARENTHESIS expr RIGHT_PARENTHESIS { $$ = $2; }
     | expr MULTI_OP expr { $$ = $1 * $3; }
     | expr DIV_OP expr { $$ = $1 / $3; }
     | expr MOD_OP expr { $$ = $1 % $3; }
     | expr SUM_OP expr { $$ = $1 + $3; }
     | expr DIF_OP expr { $$ = $1 - $3; }
     | expr AND_OP expr { $$ = $1 & $3; }
     | expr OR_OP expr { $$ = $1 | $3; }
     | DIF_OP expr %prec UMINUS { $$ = -$2; }
     | simple_expr

*/


