
# 🔥 초압축 요약 (시험 직전용)
### OFFSET = 주소
### LEA = 주소 계산
### CALL/RET = 함수
### LOOP = ECX 반복
### Randomize = 시드
### RandomRange = 난수
### WriteString = 문자열
### Crlf = 줄바꿈
### PTR = 크기 지정
### DUP(?) = 버퍼
### CMP = 비교
### JZ/JNZ = 0 / !0
### JGE = >=
### IMUL = 곱셈
### CALL / RET — 함수 호출 / 복귀

---------------------------------------------------


## call : 복귀 주소 push 후 함수로 점프

## ret : 복귀 주소 pop 후 복귀

call MakeRandomString
ret

## CMP — 비교

내부적으로 A - B 수행 (값은 버리고 플래그만 설정)

cmp ebx, 32

## CRLF — 줄바꿈 출력

\r\n 출력 (Irvine32 제공)

call Crlf

## DUP(?) — 메모리 공간만 확보 (미초기화)

실행 중 채울 버퍼

buffer BYTE 32 DUP(?)

## IMUL — signed multiply (부호 있는 곱셈)

정수 곱셈 (음수 포함)

imul eax, ebx      ; eax = eax * ebx


## JGE — Jump if Greater or Equal (부호 있음)
cmp ebx, 32
jge DONE_SIEVE     ; if ebx >= 32

JZ / JNZ — Zero / Not Zero

ZF 플래그 기준

dec edi
jnz L1             ; edi != 0 이면 점프


## LEA — 주소 계산 후 로드

주소 계산용 (메모리 접근 ❌)

lea esi, buffer
lea edx, buffer

## LOOP — ECX 전용 반복

ECX-- 후 ECX != 0이면 점프

mov ecx, L
loop_start:
    ; 내용
loop loop_start


## OFFSET — 변수 시작 주소

전역/정적 변수 주소

mov esi, OFFSET buffer


## PTR — 메모리 접근 크기 지정
mov BYTE PTR [esi], 0


## RANDOMIZE — 난수 시드 초기화
call Randomize

## RANDOMRANGE — 범위 난수 생성

EAX = N → 결과 0 ~ N-1

mov eax, 26
call RandomRange


## WRITESTRING — 문자열 출력

EDX = 문자열 주소

lea edx, buffer
call WriteString

