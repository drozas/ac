*               SYMBOLS
		ORG	$25000

***************************************
* 1. Declarar Variables (datos)
***************************************
VIA_2		EQU	$60021
ORB		EQU	VIA_2+0
ORA		EQU	VIA_2+2
DDRB		EQU	VIA_2+4
DDRA		EQU	VIA_2+6
T1CL		EQU	VIA_2+8
T1CH		EQU	VIA_2+10
T1LL		EQU	VIA_2+12
T1LH		EQU	VIA_2+14
T2LL		EQU	VIA_2+16
T2CH		EQU	VIA_2+18
SR		EQU	VIA_2+20
ACR		EQU	VIA_2+22
PCR		EQU	VIA_2+24
IFR		EQU	VIA_2+26
IER		EQU	VIA_2+28
ORAE		EQU	VIA_2+30

***************************************
* PROGRAMA PRINCIPAL
***************************************

INICIO		MOVE.B	#$F0,DDRA	
		MOVE.B	#0,D0		
		MOVE.B	#0,D1		


BUCLE_WHILE	MOVE.B	ORA,D0	  *Leo el estado actual de los interruptores(4 bis menos significativos)	
	        ROL #4,D0   
	        CMP.B	#0,D0	  *Comparo si los interruptores estan a cero 	
		BEQ	FIN_PROGRAMA *Si los interruptores estan a cero acaba el programa	
		CMP	D0,D1	  *comparamos estado actual y anterior 	
		BEQ	BUCLE_WHILE
		
		MOVE.B	D0,D1     *Muevo estado actual de interruptores a D1		
		MOVE.B  D1,ORA    *
		
		BRA	BUCLE_WHILE		

FIN_PROGRAMA	MOVE.B	#$00,ORA	
		STOP	#$2000		

         	END		
