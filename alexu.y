%{
int main(){
yyin = fopen("text.txt","r");
yylex();
return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%token bgn end 


%%

S:  bgn  end {printf("syntaxe correcte"); YYACCEPT;}
;

%%



