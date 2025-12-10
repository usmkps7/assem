.386
.model flat, c     ; C 호출 규약 (cdecl)
.stack 4096

.code
mul11 PROC n:DWORD
    mov eax, n     ; eax = n
    imul eax, 11   ; eax = n * 11
    ret            ; eax 값이 반환됨
mul11 ENDP

END
