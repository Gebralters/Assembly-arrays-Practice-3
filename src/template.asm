;	Author:     LG KAKA

.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

INCLUDE io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA
;<=========================gLOBAL VARIABLES================================>
kernel DWORD ?
bias DWORD ?
array DWORD 4 DUP (?)

strbias   BYTE "Enter the bias:",0
strkernel BYTE "Enter the kernel:",0
strprompt BYTE "Enter the number in the array on index ",0
strcolon  BYTE ":",0
strNL     BYTE 10,0



.CODE
_start:




exitprogram:
	INVOKE ExitProcess, 0
Public _start
END
