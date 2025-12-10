# 1. Assembly Language Fundamentals

어셈블리 언어의 기본 요소는 리터럴(상수), 식, 데이터 정의, 식별자, 지시어, 명령어, 오퍼랜드 등으로 구성된다.
이 장에서는 프로그램 구조, 데이터 정의 규칙, 명령어 형식 등을 정리한다.

# 2. Basic Language Elements
## 2-1. Assembly Program 구조 개요

어셈블리 프로그램은 보통 다음과 같이 구성된다:

구성 요소	설명
Data Segment	변수 저장
Code Segment	실행 코드를 포함
Stack Segment	함수 호출·지역 변수 저장
Directives	어셈블러에게 지시하는 명령
Instructions	CPU가 실행하는 실제 명령
AddTwo 예제 설명

PDF의 기본 예제는 다음 구성으로 이루어짐:

main PROC : 프로그램의 엔트리 포인트

mov eax, 5 : 레지스터에 값 로드

add eax, 6 : 레지스터 덧셈

INVOKE ExitProcess, 0 : 프로그램 종료

# 3. Literals (상수)
## 3-1. Integer Literals

형식:

[+ | -] digits [ radix ]

radix 지정자	의미
h	hex
d	decimal
b	binary
o/q	octal

예:

26d → decimal

11010011b → binary

42h → hex

## 3-2. Constant Integer Expressions

산술 연산자 우선순위(PDF p.6):

우선순위	연산자
1	( )
2	+, – (unary)
3	*, /, MOD
4	+, – (binary)

예 (PDF p.7):

(4 + 2) * 6 = 36
25 mod 3 = 1
- (3 + 4) * (6 - 1) = -35

## 3-3. Real Number Literals

형식:

[sign] integer.[integer][exponent]


예:

+3.0

-44.2E+05

26.E5

PDF는 IEEE 754 배치(S/E/M)가 어떻게 저장되는지 시각적으로 보여줌.

## 3-4. Character & String Literals
종류	예시
Character literal	'A', "d"
String literal	"Hello", '4096', "Good night"

문자열은 보통 NULL(0) 로 종료되는 형태 사용.

# 4. Reserved Words (예약어)
종류	설명
Instruction mnemonics	MOV, ADD, MUL 등
Register names	EAX, EBX, ECX …
Directives	.data, .code 등
Attributes	BYTE, WORD 등 변수 크기 지정
Operators	계산식에서 사용 (+, -, MOD …)
Predefined symbols	@data 등

# 5. Identifiers (식별자)

규칙:

길이 1~247자

대소문자 구분 없음

첫 글자는 문자/_/@/?

예약어와 동일한 이름 사용 불가

# 6. Directives (지시어)

대표적인 메모리 세그먼트 지시어:

지시어	의미
.data	변수 저장 영역
.code	실행 코드 영역
.stack	스택 크기 지정
.data?	초기화되지 않은 변수 선언

지시어는 어셈블러가 해석하며 CPU가 실행하지 않는다.

# 7. Labels (레이블)

레이블은 코드 또는 데이터에 이름을 붙이는 식별자이다.

종류	설명
Data Label	변수 위치 표시
Code Label	분기 대상(JMP/TARGET)

# 8. Instructions (명령어)
## 8-1. Mnemonics

명령어 이름은 짧고 직관적이다:

Mnemonic	Description
MOV	값 이동
ADD	덧셈
SUB	뺄셈
MUL	곱셈
JMP	분기
CALL	함수 호출

## 8-2. Operands (오퍼랜드)
종류	예시
Integer literal	96
Integer expr	2 + 4
Register	eax
Memory	count

오퍼랜드 개수 예시:

stc              ; no operands
inc eax          ; one operand
mov count, ebx   ; two operands
imul eax, ebx, 5 ; three operands

# 9. Comments (주석)
형식	설명
; comment	한 줄 주석
COMMENT ! ... !	블록 주석

주석은 어셈블러에서 완전히 무시됨.

# 10. NOP Instruction

NOP 은 "do nothing" 명령으로 1바이트를 차지하며,
주로 코드 정렬(alignment) 용도로 사용됨.

# 11. Adding and Subtracting Integers

PDF에서는 AddTwo.asm 예제로 실제 32-bit 연산을 보여준다.

핵심 지시문	설명
.386	CPU 최소 요구사항(386 이상)
.model flat,stdcall	보호 모드/윈도우 호출 규약
.stack 4096	스택 공간
INVOKE ExitProcess,0	Windows API 호출

정수 연산 예:

mov eax, val1
add eax, val2
sub eax, val3

# 12. Debugging (디버깅)

Visual Studio 기준:

F5 = 디버깅 시작

중단점(breakpoint) 지정 가능

레지스터/메모리 확인 가능

PDF는 실행 화면과 레지스터 덤프 예시를 포함함.

# 13. Assembling, Linking, Running

어셈블 → 링크 → 실행 과정:

단계	설명
Assembler	.asm → .obj 생성
Linker	.obj → .exe 생성
Loader	OS가 .exe 실행

명령줄 예:

ml /c /coff AddTwo.asm
link AddTwo.obj /SUBSYSTEM:CONSOLE /OUT:Program.exe


생성물:

.lst : Listing file

.map : Map file

# 14. Defining Data (데이터 정의)
## 14-1. BYTE / SBYTE

BYTE → unsigned

SBYTE → signed

? 초기자 = 초기화되지 않음

## 14-2. DB (Define Byte)

BYTE와 동일하지만 이름 없이도 사용 가능.

## 14-3. 문자열 정의

문자열은 "text" 로 정의하며 보통 NULL 종료.

## 14-4. WORD / SWORD

16-bit 정수 저장.

## 14-5. DWORD / SDWORD

32-bit 정수 저장.

## 14-6. DUP 연산자

반복 데이터 할당:

array BYTE 10 DUP(0)

## 14-7. BCD (Packed BCD)

10-byte 구조

각 바이트에 2개의 10진수 저장

## 14-8. REAL4 / REAL8 / REAL10

부동소수점 자료형:

자료형	크기
REAL4	4 bytes (float)
REAL8	8 bytes (double)
REAL10	10 bytes (extended precision)

## 14-9. Little-Endian

x86은 최하위 바이트가 먼저 저장되는 구조 사용.

예:

12345678h
78 56 34 12 순서로 저장됨

## 14-10. .DATA?

초기화되지 않은 대량 데이터 선언 시 프로그램 크기 절약.

#15. Switching Between Code and Data

어셈블리는 필요 시 코드 중간에도 데이터를 선언할 수 있다.


---------------------------------------------------------

메모리 구조를 어셈블리어에선 전부 구분함

-----------------------------------------------------------

어셈블리어로 exe를 만들어 실행하면 운영체제의 shell에서 실행됨. 
shell에서 0은 false가 아닌 true값

sum = 주기역 장치의 일부분을 변수로 접근

--------------------------------------------------------------

언어마다 특정 진수 허용/비허용이 다름

--------------------------------------------------------

명령, 레이블, NOP

NOP동안 cpu는 쉼, 원래 목적은 명령의 길이를 조절하기 위해 존재함

소스파일 입력후 실행(f5)해서 결과나오면 캡처후 톡방 윈쉬F 눌러서 
