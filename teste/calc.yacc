%{
#include <stdio.h>
int regs[26];
int base;
%}
%token STR INT FLOAT LEFT_PARENTHESIS RIGHT_PARENTHESIS

%left AND_OP OR_OP
%left SUM_OP DIF_OP
%left MULTI_OP DIV_OP MOD_OP
%left UMINUS  /*supplies precedence for unary minus */
%%                   /* beginning of rules section */
lines : lines expr '\n'
{ printf("%g\n", $2); }
| lines '\n'
| /* empty */
;
expr:   p1 | expr OR_OP p1
        {
          $$ = $1 | $3
        };
p1:     p2 | p1 AND_OP p2
         {
           $$ = $1 & $3;
         };
p2:     p5 | p2 SUM_OP p5
         {
           $$ = $1 + $3;
         }
         |
         p2 DIF_OP p5
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
           $$ = $1 \ $3;
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
            $$ = $2
          }
         |
         STR
         {
           $$ = regs[$1];
         }
         |
         INT | FLOAT
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