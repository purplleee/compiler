%{

#include "alexu.tab.h"
#include<stdio.h>
int nb_ligne=0;

%}

maj [A-Z]
lettre [A-Za-z]
number [0-9]
idf {maj}[_]?(?:_{lettre}{number}+(?:_{lettre}{number}+)*)? 

%%
"BEGIN" {printf("i found a \'%s\' \n",yytext);return bgn;}
"END" {printf("i found a \'%s\' \n",yytext);return end;}
idf {printf("Identificateur : %s\n", yytext);   return id;} 

[ \t] {/* Ignore les espaces et les tabulations */}

\n {/* Nouvelle ligne détectée, incrémenter le compteur de lignes */ ++nb_ligne;}


int yywrap() {
    return 1; // Indicate end of input
}