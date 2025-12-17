; Irvine32 / MASM 32-bit

INCLUDE Irvine32.inc

.data
N    = 12
arr  DWORD N DUP(?)

msg1 BYTE "Call #1 (j=-5, k=5)",0
msg2 BYTE "Call #2 (j=100, k=120)",0

.code

FillRandDW PROC
    push ebp
    mov  ebp, esp
    pushad 

    mov  esi, [ebp+ 8]     ; pArr
    mov  ecx, [ebp+12]     ; N
    mov  edx, [ebp+16]     ; j
    mov  ebx, [ebp+20]     ; k

L1:
    mov  eax, ebx          ; eax = k
    sub  eax, edx          ; eax = k - j
    inc  eax               ; eax = (k - j + 1) range
    call RandomRange       ; eax = 0..range-1
    add  eax, edx          ; eax = j..k
    mov  [esi], eax
    add  esi, 4
    loop L1

    popad
    mov  esp, ebp
    pop  ebp
    ret 16
FillRandDW ENDP

main PROC
    call Randomize

    ; ---- Call #1 ---

    push 5                 ; k
    push -5                ; j
    push N                 ; N
    push OFFSET arr        ; pArr
    call FillRandDW

    mov edx, OFFSET arr
    mov ecx, N
    call dumpMem
    call crlf

    ; ---- Call #2 ----
    push 120               ; k
    push 100               ; j
    push N
    push OFFSET arr
    call FillRandDW

    mov edx, OFFSET arr
    mov ecx, N
    call dumpMem

    exit
main ENDP

END main
