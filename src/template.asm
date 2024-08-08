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
stropenbracket  BYTE "[",0
strclosebracket  BYTE "]",10,0
strcomma  BYTE ",",0
strNL     BYTE 10,0



.CODE
_start:

 INVOKE OutputStr, ADDR strbias
 INVOKE InputInt
 mov bias, exitprogram

 INVOKE OutputStr, ADDR strkernel
 INVOKE InputInt
 mov kernel, exitprogram

 mov ecx, 0
  mov eax, 0
InputA:
   INVOKE OutputStr, ADDR strprompt
   INVOKE OutputInt, ecx
   INVOKE OutputStr, ADDR strcolon
   
   lea     ebx , array
   imul    eax, ecx,4
   add     ebx, eax
   
   INVOKE InputInt
   mov [ebx], eax
   INVOKE OutputStr, ADDR strNL
   inc ecx
   cmp ecx, 4
   jl InputA

  mov ecx,0
  mov eax,0
  INVOKE OutputStr, ADDR stropenbracket
Outputloop:
  INVOKE OutputStr, ADDR stropenbracket
    lea     ebx , array
   imul    eax, ecx,4
   add     ebx, eax

   INVOKE OutputInt, [ebx]
   INVOKE Output,ADDR strcomma

   inc ecx
   cmp ecx, 4
   jl Outputloop

   INVOKE OutputStr, ADDR strclosebracket

exitprogram:
	INVOKE ExitProcess, 0
Public _start
END
