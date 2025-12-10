# 7.9.1

## 1. 코드에서 각 shift/rotate 이후 AL 값 구하기

mov al,0D4h
shr al,1          ; a.

mov al,0D4h
sar al,1          ; b.

mov al,0D4h
sar al,4          ; c.

mov al,0D4h
rol al,1          ; d.

정답:
(a) AL = 6Ah (b) AL = EAh
(c) AL = FDh (d) AL = A9h


## 2. 코드에서 각 shift/rotate 이후 AL 값 구하기

mov al,0D4h
ror al,3          ; a.

mov al,0D4h
rol al,7          ; b.

stc
mov al,0D4h
rcl al,1          ; c.

stc
mov al,0D4h
rcr al,3          ; d.

정답
(a) AL = 9Ah (b) AL = 6Ah
(c) AL = A9h (d) AL = 3Ah


## 3. 다음 연산 이후 AX와 DX의 내용?

4. mov dx,0
mov ax,222h
mov cx,100h
mul cx

정답
DX = 0002h  /  AX = 2200h

## 4. 다음 연산 이후 AX의 내용?

mov ax,63h
mov bl,10h
div bl

정답
AX = 0306h

## 5. 다음 연산 이후 EAX와 EDX의 내용?

mov eax,123400h
mov edx,0
mov ebx,10h
div ebx

정답
EAX = 00012340h
EDX = 00000000h

## 6. 다음 연산 이후 AX와 DX의 내용?

mov ax,4000h
mov dx,500h
mov bx,10h
div bx

정답
Divide Error(#DE) 발생 → AX, DX 정상 결과x


## 7. 다음 명령어 실행 후 BX의 내용?

mov bx,5
stc
mov ax,60h
adc bx,ax

정답
BX = 0066h

## 8. 다음 코드가 64비트 모드에서 실행될 때 출력(결과)?

.data
dividend_hi QWORD 00000108h
dividend_lo QWORD 33300020h
divisor     QWORD 00000100h

.code
mov rdx,dividend_hi
mov rax,dividend_lo
div divisor

정답
몫이 64비트 범위를 넘어서 Divide Error 발생 → RAX, RDX 정상 결과x

## 9. 다음 프로그램은 val1 - val2를 계산하려는 코드이다. 논리 오류를 찾고 수정하라.

.data
val1   QWORD 20403004362047A1h
val2   QWORD 055210304A2630B2h
result QWORD 0

.code
mov cx,8            ; loop counter
mov esi,val1        ; set index to start
mov edi,val2
clc                 ; clear Carry flag
top:
    mov al,BYTE PTR[esi]   ; get first number
    sbb al,BYTE PTR[edi]   ; subtract second
    mov BYTE PTR[esi],al   ; store the result
    dec esi
    dec edi
loop top

정답(오류 요약 및 수정 방향)
오류 1: 결과를 val1에 저장함 → result에 저장해야 함
오류 2: dec esi, dec edi로 주소가 아래로 내려감 → LSB부터 처리하려면 inc 사용
오류 3: result에 접근하는 포인터 레지스터 없음

## 10. 다음 명령어 실행 후 RAX의 16진수 내용? (64비트)

.data
multiplicand QWORD 0001020304050000h
.code
imul rax,multiplicand,4

정답
RAX = 0004080C10140000h




