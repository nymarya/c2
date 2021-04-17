%{
#include <stdio.h>
#include <string.h>//necessário para strcat
#include <stdarg.h>
int regs[26];
int base;

int lin, col;

typedef struct Code{
  char* text;
  struct Code * next;
}Code;

Code* begin_list;

Code* current;



void addList(Code* curr, char* word)
{
  if(begin_list == NULL)
  {
    Code* novo_code = (Code *) malloc(sizeof(struct Code));
    novo_code->text = word;

    begin_list = novo_code;
    current = novo_code;
  }
  else
  {
    Code* new_code = (Code *) malloc(sizeof(struct Code));
    new_code->text = word;

    curr->next = new_code;
    current = curr->next;
  }
}

void addl(char * word){
  addList(current,word);
}

void printList()
{
  Code* iter = begin_list;

  printf("Printing list: [ ");
  while(iter != NULL)
  {
    printf("%s ", iter->text);
    iter = iter->next;
  }
  printf("]\n");
}

char* cts(char c){
  char *b = malloc(sizeof(c)); 
  *b = c;
  return b;
}

char* concat(int size, ...){
  va_list valist;
  va_start(valist, size);

  int out_size = 0;
  char* outv;

  for (int i = 0; i < size; i++) {
    out_size += sizeof(va_arg(valist, char *));
  }

  outv = malloc(out_size);

  for (int i = 0; i < size; i++) {
    strcat(outv,va_arg(valist, char *));
  }


  va_end(valist);

  return outv;
}

%}

%union  
{
  char* value;
}
/* https://cse.iitkgp.ac.in/~goutam/compiler/lect/lect8.pdf */

%token ELSE IF RETURN LOOP BREAK WHEN STRUCT
%token PRINT_FUNCTION INPUT_FUNCTION MALLOC_FUNCTION POW_FUNCTION FREE_FUNCTION
%token INT_TYPE FLOAT_TYPE CHAR_TYPE VOID_TYPE BOOL_TYPE STRING_TYPE
%token <value> GEQ <value> LEQ <value> EQUAL <value> DIFF <value> AND <value> OR <value> NOT
%token <value> INT <value> FLOAT <value> BOOL <value> STRING <value> ID EOFF

%type <value> expr lval simple_expr literal function_call_stmt

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

expr : '(' {addl(cts('('));} expr ')'        {addl(cts(')')); $$ = concat(3,cts('('),$3,cts(')'));}
     | expr '*' {addl(cts('*'));} expr       {$$ = concat(3,$1,cts('*'),$4);}
     | expr '/' {addl(cts('/'));} expr       {$$ = concat(3,$1,cts('/'),$4);}
     | expr '%' {addl(cts('%'));} expr       {$$ = concat(3,$1,cts('%'),$4);}      
     | expr '+' {addl(cts('+'));} expr       {$$ = concat(3,$1,cts('%'),$4);}      
     | expr '-' {addl(cts('-'));} expr       {$$ = concat(3,$1,cts('-'),$4);}      
     | expr OR {addl($2);} expr              {$$ = concat(3,$1,$2,$4);}
     | expr AND {addl($2);} expr             {$$ = concat(3,$1,$2,$4);}
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

lval : ID                                      {$$ = $1; addl($1);}
//     | lval '[' expr ']' %prec LOWER_THAN_X
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
  if (x == 0){
    printf("Sucess!\n");
    printList();
  }
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
