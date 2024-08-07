;	Update all of this information to reflect your own details and the prac
;	Author:     Dr J du Toit
;	Template document
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA

NUM1 DWORD 20
NUM2 DWORD 20
ANS DWORD ?


.CODE
_start:
	MOV  EAX , NUM1
	MOV EBX, NUM2
	MUL EBX
	MOV EBX , 10
	DIV EBX
	MOV ANS, EAX
	INVOKE ExitProcess, 0
Public _start
END
