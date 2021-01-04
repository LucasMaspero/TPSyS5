%{
	#include <stdio.h>
	#include "scanner.h"
%}

%code provides {
	extern int errlex; // Cantidad de errores lexicos
}

%define api.value.type{char *}

%defines "parser.h"
%output "parser.c"
%start programa // Axioma
%define parse.error verbose

%token PROGRAMA DECLARAR LEER ESCRIBIR FINPROG IDENTIFICADOR CONSTANTE
%token OPERADOR_ASIGNACION "<-"

%left '-' '+'
%left '*' '/'
%precedence NEG

%%

programa :		PROGRAMA listaSentencias FINPROG {if (errlex + yynerrs > 0) YYABORT; else YYACCEPT;};

listaSentencias :	sentencia
			| listaSentencias sentencia;
			
sentencia :		DECLARAR IDENTIFICADOR ';' {printf("declarar %s\n", $3);}
			| LEER '('listaIdentificadores')' ';' {printf("leer\n");}
			| ESCRIBIR '('listaExpresiones')' ';' {printf("escribir\n");}
			| IDENTIFICADOR "<-" expresion ';' {printf("asignacion\n");}
			| error';';
			
listaIdentificadores :	IDENTIFICADOR
			| listaIdentificadores',' IDENTIFICADOR;
			
listaExpresiones :	expresion
			| listaExpresiones',' expresion;
			
expresion :		termino
			| expresion '+' termino {printf("suma\n");}
			| expresion '-' termino {printf("resta\n");};
			
termino :		valor
			| termino '*' valor {printf("multiplicacion\n");}
			| termino '/' valor {printf("division\n");};

valor :		IDENTIFICADOR
			| CONSTANTE
			| '('expresion')' {printf("parentesis\n");}
			| '-'valor %prec NEG {printf("inversion\n");}
			| '(' error ')';

%%

// Imprime linea y error donde haya
void yyerror(const char* s) {
	printf("En linea #%d %s\n", yylineno, s);
}