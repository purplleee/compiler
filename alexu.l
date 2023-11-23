%{

#include "alexu.tab.h"
#include <stdio.h>
int nb_ligne=0;

%}

maj [A-Z]
lettre [A-Za-z]
number [0-9]+([.][0-9]+)?
letnmb [a-zA-Z0-9]
nbrfl [-]?[0-9]+[.][0-9]+
nbrin [-]?[0-9]+
idf {maj}[_]?(?:{letnmb}+(?:_{letnmb}+)*)?



%%
BEGIN {printf("found a \'%s\' \n",yytext);  return bgn;}
END {printf("found a \'%s\' \n",yytext);  return end;}
INT {printf("found a \'%s\' \n",yytext);  return intgr;}
FLOAT {printf("found a \'%s\' \n",yytext);  return floatt;}
BOOL {printf("found a \'%s\' \n",yytext);  return bl;}
CONST {printf("found a \'%s\' \n",yytext);  return cnst;}
FOR  {printf("found a \'%s\' \n",yytext); return forr;}
IF  {printf("found a \'%s\' \n",yytext); return iff;}
ELSE {printf("found a \'%s\' \n",yytext); return els;}
WHILE {printf("found a \'%s\' \n",yytext); return whl;}
{idf} {printf("Identificateur : %s\n", yytext);   return id;} 
{number} {printf("found a \'%s\' yay \n",yytext);  return nbr;}
{nbrin} {printf("found a \'%s\' \n",yytext);  return nbrin;}
{nbrfl} {printf("found a \'%s\' \n",yytext);  return nbrfl;}
:= {printf("found a \'%s\' \n",yytext);  return aff;}
\+ {printf("found a \'%s\' \n",yytext);  return add;}
\- {printf("found a \'%s\' \n",yytext);  return sous;}
\* {printf("found a \'%s\' \n",yytext);  return mult;}
\/ {printf("found a \'%s\' \n",yytext);  return divi;}
\< {printf("found a \'%s\' \n",yytext);  return inf;}
"<=" {printf("found a \'%s\' \n",yytext);  return infeq;}
\> {printf("found a \'%s\' \n",yytext);  return sup;}
">=" {printf("found a \'%s\' \n",yytext);  return supeq;}
"==" {printf("found a \'%s\' \n",yytext);  return equals;}
"<>" {printf("found a \'%s\' \n",yytext);  return noequals;}
= {printf("found a \'%s\' \n",yytext);  return equal;}
\( {printf("found a \'%s\' \n",yytext);  return oppar;}
\) {printf("found a \'%s\' \n",yytext);  return clpar;}
\{ {printf("found a \'%s\' \n",yytext);  return opacc;}
\} {printf("found a \'%s\' \n",yytext);  return clacc;}
; {printf("found a \'%s\' \n",yytext); return pvg;}
, {printf("found a \'%s\' \n",yytext); return vg;}
true  {printf("found a \'%s\' \n",yytext); return tr;}
false  {printf("found a \'%s\' \n",yytext); return fls;}
[ \t] {/* Ignore les espaces et les tabulations */}
\n {nb_ligne++;}
. {printf("caractere inconnu %c a la ligne %d\n",yytext[0],nb_ligne);}

