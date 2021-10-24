%{
	#include <ctype.h>
	#include <stdio.h>
	#include <stdlib.h>
	#define YYSTYPE double /* double type for Yacc stack */
	
	extern int yylex();
	void yyerror(char *msg);
%}

/* if ($2 >= 1) { printf("TRUE\n"); exit(0); } else{ printf("FALSE\n"); exit(0); } */
/* printf("%g\n", $2) ; */

%token AND
%token NOT
%token OR 
%token TRUE
%token FALSE

%%

lines	: lines bexpr '\n' 		{ if ($2 == 1) { printf("TRUE (%g)\n", $2); exit(0); } else{ printf("FALSE (%g)\n", $2); exit(0); } }
		| lines '\n'
		| /* empty */
		;

bexpr	: bexpr OR bterm		{ $$ = $1 || $3 }
		| bterm					{ $$ = $1 }
		;
		
bterm	: bterm AND bfactor		{ $$ = $1 && $3 }
		| bfactor				{ $$ = $1 }
		;

bfactor : NOT bfactor			{ $$ = !$2 }
		| '(' bexpr ')'			{ $$ = $2 }
		| TRUE					{ $$ = 1 }
		| FALSE					{ $$ = 0 }
		;
%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}