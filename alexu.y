%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
extern void afficher();
extern int declaration(char entite[]);
extern void insererType(char entite[], char type[]);
extern void insererConst(char entite[], char valeur[]);
extern void insererVal(char entite[], char val[]);
extern int constVal(char entite[]);
extern int dectype(char entite[]);
extern int Booltest(char val[]);
extern int INTtest(char val[]);
char saveType[20];
char saveConst[20];
char Val[20];
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

%type <str>OP

%token bgn end <str>id <str>intgr <str>floatt <str>bl pvg cnst aff <str>add <str>sous <str>mult <str>divi equal
       <integer>nbrin <real>nbrfl vg oppar clpar opacc clacc sup supeq inf infeq 
       noequals equals <str>bol forr iff elif els whl doo err swtch cas pp dflt bk


%%

S: DEC bgn INST end { printf("syntaxe correcte\n"); YYACCEPT; }
;

DEC: DEC DECL | DECL
;

DECL: TYPE IDLIST pvg | CONSTANTE 
;
IDLIST: IDLIST vg id { if (declaration($3) == 0) 
                          insererType($3, saveType);
                       else printf("semantic error: double declaration of %s at line : %d and column : %d\n",$3,nb_ligne,nb_col); }

       | id { if (declaration($1) == 0) 
                insererType($1, saveType);
              else printf("semantic error: double declaration of %s at line : %d and column : %d\n",$1,nb_ligne,nb_col); }
;
CONSTANTE: cnst TYPEI id equal NB pvg  { if (declaration($3) == 0) insererType($3, saveType);
                                         else {printf("semantic error: double declaration of %s at line : %d and column : %d\n",$3,nb_ligne,nb_col);return err;}
                                         insererConst($3,saveConst);
                                      }

;
TYPE: intgr { strcpy(saveType, $1); } 
     | floatt { strcpy(saveType, $1); } 
     | bl { strcpy(saveType, $1); }
;

TYPEI: intgr { strcpy(saveType, $1); } 
     | floatt { strcpy(saveType, $1); } 
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
INIT: id aff IDNB {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
                        if (constVal($1) == 1){ printf("semantic error: %s has already a value : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
                     }
;

AFF: id aff AFFN pvg {  
            if (constVal($1) == 1){ printf("semantic error: %s has already a value : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
            insererVal($1, saveConst);
			if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
                     

			/*else if ( declaration($1) == 1 && INTtest(Val)== -1 ){
			 printf("semantic error: %s uncompatible type line : %d and column : %d\n",$1,nb_ligne,nb_col);
			return err;}*/

			else  if (dectype($1) == 3){ insererVal($1, Val);
				if( Booltest(Val)== -1 ){
			printf("semantic error: %s uncompatible type line : %d and column : %d\n",$1,nb_ligne,nb_col);
			return err;}}
	                     
			}
	| CPTV 
;
AFFN: bol { strcpy(Val, $1);}
	| NB 
	| EXP_ARITHM 
	| EXP_LOG 
	| id {  if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}}
		
;
EXP_ARITHM:  EXP_ARITH EXP_ARITHM | EXOP
;
EXOP:OP EXP_ID_NB |
;

EXP_ARITH: oppar EXP_ARITH clpar | EXP_ID_NB OP EXP_ID_NB {  if((strcmp($2,"/")==0)&&(saveConst==0)){ 
							  printf("semantic error: divion by 0 line : %d and column : %d\n",nb_ligne,nb_col);
							  return err; }  }
;
EXP_ID_NB: EXP_ARITH | id {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}}
	  | NB 
;
OP: add { strcpy($$, $1);}
   | sous { strcpy($$, $1);}
   | mult { strcpy($$, $1);}
   | divi { strcpy($$, $1);} 
;

IF_STAT: IF ELIF ELSE  
;
IF: iff COND INSTBLOC 
;
ELIF: elif COND INSTBLOC ELIF |
;
ELSE: els INSTBLOC |
;
COND: oppar CONDI clpar 
;
CONDI: EXP_LOG | bol | id {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}}
                           
;
EXP_LOG: BID OPL BID 
;
OPL: sup | supeq | inf | infeq | noequals | equals
;

BID:  NB | bol | EXP_ARITHM | id {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}}
;
CPT: id CPPT {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
               if (constVal($1) == 1){ printf("semantic error: %s has already a value : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}
               }
    | ADSO id {if (declaration($2) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$2,nb_ligne,nb_col);return err;}
               if (constVal($2) == 1){ printf("semantic error: %s has already a value : %d and column : %d\n",$2,nb_ligne,nb_col);return err;}
               }
;
CPPT: ADSO | aff EXP_ARITHM
;
CPTV: CPT pvg
;


ADSO: add add | sous sous
;
IDNB: NB | id {if (declaration($1) == 0){ printf("semantic error: %s undeclared at line : %d and column : %d\n",$1,nb_ligne,nb_col);return err;}} 
;

NB: nbrin { sprintf(saveConst, "%d", $1); } | nbrfl { sprintf(saveConst, "%f", $1); } | oppar NB clpar
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
