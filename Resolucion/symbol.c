#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct tablaSimbolos
{
	int indice;
	char* buffer[300];
} tablaDeSimbolos = { .indice = 0 };

void agregarSimbolo(char* simbolo)
{
	tablaDeSimbolos.buffer[tablaDeSimbolos.indice] = simbolo;
	tablaDeSimbolos.indice++;
}

int existeSimbolo(char* simbolo)
{
	for (int i = 0 ; i < tablaDeSimbolos.indice ; i++)
	{
		if (strcmp(tablaDeSimbolos.buffer[i], simbolo) == 0)
		{
			return 1;
		}
	}
	
	return 0;
}
