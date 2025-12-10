; Prompt For Integers (_ prompt.asm)
INCLUDE Irvine32.inc
.code
;----------------------------------------------------
PromptForIntegers PROC
; Prompts the user for an array of integers and fills
; the array with the user's input.
; Receives:
;   ptrPrompt: PTR BYTE  ; prompt string
;   ptrArray:  PTR DWORD ; pointer to array
;   arraySize: DWORD     ; size of the array
; Returns: nothing
;-----------------------------------------------------
arraySize EQU [ebp+16]
ptrArray  EQU [ebp+12]
ptrPrompt EQU [ebp+8]

enter 0,0
pushad                 ; save all registers

mov ecx,arraySize
cmp ecx,0              ; array size = 0?
jle L2                 ; yes: quit

mov edx,ptrPrompt      ; address of the prompt
mov esi,ptrArray

L1:
    call WriteString   ; display prompt
    call ReadInt       ; read integer into EAX
    call Crlf          ; newline
    mov [esi],eax      ; store value in array
    add esi,4          ; next integer slot
    loop L1

L2:
    popad              ; restore registers
    leave              ; mov esp,ebp / pop ebp
    ret 12             ; remove parameters from stack
PromptForIntegers ENDP
END
