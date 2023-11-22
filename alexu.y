%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token bgn end id intgr floatt bl pvg cnst aff add sous mult divi nbr nbrsign coma tr fls forr iff els whl

%%

S: DEC bgn INST end { printf("syntaxe correcte\n"); YYACCEPT; }
;
DEC: TYPEI id pvg DEC | 
;
TYPEI: cnst intgr | cnst floatt | TYPE  
;
TYPE: intgr|floatt|bl
;



INST: AFF
;
NB: nbr | nbrsign
;
AFF: id aff EXP_ARITHM pvg AFF | id aff NB pvg AFF |
;
EXP_ARITHM:id OP id | NB OP id | NB OP NB | id OP NB
;
OP: add | sous | mult | divi
;


%%

int main(){
yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int yywrap() {
    return 1; // Indicate end of input
}