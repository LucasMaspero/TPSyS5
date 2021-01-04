#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"

int contadorDeTemporales;

void declarar(char* id)
{
	printf("Reserve %s,4\n", id);
}

char* proximoTemporal()
{
	char nuevoTemporal[10];
	contadorDeTemporales++;
	sprintf(nuevoTemporal, "Temp#%d", contadorDeTemporales);
	declarar(nuevoTemporal);
	return strdup(nuevoTemporal);
}

void leer(char* id)
{
	printf("Read %s,Integer\n", id);
}

void escribir(char* id)
{
	printf("Write %s,Integer\n", id);
}

char* invertir(char* id)
{
  	char* idSalida;
	idSalida = proximoTemporal();
	printf("NEG %s,,%s\n", id, idSalida);
	return idSalida;
}

char* multiplicar(char* id1, char* id2)
{
	char* idSalida;
	idSalida = proximoTemporal();
	printf("MUL %s,%s,%s\n", id1, id2, idSalida);
	return idSalida;
}

char* sumar(char* id1, char* id2)
{
	char* idSalida;
	idSalida = proximoTemporal();
	printf("ADD %s,%s,%s\n", id1, id2, idSalida);
	return idSalida;
}

char* restar(char* id1, char* id2)
{
	char* idSalida;
	idSalida = proximoTemporal();
	printf("SUB %s,%s,%s\n", id1, id2, idSalida);
	return idSalida;
}

char* dividir(char* id1, char* id2)
{
	char* idSalida;
	idSalida = proximoTemporal();
	printf("DIV %s,%s,%s\n", id1, id2, idSalida);
	return idSalida;
}

void guardar(char* id1, char* id2)
{
	printf("Store %s, %s \n", id1, id2);
}

void iniciar()
{
	printf("Load rtlib,\n");
}

void detener()
{
	printf("Exit ,\n");
}

