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

char* sts(const char * s){
  char * b = malloc(sizeof(s));
  int sz = sizeof(s)/sizeof(char*);
  for (int i = 0; i < sz; i++){
    strcat(b,cts(s[i]));
  }
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


// loop label
int ll[100];
int cur_label = 0;
int next_valid_label = 0;

%}

%union  
{
  char* value;
}
/* https://cse.iitkgp.ac.in/~goutam/compiler/lect/lect8.pdf */

%token <value> ELSE <value> IF <value> RETURN <value> LOOP <value> BREAK <value> WHEN <value> STRUCT
%token <value> PRINT_FUNCTION <value> INPUT_FUNCTION <value> MALLOC_FUNCTION <value> POW_FUNCTION <value> FREE_FUNCTION
%token <value> INT_TYPE <value> FLOAT_TYPE <value> CHAR_TYPE <value> VOID_TYPE <value> BOOL_TYPE <value> STRING_TYPE
%token <value> GEQ <value> LEQ <value> EQUAL <value> DIFF <value> AND <value> OR <value> NOT
%token <value> INT <value> FLOAT <value> BOOL <value> STRING <value> ID EOFF


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


program : declaration program                   
        | declaration %prec LOWER_THAN_PROGRAM 
        ;

declaration : struct            
            | function          
            | global_statement 
            ;

struct : STRUCT ID {addl($1); addl($2);} struct_block
       ;

struct_block : '{' {addl(cts('{'));} attributes '}' {addl(cts('}')); addl(cts(';'));} 

attributes : attribute attributes
           | /* empty */
           ;

attribute : type ID {addl($2);} ';' {addl(cts(';'));}
          ;

function : type function_id '(' {addl(cts('('));} opt_parameters ')' {addl(cts(')'));} opt_function_block
         ;

opt_function_block : block
                   | ';' {addl(cts(';'));}
                   ;

opt_parameters : parameters
               | /* empty */
               ;

parameters : parameter
           | parameter ',' {addl(cts(','));} parameters
           ;

parameter : type ID {addl($2);}
          ;

block : '{' {addl(cts('{'));} statements '}' {addl(cts('}'));} 
      ;

global_statement : declaration_stmt ';' {addl(cts(';'));}
                 | assign_stmt ';'  {addl(cts(';'));}
                 ;

statements : statement statements
           | /* empty */
           ;

statement  : declaration_stmt ';'   {addl(cts(';'));}
           | assign_stmt ';'        {addl(cts(';'));}
           | function_call_stmt ';' {addl(cts(';'));}
           | condition_stmt         
           | {  int label = next_valid_label; 
                next_valid_label += 1;

                cur_label += 1;
                ll[cur_label] = label;
                

                char * blabel= malloc(1024);
                sprintf(blabel, "b%d:;", label);
                addl(blabel); } loop_stmt
           | return_stmt ';'        {addl(cts(';'));}
           | exit_stmt ';'          {addl(cts(';'));}
           | block
           ;

function_call_stmt : function_id '(' {addl(cts('('));} opt_arguments ')'     {addl(cts(')'));}
                   ;

function_id : ID                      {addl($1);}
            | PRINT_FUNCTION          {addl("printf");}
            | INPUT_FUNCTION          {addl("scanf");}
            | MALLOC_FUNCTION         {addl($1);}
            | FREE_FUNCTION           {addl($1);}
            | POW_FUNCTION            {addl($1);}
            ;
      
opt_arguments : arguments
              | /* empty */
              ;

arguments : argument                                      
          | argument ',' {addl(cts(','));} arguments
          ;

argument : expr
         ; 

declaration_stmt : type ID   {addl($2);}
                 ;

assign_stmt : lval '=' {addl(cts('='));} expr
            ;

condition_stmt : IF '(' expr ')' statement %prec LOWER_THAN_ELSE
               | IF '(' expr ')' statement ELSE statement
               ;

loop_stmt : LOOP  block { int label = ll[cur_label];
                    char * blabel= malloc(1024);
                    char * elabel= malloc(1024);

                    addl("goto");
                    sprintf(blabel, "b%d", label);
                    addl(blabel);
                    addl(cts(';'));
                    sprintf(elabel, "e%d:", label);
                    addl(elabel);

                    addl(cts(';'));


                    cur_label -= 1;}
          ;
exit_stmt : BREAK WHEN { addl("if ("); } '(' expr ')' { 
                                                        addl(") goto");
                                                        int label = ll[cur_label];
                                                        char * elabel= malloc(1024);

                                                        sprintf(elabel, "e%d", label);
                                                        addl(elabel);
                                                        //addl(cts(';'));
                                                        }
          ;

return_stmt : RETURN {addl($1);} expr
            ;

expr : '(' {addl(cts('('));} expr ')'          {addl(cts(')'));}
     | expr '*' {addl(cts('*'));} expr         
     | expr '/' {addl(cts('/'));} expr         
     | expr '%' {addl(cts('%'));} expr             
     | expr '+' {addl(cts('+'));} expr              
     | expr '-' {addl(cts('-'));} expr              
     | expr OR {addl($2);} expr                
     | expr AND {addl($2);} expr               
     | NOT {addl($1);} expr                    
     | expr EQUAL {addl($2);} expr             
     | expr DIFF {addl($2);} expr              
     | expr '<' {addl(cts('<'));} expr         
     | expr '>' {addl(cts('>'));} expr              
     | expr LEQ {addl($2);} expr               
     | expr GEQ {addl($2);} expr               
     | '-' {addl(cts('-'));} expr %prec UMINUS   
     | simple_expr                                         
     ;

lval : ID                                                      {addl($1);}
     | lval '[' {addl(cts('['));} expr ']' %prec LOWER_THAN_X  {addl(cts(']'));}
     | lval '.' {addl(cts('.'));} ID                           {addl($4);} 
     | '*' {addl(cts('*'));} lval
     | '&' {addl(cts('&'));} ID                                {addl($3);}
     ;

simple_expr : literal                     
            | lval                     
            | function_call_stmt       
            ;

literal : INT        {addl($1);}                              
        | FLOAT      {addl($1);}
        | STRING     {addl($1);}
        | BOOL       {addl($1);}
        ;

type : primitive_type
     | ID {addl($1);}  
     | type '*' {addl(cts('*'));}
     ;



primitive_type : INT_TYPE {addl($1);}  
               | FLOAT_TYPE {addl($1);}  
               | BOOL_TYPE {addl($1);}  
               | VOID_TYPE {addl($1);}  
               | STRING_TYPE {addl($1);}  
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
