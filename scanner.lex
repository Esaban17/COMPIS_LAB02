/*%{
	#define BOOL 251
%}*/

true	    [Tt][Rr][Uu][Ee]
false       [Ff][Aa][Ll][Ss][Ee]
and         [Aa][Nn][Dd]
not         [Nn][Oo][Tt]
or          [Oo][Rr]

%%

[ \t]		; { /* Espacios en blanco */ }
{true}	    { yylval = 1; return TRUE; }
{false}	    { yylval = 0; return FALSE; }
{and}       { return AND; }  
{or}        { return OR; } 
{not}       { return NOT; }
[\)\(/\n]   return yytext[0];
.		    printf("Error\n");

%%

int yywrap(void)
{
	return 0;
}

/*main(){
	int token;
	token = yylex();
	while (token){
		printf("%d\n", token);
		token = yylex();
	}
}*/