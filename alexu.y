%{
#include<stdio.h>
FILE* yyin;
int main(){
    yyin = fopen("test.txt", "r");
    if (!yyin) {
        fprintf(stderr, "Error opening file\n");
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%token bgn end id


%%

S: DEC bgn INST end{printf("syntaxe correcte"); YYACCEPT;}
;
DEC: id
;
INST: id
;

%%



