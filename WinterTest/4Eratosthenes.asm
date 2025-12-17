; Sieve of Eratosthenes: primes 2..1000 (Irvine32 / MASM 32-bit)
INCLUDE Irvine32.inc

MAX = 1000

.data
isPrime BYTE (MAX+1) DUP(1)     ; 1 = prime, 0 = not

.code
main PROC
    ; 0,1은 소수 아님
    mov isPrime[0], 0
    mov isPrime[1], 0

    ; p = 2..31 (sqrt(1000) ≈ 31)
    mov ebx, 2
P_LOOP:
    cmp ebx, 32
    jge DONE_SIEVE

    cmp isPrime[ebx], 0
    je  NEXT_P

    ; j = p*p
    mov eax, ebx
    imul eax, ebx
    mov edi, eax

MARK:
    cmp edi, MAX
    jg  NEXT_P
    mov isPrime[edi], 0
    add edi, ebx
    jmp MARK

NEXT_P:
    inc ebx
    jmp P_LOOP

DONE_SIEVE:
    ; 출력: 2..1000
    mov ebx, 2
OUT_LOOP:
    cmp ebx, MAX+1
    jge EXIT_MAIN

    cmp isPrime[ebx], 0
    je  OUT_NEXT

    mov eax, ebx
    call WriteDec

OUT_NEXT:
    inc ebx
    jmp OUT_LOOP

EXIT_MAIN:
    exit
main ENDP

END main
