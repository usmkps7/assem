1. three라는 더블워드 변수의 상위 워드와 하위 워드를 교환하는 MOV 명령어 시퀀스
MOV AX, WORD PTR three       ; three 하위 16비트 -> AX
MOV DX, WORD PTR three+2     ; three 상위 16비트 -> DX
MOV WORD PTR three, DX       ; 상위 -> 하위로
MOV WORD PTR three+2, AX     ; 하위 -> 상위로


2. 8비트 레지스터 A,B,C,D → B,C,D,A로 재배열 (XCHG 3회 이하)
XCHG AL, BL  ; A<->B
XCHG AL, CL  ; A<->C (결과: B,C,A,D)
XCHG AL, DL  ; A<->D (결과: B,C,D,A)


3. AL = 01110101, Parity 플래그 사용하여 홀짝 판정
TEST AL, AL     ; AL과 자기 자신을 AND -> PF 업데이트
JPE EvenParity  ; PF=1이면 1 비트 개수가 짝수
JPO OddParity   ; PF=0이면 1 비트 개수가 홀수


4. 바이트 연산으로 두 음수 정수 더해 Overflow 플래그 설정
MOV AL, -100
ADD AL, -30     ; 결과 -130 → 8비트 범위를 벗어나 OF=1



5. 두 명령어로 Zero와 Carry 플래그 동시에 설정MOV AL, 0
SUB AL, 1      ; AL = -1 -> CF=1, ZF=0
ADD AL, 1      ; AL = 0  -> ZF=1, CF 그대로 유지 가능


7. EAX = –val2 + 7 – val3 + val1 구현
MOV EAX, val1
SUB EAX, val3
ADD EAX, 7
NEG EAX
ADD EAX, val2


8. 더블워드 배열 합 계산 (인덱스 스케일 사용)
MOV ECX, 0           ; 인덱스
MOV EAX, 0           ; 합
MOV EBX, OFFSET array
LOOP_START:
    ADD EAX, DWORD PTR [EBX + ECX*4]
    INC ECX
    CMP ECX, array_size
    JL LOOP_START


9. AX = (val2 + BX) – val4 구현
MOV AX, val2
ADD AX, BX
SUB AX, val4


10. 두 명령어로 Carry와 Overflow 플래그 동시에 설정
MOV AL, 127
ADD AL, 1      ; OF=1, CF=0
ADD AL, 128    ; AL=0 → CF=1, OF=1



11. INC/DEC 명령 후 Zero 플래그(ZF)를 사용해 unsigned overflow를 나타내는 코드
번역: INC, DEC 실행 후 0 플래그(ZF)를 이용하여 부호 없는 오버플로 감지하기
MOV AL, 0FFh     ; AL = 255
INC AL            ; AL = 0 → ZF=1 → unsigned overflow 발생

MOV BL, 0
DEC BL            ; BL = 255 → unsigned underflow, ZF=0


12. myBytes를 짝수 주소(2의 배수)에 정렬하는 지시문 추가
ALIGN 2
myBytes BYTE 10h, 20h, 30h, 40h


13. EAX에 들어갈 값 구하기
.data
myBytes BYTE 10h,20h,30h,40h
myWords WORD 3 DUP(?),2000h
myString BYTE "ABCDE"


14. myBytes의 처음 두 바이트(10h, 20h)를 DX 레지스터에 옮기기
결과: DX = 2010h
MOV DX, WORD PTR myBytes


15. myWords의 두 번째 바이트를 AL로 이동
MOV AL, BYTE PTR myWords + 1


16. myBytes의 네 바이트 전부를 EAX로 이동
MOV EAX, DWORD PTR myBytes


17. myWords를 32비트 레지스터에 직접 옮길 수 있게 LABEL 추가
myWords WORD 3 DUP(?), 2000h
myWords32 LABEL DWORD

18. myBytes를 16비트 레지스터에 직접 옮길 수 있게 LABEL 추가
myBytes BYTE 10h,20h,30h,40h
myBytes16 LABEL WORD
