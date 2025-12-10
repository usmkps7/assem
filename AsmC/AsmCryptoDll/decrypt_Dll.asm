INCLUDE Irvine32.inc

OPTION PROLOGUE:NONE, EPILOGUE:NONE

.code

PUBLIC DecryptBuffer

; void DecryptBuffer(char* buffer, int len);
; cdecl ±Ô¾à

DecryptBuffer PROC C buffer:PTR BYTE, len:DWORD

    push    ebp
    mov     ebp, esp

    push    esi
    push    ebx
    push    edx

    mov     esi, buffer      ; [ebp+8]
    mov     ecx, len         ; [ebp+12]
    xor     ebx, ebx         ; index = 0

DecryptLoop:
    cmp     ebx, ecx
    jge     DecryptDone

    mov     al, [esi+ebx]

    ; ASCII 32~126 ¹üÀ§ Ã¼Å©
    cmp     al, 32
    jl      SkipDecrypt
    cmp     al, 126
    jg      SkipDecrypt

    mov     edx, ebx
    and     edx, 1
    cmp     edx, 0
    jne     OddCaseD

EvenCaseD:                   ; Â¦¼ö index ¡æ -3
    sub     al, 3
    cmp     al, 32
    jge     StoreD
    add     al, 95
    jmp     StoreD

OddCaseD:                    ; È¦¼ö index ¡æ +4
    add     al, 4
    cmp     al, 126
    jle     StoreD
    sub     al, 95

StoreD:
    mov     [esi+ebx], al

SkipDecrypt:
    inc     ebx
    jmp     DecryptLoop

DecryptDone:
    pop     edx
    pop     ebx
    pop     esi
    mov     esp, ebp
    pop     ebp
    ret

DecryptBuffer ENDP

END

INCLUDE Irvine32.inc