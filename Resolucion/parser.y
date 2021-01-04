%{
	#include <stdio.h>
	#include "scanner.h"
	#include "symbol.h"
	#include "semantic.h"
%}

%code provides {
	extern int errlex; // Cantidad de errores lexicos
	int erroresSemanticos; // Cantidad de errores semanticos
	void errorIdentificadorYaDeclarado(char* id);
	void errorIdentificadorNoDeclarado(char* id);
	void agregarErrorSemantico(char* mensajeErrorInicio, char* id, char* mensajeErrorFin);
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

programa :		PROGRAMA {iniciar();} listaSentencias FINPROG {detener(); if (errlex + erroresSemanticos + yynerrs > 0) YYABORT; else YYACCEPT;};

listaSentencias :	sentencia
			| listaSentencias sentencia;
			
sentencia :		DECLARAR IDENTIFICADOR ';' {if(!existeSimbolo($3)) { declarar($3); agregarSimbolo($3); } else { errorIdentificadorYaDeclarado($3); YYERROR; }}
			| LEER '('listaIdentificadores')' ';'
			| ESCRIBIR '('listaExpresiones')' ';'
			| identificador "<-" expresion ';' {guardar($3, $1);}
			| error';';
			
listaIdentificadores :	identificador {leer($1);}
			| listaIdentificadores',' identificador  {leer($3);};
			
listaExpresiones :	expresion  {escribir($1);}
			| listaExpresiones',' expresion {escribir($3);};
			
expresion :		termino {$$ = $1;}
			| expresion '+' termino {$$ = sumar($1, $3);}
			| expresion '-' termino {$$ = restar($1, $3);};
			
termino :		valor
			| termino '*' valor {$$ = multiplicar($1, $3);}
			| termino '/' valor {$$ = dividir($1, $3);}

valor :		identificador
			| CONSTANTE
			| '('expresion')' {$$ = $2;}
			| '-'valor %prec NEG {$$ = invertir($2);}
			| '(' error ')';

identificador :	IDENTIFICADOR {if(!existeSimbolo($1)) { errorIdentificadorNoDeclarado($1); YYERROR; } else { $$ = $1; }};

%%

// Imprime linea y error donde haya
void yyerror(const char* s) 
{
	printf("En linea #%d %s\n", yylineno, s);
}

void errorIdentificadorYaDeclarado(char* id)
{
	char* mensajeErrorInicio = "Error semantico: identificador ";
	char* mensajeErrorFin = " ya declarado.";
	
	agregarErrorSemantico(mensajeErrorInicio, id, mensajeErrorFin);
}

void errorIdentificadorNoDeclarado(char* id)
{
	char* mensajeErrorInicio = "Error semantico: identificador ";
	char* mensajeErrorFin = " no declarado.";
	
	agregarErrorSemantico(mensajeErrorInicio, id, mensajeErrorFin);
}

void agregarErrorSemantico(char* mensajeErrorInicio, char* id, char* mensajeErrorFin)
{
	char* buffer = malloc(strlen(mensajeErrorInicio) + strlen(id) + strlen(mensajeErrorFin));
	sprintf(buffer, "%s%s%s", mensajeErrorInicio, id, mensajeErrorFin);
	yyerror(buffer);
	erroresSemanticos++;
	free(buffer);
}
