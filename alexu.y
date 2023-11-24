%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token bgn end id intgr floatt bl pvg cnst aff add sous mult divi equal
	 nbr nbrin nbrfl vg oppar clpar opacc clacc sup supeq inf infeq 
	noequals equals tr fls forr iff els whl doo

%%

S: DEC bgn INST end { printf("syntaxe correcte\n"); YYACCEPT; }
;
DEC: TYPE id NDEC pvg DEC | CONSTANTE DEC | 
;
NDEC:vg id NDEC|
;
CONSTANTE :cnst TYPEI id equal NB pvg  
;
TYPE: intgr|floatt|bl
;
TYPEI: intgr | floatt  
;


INST:  AFF INST | IF_STAT INST | WHILE INST | FOR INST | DOWHILE INST |
;

INSTBLOC: opacc BLOC clacc
;
BLOC:AFF BLOC | IF_STAT BLOC | WHILE BLOC | FOR BLOC | DOWHILE BLOC |
;


WHILE: whl COND INSTBLOC
;
DOWHILE:doo INSTBLOC whl COND pvg
;
FOR: forr FORIN INSTBLOC
;
FORIN:oppar INIT vg CONDI vg CPT clpar
;
INIT:id aff NB 
;



AFF: id aff EXP_ARITHM pvg AFF | id aff AFFNB pvg AFF | id aff id pvg AFF | CPTV AFF |
;
EXP_ARITHM:oppar EXP_ARITH clpar OP EXP_ARITHM
	   | oppar EXP_ARITHM clpar OP EXP_ARITHM
	   | oppar EXP_ARITHM clpar
	   | oppar EXP_ARITH clpar
	   | nbr 
	   | id  
	   | EXP_ARITH
;

EXP_ARITH:id OP id | nbr OP id | nbr OP nbr | id OP nbr 
	  | EXP_ARITH OP nbr | EXP_ARITH OP id | nbr OP EXP_ARITH | id OP EXP_ARITH
;
OP: add | sous | mult | divi
;
AFFNB:BOOLEAN | NB 
;
NB: nbrin | nbrfl |nbr
;



IF_STAT: IF ELSE | IF 
;
IF:iff  COND INSTBLOC
;
ELSE: els INSTBLOC
;
COND:oppar CONDI clpar 
;
CONDI: EXP_LOG | BOOLEAN | id 
;
EXP_LOG:id OPL id | nbr OPL id | nbr OPL nbr | id OPL nbr
;
OPL: sup | supeq | inf | infeq | noequals | equals
;

BOOLEAN:tr | fls
;
CPT: id add add  | id sous sous  | add add id  | sous sous id  
    | id aff id add nbr |id aff id sous nbr
;
CPTV:CPT pvg
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
