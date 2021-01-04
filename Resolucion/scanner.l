%top{
	#include <stdio.h>
	#include "parser.h"
	int errlex;
	char auxBuffer[300];
	void yyerror(const char *);
}	

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option noyywrap
%option yylineno

Letra								[[:alpha:]]
Digito								[0-9]
Alfanumerico							[[:alnum:]]
Espacio							[[:space:]]
OperadorAsignacion						<-
Comentario							"##".*
Otros								[[:^alnum:]]{-}[[:space:]\+\-*/;,()]

%%
programa							return PROGRAMA;
fin-prog							return FINPROG;
leer								return LEER;
escribir 							return ESCRIBIR;
declarar							return DECLARAR;
{Letra}{Alfanumerico}*						{yylval = strdup(yytext);return IDENTIFICADOR;}
{Digito}+							{yylval = strdup(yytext);return CONSTANTE;}
"("								return '(';
")"								return ')';
","								return ',';
";"								return ';';
"+"								return '+';
"-"								return '-';
"*"								return '*';
"/"								return '/';
{OperadorAsignacion}						return OPERADOR_ASIGNACION;
{Otros}+							{sprintf(auxBuffer, "Error lexico: cadena desconocida: %s", yytext); yyerror(auxBuffer); errlex++;}
{Letra}{Alfanumerico}*{Otros}+({Alfanumerico}|{Otros})*	{sprintf(auxBuffer, "Error lexico: identificador invalido: %s", yytext); yyerror(auxBuffer); errlex++;}
{Digito}+{Letra}+{Alfanumerico}*				{sprintf(auxBuffer ,"Error lexico: constante invalida: %s", yytext); yyerror(auxBuffer); errlex++;}
{Espacio}+							/* ignorar */
{Comentario}							/* ignorar */
%%