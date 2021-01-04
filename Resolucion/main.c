/*
    Trabajo Practico N°5 - Lenguaje Mini (Compilador completo con generador de codigo y rutinas semanticas)
        Quinto Trabajo Practico Sintaxis y Semantica de los Lenguajes - Año 2020 - Curso K2053

    Integrantes
        Lucas Maspero (Legajo 161542-7)
        Franco Nicolás Magne Colque (Legajo 168756-6)
        Natalia Gutiérrez (Legajo 156549-7)
*/

#include <stdio.h>
#include "parser.h"
#include "scanner.h"
#include "semantic.h"
extern int yynerrs;
extern int erroresSemanticos;

int main() 
{
	switch (yyparse())
	{
		case 0:
			printf("Compilacion terminada con exito\n"); 
			printf("Errores sintacticos: %d - Errores lexicos: %d - Errores semanticos: %d\n", yynerrs, errlex, erroresSemanticos); 
			return 0;
		case 1:
			printf("Errores de compilacion\n");
			printf("Errores sintacticos: %d - Errores lexicos: %d - Errores semanticos: %d\n", yynerrs, errlex, erroresSemanticos);
			return 1;
	}
	
	return 0;
}
