INCLUDE Irvine32.inc

OPTION PROLOGUE:NONE, EPILOGUE:NONE

.code

PUBLIC EncryptBuffer

; void EncryptBuffer(char* buffer, int len);
; cdecl 규약

EncryptBuffer PROC C buffer:PTR BYTE, len:DWORD

    ; --- 수동 프레임 구성 ---
    push    ebp
    mov     ebp, esp

    push    esi
    push    ebx
    push    edx

    mov     esi, buffer      ; [ebp+8]
    mov     ecx, len         ; [ebp+12]
    xor     ebx, ebx         ; index = 0

EncryptLoop:
    cmp     ebx, ecx
    jge     EncryptDone

    mov     al, [esi+ebx]

    ; ASCII 32~126 범위 체크
    cmp     al, 32
    jl      SkipEncrypt
    cmp     al, 126
    jg      SkipEncrypt

    ; index parity (짝/홀)
    mov     edx, ebx
    and     edx, 1
    cmp     edx, 0
    jne     OddCase

EvenCase:                    ; 짝수 index → +3
    add     al, 3
    cmp     al, 126
    jle     Store
    sub     al, 95
    jmp     Store

OddCase:                     ; 홀수 index → -4
    sub     al, 4
    cmp     al, 32
    jge     Store
    add     al, 95

Store:
    mov     [esi+ebx], al

SkipEncrypt:
    inc     ebx
    jmp     EncryptLoop

EncryptDone:
    ; --- 레지스터 / 프레임 복원 ---
    pop     edx
    pop     ebx
    pop     esi
    mov     esp, ebp
    pop     ebp
    ret                      ; cdecl: 인자 정리는 호출자가 함

EncryptBuffer ENDP

END
