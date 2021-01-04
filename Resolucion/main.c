/*
    Trabajo Practico N°4 - Lenguaje Mini (Analizador Sintáctico / Parser con Bison)
        Cuarto Trabajo Practico Sintaxis y Semantica de los Lenguajes - Año 2020 - Curso K2053

    Integrantes
        Lucas Maspero (Legajo 161542-7)
        Franco Nicolás Magne Colque (Legajo 168756-6)
        Natalia Gutiérrez (Legajo 156549-7)
*/

#include <stdio.h>
#include "parser.h"
#include "scanner.h"
extern int yynerrs;

int main() 
{
	switch (yyparse())
	{
		case 0:
			printf("Compilacion terminada con exito\n"); 
			printf("Errores sintacticos: %d - Errores lexicos: %d\n", yynerrs, errlex); 
			return 0;
		case 1:
			printf("Errores de compilacion\n");
			printf("Errores sintacticos: %d - Errores lexicos: %d\n", yynerrs, errlex);
			return 1;
	}
	
	return 0;
}