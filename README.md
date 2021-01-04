# Trabajo Practico N°5 - Lenguaje Mini (Compilador Completo) (Con generador de código y rutinas semánticas)
Quinto y último Trabajo Practico Sintaxis y Semantica de los Lenguajes - Año 2020 - Curso K2053

## Integrantes
* Lucas Maspero               (Legajo 161542-7)
* Franco Nicolás Magne Colque (Legajo 168756-6)
* Natalia Gutiérrez           (Legajo 156549-7)

## Instalacion
* IDE: **Visual Studio Code**
* Descargar Archivos: "**git clone https://github.com/LucasMaspero/TPSyS5.git**"

## Ejecucion
1) Ubicarse en carpeta Resolucion: "**cd Resolucion**"
2) Ejecutar Flex: "**flex scanner.l**" (recordar hacerlo en la Máquina Virtual de Ubuntu en donde ya esta instalado **flex**)
3) Ejecutar Bison: "**bison parser.y**" (recordar hacerlo en la Máquina Virtual de Ubuntu en donde ya esta instalado **bison**)
4) Compilar: "**gcc -g -Wall \*.c -o tp5 -lfl**"
5) Ejecutar: "**tp5 < ../DatosDePrueba/entradaok.txt >./DatosDePrueba/salidaTP5.txt**"