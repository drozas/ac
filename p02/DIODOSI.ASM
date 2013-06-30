*                SYMBOLS
 		ORG	$2000

***************************************
* ZONA DE DATOS GLOBALES DEL PROGRAMA
***************************************
VIA_1		EQU	$60021
ORB		EQU	VIA_1+0
ORA		EQU	VIA_1+2
DDRB		EQU	VIA_1+4
DDRA		EQU	VIA_1+6
T1CL		EQU	VIA_1+8
T1CH		EQU	VIA_1+10
T1LL		EQU	VIA_1+12
T1LH		EQU	VIA_1+14
T2LL		EQU	VIA_1+16
T2CH		EQU	VIA_1+18
SR		EQU	VIA_1+20
ACR		EQU	VIA_1+22
PCR		EQU	VIA_1+24
IFR		EQU	VIA_1+26
IER		EQU	VIA_1+28
ORAE		EQU	VIA_1+30

***************************************
* PROGRAMA PRINCIPAL
***************************************

*Configuro la VIA
INICIO		MOVE.B	#$11,PCR	*Activamos los bits 0 y 4 introduciendo un 1, para que se active por flanco de subida
		MOVE.B	#$82,IER	*Configuración de IER: ponemos un 1 en el bit 7 (hace que se pongan a 1 todos los bits de IER que tengan un uno en el byte) y otro en el bit 1 (para CA1)
		
		MOVE.B	#$0,D2		*Iniciamos los bits menos significativos de D2 a 0
BUCINF		ADDQ.L	#1,D2		*Hacemos una operacion de suma
		MOVE.L	#0,D2		*Y volvemos a iniciar a 0, para evitar problemas de desbordamiento.
		BRA 	BUCINF
		STOP	#$2000		
***************************************
* TRATAMIENTO DE LA SUBRUTINA
***************************************

INTER		MOVE.B	#$F0,DDRA       *Los bits del 0 al 3 son de entrada, y los del 4 al 7 de salida (a los leds)
		MOVEM.L	D0-D7,-(A7)	*Salvaguardamos los datos en la pila
		MOVE.B	#0,D1		*Movemos 0 a D1
                MOVE.B  #0,D0           *Y 0 a D0
		MOVE.B	ORA,D0		*Leemos el estado de los conmutadores
		BCLR	#7,D0		*Borrado de los bits del 4 al 7 de D0
		BCLR	#6,D0
		BCLR	#5,D0
		BCLR	#4,D0
		MOVE.B	#0,D1		*Movemos 0 a los bits de menor peso de D1
		MOVE.B	D0,D1		*Movemos D0 a D1
		ROL	#4,D1		*Rotación
                MOVE.B  D1,ORA          *Salida en ORA del contenido (a los leds)
		MOVEM.L	(A7)+,D0-D7	*Restituimos los valores salvaguardados en la pila
		RTE			*Vuelta de la subrutina
                END
