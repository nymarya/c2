%{


#include "exemplo.tab.h"

%}

digit [0-9]
alpha [a-zA-z]
id [a-z][ alpha _ ]*

number digit+
float digit+.digit+


%%
[ ] { /* Salta espacos em branco */ }

{number} { sscanf(yytext,"%d",&yylval);
return NUMBER;}
\n|. {return yytext[0];}

