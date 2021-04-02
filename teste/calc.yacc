%{
#include <stdio.h>
int regs[26];
int base;
%}

/* https://cse.iitkgp.ac.in/~goutam/compiler/lect/lect8.pdf */

%token ELSE IF RETURN LOOP BREAK WHEN STRUCT
%token PRINT_FUNCTION INPUT_FUNCTION MALLOC_FUNCTION POW_FUNCTION FREE_FUNCTION
%token INT_TYPE FLOAT_TYPE CHAR_TYPE VOID_TYPE BOOL_TYPE STRING_TYPE
%token GEQ LEQ EQUAL DIFF AND OR NOT
%token INT FLOAT BOOL STRING ID EOFF

%left OR
%left AND
%left NOT  
%left '+' '-'
%left '*' '/' '%'
%left UMINUS 

%%     

lines : lines expr ';'
      | lines ';'
      | /* empty */
      ;

statements : statement statements | /* empty */ ;
statement  : type ID ';'
           | ID id_stmt
           | '*' ID lval '=' expr ';'
           | PRINT_FUNCTION '(' opt_arguments ')' ':'
           | INPUT_FUNCTION '(' opt_arguments ')' ';'
           | MALLOC_FUNCTION '(' opt_arguments ')' ';'
           | FREE_FUNCTION '(' opt_arguments ')' ';'
           | POW_FUNCTION '(' opt_arguments ')' ';'
           | condition_stmt | loop_stmt | return_stmt ';' | exit_stmt ';' 
           | block /* precisa? */
           ;

id_stmt : lval '=' expr ';' 
        | '(' opt_arguments ')' ';'
        | ID ';'
        ;
      
opt_arguments : arguments | /* empty */ ;
arguments : argument opt_argument;
opt_argument : ',' argument | /* empty */ ;
argument : expr ; /* precisa? */

condition_stmt : IF '(' expr ')' block condition_stmt_opt ;
condition_stmt_opt : ELSE block | /*empty*/ ;
loop_stmt : LOOP block ;
exit_stmt : BREAK WHEN '(' expr ')' ;
return_stmt : RETURN expr;

expr : '(' expr ')'
     | expr '*' expr
     | expr '/' expr
     | expr '%' expr
     | expr '+' expr
     | expr '-' expr
     | expr OR expr
     | expr AND expr
     | expr NOT expr
     | '-' expr %prec UMINUS
     | simple_expr
     ;

simple_expr : INT
            | FLOAT 
            | STRING
            | BOOL
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




