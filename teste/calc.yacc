%{
#include <stdio.h>
int regs[26];
int base;
%}
%token STR INT FLOAT LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token EQUAL_OP LEQ_OP LESSER_OP GEQ_OP GREATER_OP DIFF_OP ASSIGN_OP
%token NOT_OP
%token SEMICOLON COMMA DOT EOFF BOOL STRING ID

%left OR_OP
%left AND_OP  
%left SUM_OP DIF_OP
%left MULTI_OP DIV_OP MOD_OP
%left UMINUS  /*supplies precedence for unary minus */
%%                   /* beginning of rules section */
lines : lines expr '\n' { printf("%d\n", $2); }
| lines '\n'
| /* empty */
;
expr:   p1 | expr OR_OP p1
        {
          $$ = $1 | $3;
        }
        ;
p1:     p2 | p1 AND_OP p2
         {
           $$ = $1 & $3;
         }
         ;
p2:     p3 | NOT_OP p2 {$$ = ! $2;};

p3:     p4 | p3 EQUAL_OP p4
        {
          $$ = $1 == $3; 
        }
        |
         p3 DIFF_OP p4
        {
          $$ = $1 != $3; 
        }
        |
        p3 LESSER_OP p4
        {
          $$ = $1 < $3; 
        }
        |
        p3 LEQ_OP p4
        {
          $$ = $1 <= $3; 
        }
        |
        p3 GREATER_OP p4
        {
          $$ = $1 > $3; 
        }
        |
        p3 GEQ_OP p4
        {
          $$ = $1 >= $3; 
        };

p4:     p5 | p4 SUM_OP p5
         {
           $$ = $1 + $3;
         }
         |
         p4 DIF_OP p5
         {
           $$ = $1 - $3;
         };
p5 :     p6 | p5 MULTI_OP p6
         {
           $$ = $1 * $3;
         }
         |
         p5 DIV_OP p6
         {
           $$ = $1 / $3;
         }
          |
         p5 MOD_OP p6
         {
           $$ = $1 % $3;
         };
p6:       p7 |  '-' p6 %prec UMINUS
         {
           $$ = -$2;
         }
         ;
p7:      LEFT_PARENTHESIS expr RIGHT_PARENTHESIS
          {
            $$ = $2;
          }
         |
         STR | INT {$$ = $1;}| FLOAT {$$ = $1;}| BOOL{$$ = $1;}
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