%{

#include "alexu.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
extern int nb_ligne;
extern int nb_col;
extern bool col;
extern YYSTYPE yylval;
extern void colonnes(int *value,bool* test);
%}

maj [A-Z]
lettre [A-Za-z]
letnmb [a-zA-Z0-9]
nbrfl [-]?[0-9]+[.][0-9]+
nbrin [-]?[0-9]+
idf {maj}[_]?(?:{letnmb}+(?:_{letnmb}+)*)?

%%
BEGIN {printf("look a  \'%s\' \n",yytext);nb_col += yyleng;  return bgn;}
END {printf("look a  \'%s\' \n",yytext);nb_col += strlen(yytext);  return end;}
INT {printf("look a  \'%s\' \n",yytext);nb_col += strlen(yytext); return intgr;}
FLOAT {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return floatt;}
BOOL {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return bl;}
CONST {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return cnst;}
FOR  {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return forr;}
IF  {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return iff;}
ELSE {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return els;}
WHILE {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return whl;}
DO {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return doo;}
{idf} {printf("Idf : %s\n", yytext);nb_col += yyleng;
		if(yyleng<=10) return id;
		else printf("lexical error at line : %d and column : %d \nthe idf :%s is too long ,his length is %d and its superior than 10\n",nb_ligne,nb_col,yytext,yyleng);} 
{nbrin} {printf("look a \'%s\' hey \n",yytext);nb_col += strlen(yytext); return nbrin;}
{nbrfl} {printf("look a \'%s\' yay \n",yytext);nb_col += strlen(yytext); return nbrfl;}

:= {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return aff;}
\+ {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return add;}
\- {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return sous;}
\* {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return mult;}
\/ {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return divi;}
\< {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return inf;}
"<=" {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return infeq;}
\> {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return sup;}
">=" {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return supeq;}
"==" {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return equals;}
"<>" {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return noequals;}
= {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return equal;}
\( {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return oppar;}
\) {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return clpar;}
\{ {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return opacc;}
\} {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext);  return clacc;}
; {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return pvg;}
, {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return vg;}
true  {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return tr;}
false  {printf("look a \'%s\' \n",yytext);nb_col += strlen(yytext); return fls;}
[ \t] { nb_col += yyleng; /* Ignore les espaces et les tabulations */}
\n {nb_ligne++;col=true;colonnes(&nb_col,&col);}
. {printf("lexical error : the character \'%c\' is unknown at line : %d and column : %d \n",yytext[0],nb_ligne,nb_col);return err;}

