%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
extern void afficher();
extern void insererType(char entite[], char type[]);
char saveType[20];
int yylex();
int nb_ligne = 1;
int nb_col = 1;
bool col = false;
void yyerror(const char *s);
%}

%union {
    int integer;
    float real;
    char* str;
}

%token bgn end <str>id <str>intgr <str>floatt <str>bl pvg cnst aff add sous mult divi equal
       <integer>nbrin <real>nbrfl vg oppar clpar opacc clacc sup supeq inf infeq 
       noequals equals bol forr iff elif els whl doo err swtch cas pp dflt bk


%%

S: DEC bgn INST end { printf("syntaxe correcte\n"); YYACCEPT; }
;

DEC: DEC DECL | DECL
;

DECL: TYPE IDLIST pvg | CONSTANTE 
;
IDLIST: IDLIST vg id {insererType($3, saveType);}
       | id {insererType($1, saveType);}
;
CONSTANTE: cnst TYPEI id equal NB pvg  {insererType($3, saveType);}
;
TYPE: intgr { strcpy(saveType, yylval.str); } 
     | floatt { strcpy(saveType, yylval.str); } 
     | bl { strcpy(saveType, yylval.str); }
;

TYPEI: intgr { strcpy(saveType, yylval.str); } 
     | floatt { strcpy(saveType, yylval.str); } 
;



INST: AFF INST | IF_STAT INST | WHILE INST | FOR INST | DOWHILE INST | SWITCH_STAT INST |
;
INSTBLOC: opacc BLOC clacc 
;
BLOC: AFF BLOC | IF_STAT BLOC | WHILE BLOC | FOR BLOC | DOWHILE BLOC | SWITCH_STAT BLOC | 
;

WHILE: whl COND INSTBLOC
;
DOWHILE: doo INSTBLOC whl COND pvg
;

SWITCH_STAT: swtch oppar SWTHCOND clpar opacc CASES clacc
;
CASES: cas SWTHCOND pp INST bk pvg CASES | dflt pp INST bk pvg | 
;
SWTHCOND: EXP_ARITHM | nbrin 
;


FOR: forr FORIN INSTBLOC
;
FORIN: oppar INIT vg CONDI vg CPT clpar
;
INIT: id aff IDNB
;

AFF: id aff AFFN pvg | CPTV 
;
AFFN: bol | NB | EXP_ARITHM | id | EXP_LOG
;
EXP_ARITHM:  EXP_ARITH EXP_ARITHM | EXOP
;
EXOP:OP EXP_ID_NB |
;

EXP_ARITH: EXP_ID_NB OP EXP_ID_NB | oppar EXP_ARITH clpar
;
EXP_ID_NB: EXP_ARITH | id | NB 
;
OP: add | sous | mult | divi
;

IF_STAT: IF ELSE
;
IF: iff COND INSTBLOC ELIF
;
ELIF: elif COND INSTBLOC ELIF |
;
ELSE: els INSTBLOC |
;
COND: oppar CONDI clpar 
;
CONDI: EXP_LOG | bol | id 
;
EXP_LOG: BID OPL BID 
;
OPL: sup | supeq | inf | infeq | noequals | equals
;

BID: id | NB | bol | EXP_ARITHM
;
CPT: id CPPT | ADSO id 
;
CPPT: ADSO | aff EXP_ARITHM
;
CPTV: CPT pvg
;


ADSO: add add | sous sous
;
IDNB: id | NB 
;

NB: nbrin | nbrfl | oppar NB clpar
;


%%

int main(){
    yyparse();
    afficher();
}

void yyerror(const char *s) {
    printf("syntax error | line %d and column : %d \n\n", nb_ligne, nb_col);
}
int yywrap() {
    return 1; // Indicate end of input
}
void colonnes(int *value, bool* test){
    if(*test == true){
        *value = 1;
        *test = false;
    }
}
