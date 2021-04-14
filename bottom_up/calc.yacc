%{
#include <stdio.h>
int regs[26];
int base;

int lin, col;

/*
struct code{
  char* text;
  code * next;
}
*/

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
%left EQUAL DIFF
%left '<' '>' GEQ LEQ 
%left '+' '-'
%left '*' '/' '%'
%left UMINUS 

%nonassoc LOWER_THAN_PROGRAM
%nonassoc PROGRAM

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%nonassoc LOWER_THAN_X
%nonassoc '['
%nonassoc '.'

%start program
%%     


program : declaration program                   /* program1.cs := declaration.cs || program2.cs */
        | declaration %prec LOWER_THAN_PROGRAM  /* program1.cs := declaration.cs */
        ;

declaration : struct            /* declaration.cs := stuct.cs */
            | function          /* declaration.cs := function.cs */
            | global_statement  /* declaration.cs := global_statement.cs */
            ;

struct : STRUCT ID struct_block /* struct.cs := STRUCT || ID || struct_block.cs */
       ;

struct_block : '{' attributes '}' /* struct_block.cs := '{' || attributes.cs || '}' */

attributes : attribute attributes
           | /* empty */
           ;

attribute : type ID ';'
          ;

function : type function_id '(' opt_parameters ')' block
         ;

opt_parameters : parameters
               | /* empty */
               ;

parameters : parameter
           | parameter ',' parameters
           ;

parameter : type ID
          ;

block : '{' statements '}' /* statements.ss = block.sh + 1; block.cs =  '{' || statements.cs || '}' */
      ;

global_statement : declaration_stmt ';'
                 | assign_stmt ';'
                 ;

statements : statement statements 
           | /* empty */ 
           ;

statement  : declaration_stmt ';'
           | assign_stmt ';'
           | function_call_stmt ';'
           | condition_stmt
           | loop_stmt | return_stmt ';' | exit_stmt ';' 
           | block /* precisa? */
           ;

function_call_stmt : function_id '(' opt_arguments ')'
                   ;

function_id : ID 
            | PRINT_FUNCTION 
            | INPUT_FUNCTION 
            | MALLOC_FUNCTION 
            | FREE_FUNCTION 
            | POW_FUNCTION 
            ;
      
opt_arguments : arguments 
              | /* empty */ 
              ;

arguments : argument 
          | argument ',' arguments
          ;

argument : expr 
         ; /* empty */

declaration_stmt : type ID 
                 ;

assign_stmt : lval '=' expr 
            ;

condition_stmt : IF '(' expr ')' statement %prec LOWER_THAN_ELSE
               | IF '(' expr ')' statement ELSE statement
               ;

loop_stmt : LOOP block 
          ;

exit_stmt : BREAK WHEN '(' expr ')' 
          ;

return_stmt : RETURN expr
            ;

expr : '(' expr ')'
     | expr '*' expr
     | expr '/' expr
     | expr '%' expr
     | expr '+' expr
     | expr '-' expr
     | expr OR expr
     | expr AND expr
     | NOT expr
     | expr EQUAL expr
     | expr DIFF expr
     | expr '<' expr
     | expr '>' expr
     | expr LEQ expr
     | expr GEQ expr
     | '-' expr %prec UMINUS
     | simple_expr
     ;

lval : ID
     | lval '[' expr ']' %prec LOWER_THAN_X
     | lval '.' ID
     | '*' lval
     ;

simple_expr : literal
            | lval
            | function_call_stmt
            ;

literal : INT
        | FLOAT 
        | STRING
        | BOOL
        ;

type : primitive_type
     | ID
     | type '*'
     ;



primitive_type : INT_TYPE { printf("oi"); }
               | FLOAT_TYPE
               | BOOL_TYPE
               | VOID_TYPE
               | STRING_TYPE
               ;

%%

extern FILE *yyin;

int main (int argc, char *argv[])
{
  int x = yyparse(); 
  if (x == 0)
    printf("Sucess!\n");
  else
    printf("Error!\n");

}
int yyerror(s)
char *s;
{
  fprintf(stderr, "%s at (%d,%d)\n",s,lin,col);
}
int yywrap()
{
  return(1);
}




