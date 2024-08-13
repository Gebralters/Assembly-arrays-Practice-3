.386
.MODEL FLAT        ; Flat memory model
.STACK 4096        ; Define stack size

INCLUDE io.inc
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

.DATA
; Declaring variables and strings for prompts and outputs
I     DWORD 8 DUP (?)           ; Array to store heart rate inputs
age   DWORD  ?                  ; Variable to store age
str1   BYTE "Enter your age:",0 ; Prompt for age input
strNL  BYTE 10,0                ; Newline string
strcolon BYTE ":",0             ; Colon string
strarray BYTE "Enter your heart rate ",0 ; Prompt for heart rate input
strProgstatus BYTE "Enter 0 to continue or any number to exit program:",0 ; Program status prompt
strInputarray BYTE "InputArray is:",0 ; Display for input array
strOutputarray  BYTE "OutputArray is:",0 ; Display for output array
strcomma  BYTE  ",",0           ; Comma string
strnone  BYTE "none",10,0       ; Intensity level string
strlight  BYTE "light",10,0     ; Intensity level string
strmoderate  BYTE "moderate",10,0 ; Intensity level string
strvigorous  BYTE "vigorous",10,0 ; Intensity level string
agenum   DWORD  ?               ; Variable to store calculated max heart rate
strintensity BYTE "Intensity is:",0

.CODE
_start:
	; Get user's age and calculate max heart rate
	INVOKE OutputStr, ADDR str1
	INVOKE InputInt
	mov age, eax
	INVOKE OutputStr, ADDR strNL

    mov eax, 220
	sub eax, age               ; Max heart rate = 220 - age
    mov agenum, eax

	; Loop to input heart rates into array I
    mov ecx, 0
arrayinput1:
	INVOKE OutputStr, ADDR strarray
	INVOKE OutputInt, ecx
	INVOKE OutputStr, ADDR strcolon

	lea ebx, I
	imul eax, ecx, 8           ; Calculate offset for array index
	add ebx, eax

	INVOKE InputInt
	mov [ebx], eax              ; Store input in array

    inc ecx
    cmp ecx, 8 
	jl arrayinput1             ; Repeat until 8 inputs are collected

	; Display the input array
	INVOKE OutputStr, ADDR strInputarray
    mov ecx, 0
inputarray:
    lea ebx, I
	imul eax, ecx, 8
	add ebx, eax
    INVOKE OutputInt, [ebx]    ; Output each element of the array

	cmp ecx, 7
	je constinue               ; Skip comma after last element
    INVOKE OutputStr, ADDR strcomma

    constinue:
	inc ecx
    cmp ecx, 8 
	jl inputarray              ; Loop to output all array elements

	; Display the output array (heart rate/intensity)
	mov ecx, 0
	INVOKE OutputStr, ADDR strNL
	INVOKE OutputStr, ADDR strOutputarray
outputarray:
	lea ebx, I
    imul eax, ecx, 8
    add ebx, eax
    
	mov edx, 0
	mov eax, [ebx]
	
	cdq                         ; Extend sign of eax into edx for division
	idiv [agenum]               ; Divide heart rate by max heart rate
	
	INVOKE OutputInt, eax       ; Output result

	cmp ecx, 7
	je continue
    INVOKE OutputStr, ADDR strcomma

    continue:
	inc ecx
    cmp ecx, 8 
	jl outputarray             ; Repeat for all elements

	; Determine intensity based on heart rate
	INVOKE OutputStr, ADDR strNL
none:
	INVOKE OutputStr, ADDR strintensity
	INVOKE OutputStr, ADDR strnone
	jmp programstatus
light:
	INVOKE OutputStr, ADDR strintensity
	INVOKE OutputStr, ADDR strlight
	jmp programstatus
moderate:
	INVOKE OutputStr, ADDR strintensity
	INVOKE OutputStr, ADDR strmoderate
	jmp programstatus
vigorous:
	INVOKE OutputStr, ADDR strintensity
	INVOKE OutputStr, ADDR strvigorous

	; Check if the user wants to continue or exit
programstatus:
	INVOKE OutputStr, ADDR strProgstatus
	INVOKE InputInt
	INVOKE OutputStr, ADDR strNL

	cmp eax, 0
	je _start                 ; Restart the program if user inputs 0

	; Exit the program
exitprogram:
	INVOKE ExitProcess, 0

Public _start
END
