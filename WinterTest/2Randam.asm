include Irvine32.inc

.data
buffer byte 32 dup(?)

.code
main PROC
    call randomize

    ; ===== 테스트 루프 (20번) =====
    mov edi, 20

L1:
    mov eax, 5            ;L의 임의값
    mov esi, offset buffer
    call MakeRandomString
    
    lea edx, buffer
    call WriteString
    call crlf

    dec edi
    jnz L1

    exit

main ENDP



MakeRandomString PROC

    ; ===== 레지스터 준비 =====
    mov ecx, eax
    jcxz Done

    ; ===== 문자 생성 루프 =====
LoopStart:
    mov eax, 26
    call Randomrange
    mov ebx, eax
    add ebx, 'A'
    mov [esi], bl
    inc esi    
    loop LoopStart

    ; ===== 문자열 종료 =====
Done:
    mov byte ptr [esi], 0
    ret
MakeRandomString ENDP

END main