%{

#include "alexu.tab.h"
#include<stdio.h>
int nb_lg=0;

%}

%%
"BEGIN" {printf("i found a \'%s\' \n",yytext);return bgn;}
"END" {printf("i found a \'%s\' \n",yytext);return end;}



\n {nb_lg++; }
%%

int yywrap() {
    return 1; // Indicate end of input
}