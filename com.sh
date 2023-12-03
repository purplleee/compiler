flex alexu.l
bison -d alexu.y
gcc lex.yy.c alexu.tab.c -lfl -ll