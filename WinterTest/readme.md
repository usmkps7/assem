
# 등교할때 지하철에서 봐

----------------------------------

# 2. 랜덤 문자열 생성 (MakeRandomString)

## 목적

길이 L(EAX)만큼 랜덤 대문자 문자열 생성

buffer에 저장 + NULL 종료

## 입력 규약

EAX = 문자열 길이 L
ESI = buffer 주소

## 핵심 공식
RandomRange(26) + 'A'

## 핵심 코드 패턴

mov ecx, eax
jcxz Done

LoopStart:
    mov eax, 26
    call RandomRange
    add eax, 'A'
    mov [esi], al
    inc esi
    loop LoopStart

## 문자열 종료
mov byte ptr [esi], 0

## 한 줄 요약

EAX 길이만큼 A~Z 난수 문자 생성 후 NULL 종료

---------------------------------------------

# 3. 랜덤 정수 배열 채우기 (FillRandDW)

## 목적

N개의 DWORD 배열을 j~k 범위 난수로 채움

레지스터 전부 보존

stdcall (ret 16)

## 인자 순서
pArr, N, j, k

## 난수 범위 공식 (중요)
RandomRange(k - j + 1) + j

## 배열 채우기 패턴
mov [esi], eax
add esi, 4
loop L1

## 프롤로그 / 에필로그
push ebp
mov  ebp, esp
pushad
...
popad
mov  esp, ebp
pop  ebp
ret 16

## 한 줄 요약

DWORD 배열을 j~k 난수로 채우는 보존형 프로시저

------------------------------------------------

# 4. 에라토스테네스의 체 (Sieve of Eratosthenes)

## 목적

2 ~ MAX 사이 모든 소수 생성

배열 인덱스 = 숫자 자체

## 배열 선언
isPrime BYTE (MAX+1) DUP(1)

## 초기화
isPrime[0] = 0
isPrime[1] = 0

## 바깥 루프 (기준 수 p)
p = 2 .. √MAX

cmp ebx, 32
jge DONE_SIEVE

## 소수 여부 체크
cmp isPrime[ebx], 0
je  NEXT_P

## 핵심 공식 (배수 제거)
j = p * p
j += p

imul eax, ebx
mov  edi, eax
mov  isPrime[edi], 0

## 라벨 역할

P_LOOP : 기준 수 p 선택

MARK : p의 배수 제거

NEXT_P : p++

DONE_SIEVE : 체 종료

## 한 줄 요약

소수 p의 배수를 p²부터 제거하는 체 알고리즘

