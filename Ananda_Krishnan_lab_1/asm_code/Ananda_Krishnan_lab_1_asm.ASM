*
* Lab 1 Part 1 - Write a single assembly language program to calculate the following equation using integer division: Z = (X*8)/Y
* Author: 		Abijith Ananda Krishnan
* Created Date: 01/18/2022
* Compiler: 	ASM51 assembler and Emily52 emulator(run on DosBox)	
* 	
*	
	ORG	$0000		Origin at 0000H
	CLR A		Clear Accumulator
	MOV	A,#06H		Set Accumulator as 06H		
	MOV $20,A		Pushing accumulator value to 20H address location
	MOV B,#03H		Set B register as 0CH
	MOV $22,B		Pushing B register value to 22H address location
	MOV A,B			Move value of B to A for checking for zero condition
	JNZ DIVISORNOTZERO
	LJMP ERRCODE1		Jump to error 
DIVISORNOTZERO	MOV A,$20
	CLR C		Clear Carry bit
	RLC A		Multiply A with 2
	JC ERRCODE2		Check if carrybit is set
	RLC A		Multiply A with 2
	JC ERRCODE2		Check if carry bit is set
	RLC A		Multiply A with 2
	JC ERRCODE2		Check if carry bit is set
	MOV $21,A		Pushing accumulator value to 21H address location
	MOV R0,#00H		Quotient will be stored here
	LJMP DIVISIONLOOP		Jump into Division process
DIVISIONLOOP	SUBB A,B		Subtract A and B
	JZ REMAINDERZERO		If Accumulator is zero, jump to REMAINDERZERO
	JC REMAINDERNEGATIVE		If Accumulator is negative,cary bit is set and jump to REMAINDERNEGATIVE 
	INC R0		Quotient increment
	LJMP DIVISIONLOOP		JUMP to DIVISIONLOOP
REMAINDERZERO	INC R0
	MOV $23,R0		Quotient in accumulator pushed to 23H address location
	MOV $24,A		Remainder A register pushed to 24H address location
	MOV $30,#00H		Store error code 0 in 30H
	LJMP ENDLOOP		Once calculation over, jump into infinite loop
REMAINDERNEGATIVE	MOV $23,R0		Move Quotient to 23H
	ADD A,B		Adding A and B for remainder value
	MOV $24,A		Remainder A register pushed to 24H address location
	MOV $30,#00H		Store error code 0 in 30H
	LJMP ENDLOOP		Once calculation over, jump into infinite loop
ERRCODE1	MOV $30,#01H		Store error code 1 in 30H
	LJMP ENDLOOP		go into infinite loop
ERRCODE2	MOV $30,#02H		Store error code 2 in 30H
	MOV $23,A		Push Z value to 23H address location
	LJMP ENDLOOP		go into infinite loop
INFINITELOOP	LJMP ENDLOOP		go into infinite loop
ENDLOOP	LJMP INFINITELOOP		go into infinite loop