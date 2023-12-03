%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int yylex();
int nb_ligne=1;
int nb_col=1;
bool col=false;
void yyerror(const char *s);
%}
%union {
	int integer ;
	float real;
	char* str;
}
%token bgn end id intgr floatt bl pvg cnst aff add sous mult divi equal
	nbrin nbrfl vg oppar clpar opacc clacc sup supeq inf infeq 
	noequals equals tr fls forr iff els whl doo err

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
AFFNB:BOOLEAN | NB
;
EXP_ARITHM:oppar EXP_ARITH clpar OP EXP_ARITHM
	   | oppar EXP_ARITHM clpar OP EXP_ARITHM
	   | oppar EXP_ARITHM clpar
	   | oppar EXP_ARITH clpar
	   | NB
	   | id  
	   | EXP_ARITH
;
EXP_ARITH:id OP id | NB OP id | NB OP NB | id OP NB 
	  | EXP_ARITH OP NB | EXP_ARITH OP id | NB OP EXP_ARITH | id OP EXP_ARITH
;
OP: add | sous | mult | divi
;



IF_STAT: IF ELSE | IF 
;
IF:iff COND INSTBLOC
;
ELSE: els INSTBLOC
;
COND:oppar CONDI clpar 
;
CONDI: EXP_LOG | BOOLEAN | id 
;
EXP_LOG:id OPL id | NB OPL id | NB OPL NB | id OPL NB
;
OPL: sup | supeq | inf | infeq | noequals | equals
;

BOOLEAN:tr | fls
;
CPT: id add add  | id sous sous  | add add id  | sous sous id  
    | id aff id add NB |id aff id sous NB
;
CPTV:CPT pvg
;

NB: nbrin | nbrfl | oppar nbrin clpar | oppar nbrfl clpar
;


%%

int main(){
yyparse();
}

void yyerror(const char *s) {
    printf("syntax error | line %d and column : %d \n\n",nb_ligne,nb_col);
}
int yywrap() {
    return 1; // Indicate end of input
}
void colonnes(int *value,bool* test){
	if(*test==true){
	*value=1;
	*test=false;
	}
}



