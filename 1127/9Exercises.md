# 9.9.1 Short Answer

## 1. Which Direction flag setting causes index registers to move backward through memory when executing string primitives?

번역
문자열 기본 명령어를 실행할 때, 인덱스 레지스터가 메모리에서 뒤쪽 방향으로 이동하게 만드는 Direction Flag 설정은 무엇인가?

정답

DF = 1 (STD 명령어로 설정됨)
→ ESI, EDI가 감소하면서 backward 방향으로 이동한다.

## 2. When a repeat prefix is used with STOSW, what value is added to or subtracted from the index register?

번역
STOSW에 repeat prefix를 사용할 때, 인덱스 레지스터에 더해지거나 빼지는 값은 무엇인가?

정답

2 바이트
→ WORD 크기이므로 EDI가 ±2씩 이동한다.

## 3. In what way is the CMPS instruction ambiguous?

번역
CMPS 명령어는 어떤 점에서 모호한가?

정답

어떤 피연산자가 기준(left/right)인지 명확하지 않다

즉, 두 메모리를 비교하지만 어느 쪽이 source인지 결과만으로는 직관적이지 않다

결과 해석은 플래그(CF, ZF 등) 에 의존한다

## 4. When the Direction flag is clear and SCASB has found a matching character, where does EDI point?

번역
Direction Flag가 클리어된 상태에서 SCASB가 일치하는 문자를 찾았을 때, EDI는 어디를 가리키는가?

정답

일치한 문자의 바로 다음 위치

이유: 비교 후 EDI가 자동 증가하기 때문

## 5. When scanning an array for the first occurrence of a particular character, which repeat prefix would be best?

번역
배열에서 특정 문자의 첫 번째 등장 위치를 찾을 때 가장 적절한 repeat prefix는 무엇인가?

정답

REPNE (또는 REPNZ)
→ 같지 않은 동안 반복하다가 처음으로 같은 값(ZF=1)을 만나면 중단

## 6. What Direction flag setting is used in the Str_trim procedure from Section 9.3?

번역
9.3절의 Str_trim 프로시저에서는 Direction Flag를 어떻게 설정하는가?

정답

DF = 0 (CLD)
→ 문자열을 forward 방향으로 처리한 후, 논리적으로 끝 위치를 계산

## 7. Why does the Str_trim procedure from Section 9.3 use the JNE instruction?

번역
9.3절의 Str_trim 프로시저가 JNE 명령어를 사용하는 이유는 무엇인가?

정답

현재 문자가 지정된 구분자(delimiter)가 아닐 때 반복을 계속하기 위해

즉, delimiter가 아닌 문자를 만날 때까지 뒤로 이동하기 위함

## 8. What happens in the Str_ucase procedure from Section 9.3 if the target string contains a digit?

번역
9.3절의 Str_ucase 프로시저에서 문자열에 숫자가 포함되어 있다면 어떻게 되는가?

정답

아무 변화도 없다

숫자는 ASCII 범위 검사('a' ~ 'z')에서 제외되므로 변환되지 않는다

## 9. If the Str_length procedure from Section 9.3 used SCASB, which repeat prefix would be most appropriate?

번역
9.3절의 Str_length 프로시저가 SCASB를 사용한다면, 가장 적절한 repeat prefix는 무엇인가?

정답

REPNE

이유:

널 문자(0)가 나올 때까지 반복 비교해야 함

널 문자는 비교 조건에서 “일치”이므로, 같지 않은 동안 반복

## 10. If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and return the string length?

번역
9.3절의 Str_length가 SCASB를 사용한다면 문자열 길이를 어떻게 계산하고 반환하는가?

정답

ECX를 최대 길이로 초기화

REPNE SCASB 실행

실행 후:

(초기 ECX − 현재 ECX − 1) = 문자열 길이

결과를 EAX에 저장하여 반환

## 11. What is the maximum number of comparisons needed by the binary search algorithm when an array contains 1,024 elements?

번역
원소가 1,024개인 배열에서 이진 탐색이 필요로 하는 최대 비교 횟수는 얼마인가?

정답

10회

이유:

1024
=
2
10
1024=2
10

최대 비교 횟수 = log₂(1024)

## 12. In the FillArray procedure from the Binary Search example in Section 9.5, why must the Direction flag be cleared by the CLD instruction?

번역
9.5절 이진 탐색 예제의 FillArray 프로시저에서 왜 CLD로 Direction Flag를 클리어해야 하는가?

정답

문자열/배열을 앞에서 뒤로 순차적으로 저장해야 하기 때문

DF가 설정되어 있으면 주소가 감소하여 잘못된 메모리에 저장된다

## 13. In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be removed without affecting the outcome?

번역
9.5절의 BinarySearch 프로시저에서 L2 레이블의 문장은 왜 제거해도 결과에 영향을 주지 않는가?

정답

이미 이전 비교 결과 플래그를 그대로 사용하기 때문

중복 비교이므로 논리적으로 불필요하다

## 14. In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be eliminated?

번역
9.5절의 BinarySearch 프로시저에서 L4 레이블의 문장은 어떻게 제거할 수 있는가?

정답

분기 구조를 재배치하여
불필요한 jmp 없이 바로 루프 시작으로 제어 이동

즉, 조건 분기 흐름을 단순화하면 L4가 필요 없어짐

-----------------------------------------------

# 9.9.2 Algorithm Workbench

## 1. Show an example of a base-index operand in 32-bit mode.

번역
32비트 모드에서 base-index 피연산자의 예를 보여라.

정답

mov eax, [ebx + esi]


EBX → base

ESI → index


## 2. Show an example of a base-index-displacement operand in 32-bit mode.

번역
32비트 모드에서 base-index-displacement 피연산자의 예를 보여라.

정답

mov eax, [ebx + esi + 4]


EBX → base

ESI → index

4 → displacement


## 3. Suppose a two-dimensional array of doublewords has three logical rows and four logical columns. Write an expression using ESI and EDI that addresses the third column in the second row. (Numbering rows and columns starts at zero.)

번역
DWORD 2차원 배열이 3행 4열일 때,
(행과 열은 0부터 시작)
2번째 행, 3번째 열을 가리키는 주소식을 ESI와 EDI로 작성하라.

정답

[EDI + ESI*16 + 8]


설명:

row size = 4 columns × 4 bytes = 16

2번째 행 → ESI*16

3번째 열 → 8 (2 × 4 bytes)


## 4. Write instructions using CMPSW that compare two arrays of 16-bit values named source and target.

번역
source, target라는 16비트 배열을 CMPSW로 비교하는 명령어를 작성하라.

정답

cld
mov esi, OFFSET source
mov edi, OFFSET target
mov ecx, LENGTHOF source
repe cmpsw


## 5. Write instructions that use SCASW to scan for the 16-bit value 0100h in an array named wordArray, and copy the offset of the matching member into the EAX register.

번역
wordArray에서 값 0100h를 SCASW로 검색하고,
일치한 요소의 오프셋을 EAX에 저장하라.

정답

cld
mov edi, OFFSET wordArray
mov eax, 0100h
mov ecx, LENGTHOF wordArray
repne scasw
sub edi, TYPE wordArray
mov eax, edi


## 6. Write a sequence of instructions that use the Str_compare procedure to determine the larger of two input strings and write it to the console window.

번역
Str_compare를 사용해 두 문자열 중 더 큰 문자열을 판단하고 출력하라.

정답

INVOKE Str_compare, ADDR str1, ADDR str2
.IF CARRY?
    mov edx, OFFSET str2
.ELSE
    mov edx, OFFSET str1
.ENDIF
call WriteString


## 7. Show how to call the Str_trim procedure and remove all trailing "@" characters from a string.

번역
Str_trim을 호출해 문자열 끝의 '@' 문자들을 제거하라.

정답

INVOKE Str_trim, ADDR myString, '@'


## 8. Show how to modify the Str_ucase procedure from the Irvine32 library so it changes all characters to lower case.

번역
Irvine32의 Str_ucase를 수정하여 소문자로 변환하도록 만들어라.

정답

or BYTE PTR [esi], 00100000b


ASCII에서 대문자를 소문자로 변환


## 9. Create a 64-bit version of the Str_trim procedure.

번역
Str_trim 프로시저를 64비트 버전으로 작성하라.

정답 (개념 예시)

; RDI = string pointer
; RSI = delimiter
; RCX = length


RSI / RDI / RCX 사용

로직은 32비트 버전과 동일

레지스터만 64비트로 치환


## 10. Show an example of a base-index operand in 64-bit mode.

번역
64비트 모드에서 base-index 피연산자의 예를 보여라.

정답

mov rax, [rbx + rsi]


## 11. Assuming that EBX contains a row index into a two-dimensional array of 32-bit integers named myArray and EDI contains the index of a column, write a single statement that moves the content of the given array element into the EAX register.

번역
EBX = 행 인덱스, EDI = 열 인덱스일 때,
myArray의 해당 값을 한 줄로 EAX에 저장하라.

정답

mov eax, myArray[ebx*ROWSIZE + edi*4]


## 12. Assuming that RBX contains a row index into a two-dimensional array of 64-bit integers named myArray and RDI contains the index of a column, write a single statement that moves the content of the given array element into the RAX register.

번역
64비트 버전에서 같은 조건으로 RAX에 저장하라.

정답

mov rax, myArray[rbx*ROWSIZE + rdi*8]

--------------------------------------------

# 9.10 Programming Exercises

## 1. Improved Str_copy Procedure

번역
기존 Str_copy는 복사할 문자 수를 제한하지 않는다.
복사할 최대 문자 수를 인자로 받는 Str_copyN 프로시저를 작성하라.

정답 핵심

입력:

source 포인터

target 포인터

최대 복사 문자 수

로직:

ECX = N

REP MOVSB 사용

널 문자 만나면 조기 종료

드라이버 프로그램으로 동작 확인 필수

## 2. Str_concat Procedure

번역
source 문자열을 target 문자열 끝에 붙이는 Str_concat을 작성하라.
target에는 충분한 공간이 있어야 한다.

정답 핵심

입력: source 포인터, target 포인터

절차:

target 끝(널 문자 위치) 찾기

source를 그 위치부터 복사

널 문자 포함해서 종료

## 3. Str_remove Procedure

번역
지정 위치에서 n개의 문자 제거하는 Str_remove를 작성하라.

예:

"abcxxxxdefghijkmop" → "abcdefghijkmop"


정답 핵심

입력:

제거 시작 위치 포인터

제거할 문자 개수 n

로직:

제거 구간 뒤 문자열을 앞으로 당김

널 문자까지 이동

## 4. Str_find Procedure

번역
target 문자열에서 source 문자열이 처음 등장하는 위치를 찾는 Str_find를 작성하라.

정답 핵심

입력: source, target 포인터

출력:

성공 시:

ZF = 0

EAX = 매칭 시작 위치

실패 시:

ZF = 1

EAX = undefined

알고리즘:

target을 앞에서부터 순차 스캔

가능한 위치마다 source와 비교

## 5. Str_nextWord Procedure

번역
지정 delimiter(구분자)를 찾아 이를 널 문자로 바꾸고,
다음 단어 시작 위치를 반환하는 Str_nextWord를 작성하라.

정답 핵심

입력: 문자열 포인터, delimiter 문자

동작:

delimiter 발견 → 해당 위치에 0 저장

EAX = 다음 문자 위치

조건:

발견 시 ZF = 1

미발견 시 ZF = 0, EAX undefined

## 6. Constructing a Frequency Table

번역
문자열의 문자 빈도 테이블을 생성하는 Get_frequencies 프로시저를 작성하라.

정답 핵심

입력:

문자열 포인터

크기 256짜리 DWORD 배열

규칙:

ASCII 코드 값 = 인덱스

등장할 때마다 해당 인덱스 증가

결과:

배열에 각 문자 빈도 수 저장

## 7. Sieve of Eratosthenes

번역
에라토스테네스의 체를 사용해 2~65,000 사이의 모든 소수 출력.

정답 핵심

크기 65,000 BYTE 배열

초기화:

STOSB로 전부 0

알고리즘:

2부터 시작

배수 표시

표시되지 않은 수 = 소수

모든 소수 출력

## 8. Bubble Sort (Exchange Flag 추가)

번역
BubbleSort에 교환 발생 여부 플래그를 추가하라.

정답 핵심

변수 exchangeFlag

inner loop에서 교환 발생 시 exchangeFlag = 1

outer loop 한 패스 종료 후:

exchangeFlag == 0 → 조기 종료

## 9. Binary Search (Register Version)

번역
이 장의 이진 탐색 코드를 **레지스터 기반(mid, first, last)**으로 다시 구현하라.

정답 핵심

메모리 지역변수 제거

EAX, EBX, ECX 등으로 first/last/mid 관리

주석으로 레지스터 역할 명확히 설명

## 10. Letter Matrix

번역
4×4 대문자 행렬을 생성하되,
각 문자가 **모음일 확률 50%**를 갖도록 하라.

정답 핵심

무작위 문자 생성

조건:

난수 → 모음/자음 분기

루프:

5회 반복 출력

## 11. Letter Matrix / Sets with Vowels

번역
이전 문제의 행렬에서
가로·세로·대각선 4글자 조합 중
모음이 정확히 2개인 경우만 출력하라.

정답 핵심

탐색 방향:

행

열

대각선

조건:

모음 개수 == 2

순서는 중요하지 않음

## 12. Calculating the Sum of an Array Row

번역
2차원 배열에서 지정된 행의 합을 구하는 calc_row_sum을 작성하라.

정답 핵심

입력:

배열 오프셋

row size

row index

반환:

EAX = 해당 행의 합

BYTE/WORD/DWORD 모두 지원

## 13. Trimming Leading Characters

번역
문자열 앞부분의 특정 문자를 모두 제거하는 Str_trim_leading을 작성하라.

예:

"###ABC" → "ABC"


정답 핵심

문자열 시작부터 검사

지정 문자 아닌 첫 위치 찾기

문자열 전체를 앞으로 이동

## 14. Trimming a Set of Characters

번역
문자열 끝에서 특정 문자 집합 중 하나라도 해당되면 제거하는 프로시저 작성.

예:

"ABC$#&" + "$#&" → "ABC"


정답 핵심

입력:

문자열 포인터

제거 대상 문자 집합 포인터

로직:

문자열 끝부터

현재 문자가 집합에 포함되면 제거

포함 안 되면 종료
