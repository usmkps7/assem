# 1. Stack Operations (스택 동작)
## 1-1. Runtime Stack (32-bit)

스택은 CPU가 직접 관리하는 메모리 구조이며, ESP 레지스터가 스택의 top을 가리킨다.
스택은 LIFO(Last In First Out) 구조이다. (p.2–3)

특징:

PUSH → ESP를 감소시키고 값 저장

POP → 값을 꺼낸 후 ESP 증가

일반적인 메모리 그림과 달리 위쪽이 낮은 주소, 아래가 높은 주소로 표현됨

## 1-2. PUSH Operation

(p.4)

동작:

ESP = ESP – 4

스택 top에 값 저장

예: 1, 2 푸시 후 ESP 변화가 그림으로 제시됨.

## 1-3. POP Operation

(p.5)

동작:

메모리 top 값을 목적지에 복사

ESP = ESP + 4

## 1-4. Stack Applications

(p.6)

스택의 주요 용도:

Argument Passing (인자 전달)

Return Address 저장

Register Saving (레지스터 보존)

Local Variable Storage (지역 변수 저장)

## 1-5. Extended Stack Instructions

(p.7–8)

명령	설명
PUSHFD	EFLAGS 전체를 스택에 push
POPFD	스택에서 EFLAGS 복구
PUSHAD	EAX, ECX, EDX, EBX, ESP(변경 전), EBP, ESI, EDI 순으로 push
POPAD	역순으로 pop

# 2. Manual Register Saving Example

(p.9)

MySub PROC
 pushad
 ...
 popad
 ret
MySub ENDP


주의:
PUSHAD/POPAD는 EAX도 저장·복원하므로, 함수 반환값을 EAX에 넣어도 POPAD가 덮어씌운다.

잘못된 예시:

ReadValue PROC
 pushad
 mov eax,return_value
 popad   ; eax가 덮어씌워짐!
 ret

# 3. Nested Loops + Register Saving Example (p.10)

중첩 루프에서 외부 루프 ECX를 보존하기 위해 스택 사용:

push ecx
mov ecx,20
L2: ...
loop L2
pop ecx
loop L1

# 4. Using Stack to Reverse a String (p.11)

문자열 각 문자 → PUSH

POP 하며 다시 저장 → 문자열 역순 만들기

mov ecx,nameSize
L1: movzx eax,aName[esi]
    push eax
    inc esi
...
L2: pop eax
    mov aName[esi],al

# 5. Procedures (프로시저 정의 및 사용)
## 5-1. RET Instruction

RET는 호출된 프로시저에서 return address를 POP하여 원래 지점으로 복귀한다. (p.13)

## 5-2. JMP 제한

JMP는 반드시 같은 프로시저 내 레이블로만 이동해야 한다.
(프로시저 외부로 점프하는 것은 잘못된 설계)

## 5-3. Example: Sum of Three Integers

(p.14)

SumOf PROC
 add eax,ebx
 add eax,ecx
 ret
SumOf ENDP

## 5-4. Procedure Documentation (문서화)

(p.14)

일반적으로 다음 4가지를 문서화:

수행 기능

입력 파라미터

출력(리턴값)

사전 조건 (preconditions)

# 6. CALL / RET Instruction Sequence

(p.15–16)

CALL 과정:

다음 명령어 주소를 스택에 PUSH

프로시저로 EIP 이동

RET 과정:

스택에서 return address POP

원래 코드 실행 재개

PDF에서는 CALL/RET 실행 전후 ESP/EIP 변화를 그림으로 설명.

# 7. Nested Procedure Calls (중첩 호출)

(p.17)

프로시저 A → B → C 호출 시 스택에는
return to A, return to B, return to main
이 순서로 쌓인다.

# 8. Passing Arguments in Registers

(p.18)

간단한 함수는 레지스터로 인자를 전달할 수 있다:

mov eax,10000h
mov ebx,20000h
mov ecx,30000h
call SumOf

# 9. Passing Arguments in Memory (Array Example)

(p.19–21)

ArraySum 구현:

ArraySum PROC
 push esi
 push ecx
 mov eax,0
L1: add eax,[esi]
    add esi,4
    loop L1
 pop ecx
 pop esi
 ret
ENDP


그리고 TestArraySum.asm에서:

mov esi,OFFSET array
mov ecx,LENGTHOF array
call ArraySum

# 10. USES 키워드

(p.22–23)

USES는 자동으로 레지스터 PUSH/POP을 생성:

ArraySum PROC USES esi ecx
 mov eax,0
 ...
 ret
ENDP


이는 다음과 동일:

push esi
push ecx
...
pop ecx
pop esi


주의: 반환 레지스터(EAX)는 USES로 지정하지 않는다.

잘못된 예 (p.23):

SumOf PROC
 push eax    ; eax 저장
 add eax,ebx
 add eax,ecx
 pop eax     ; 결과가 덮어짐!
 ret
ENDP

# 11. Linking to an External Library

(p.25–27)

11-1. Link Library 개념

기계어로 이미 컴파일된 절차들의 집합

여러 object 파일을 묶어 .lib 형태로 제공

링커 명령 예:

link hello.obj Irvine32.lib kernel32.lib

# 12. The Irvine32 Library

(p.27–37)

초보자용 I/O, 시스템 호출 등을 제공하는 교육용 라이브러리.

주요 기능 범주:
화면 및 문자열 출력:

WriteString

WriteChar

WriteHex / WriteInt / WriteDec

Crlf

Clrscr

SetTextColor

입력:

ReadInt

ReadString

ReadHex

ReadChar

메모리/레지스터 출력:

DumpMem

DumpRegs

WriteStackFrame

파일 처리:

CreateOutputFile

OpenInputFile

ReadFromFile

WriteToFile

유틸리티:

Random32 / RandomRange / Randomize

Delay

GetMSeconds

MsgBox

Str_length / Str_compare / Str_copy

PDF의 p.32–37까지 다양한 예제를 통해 사용법을 보여줌.

# 13. Library Test Examples

(p.35–41)

예시 1 — DumpMem, ReadInt, WriteInt, WriteHex, WriteBin

사용자에게 정수를 입력 받아

10진수, 16진수, 2진수로 출력하는 루프

예시 2 — Rand1, Rand2

0–99 범위, -50~+49 범위의 난수 생성 후 출력

TAB 문자 출력

예시 3 — GetMSeconds와 nested loop 실행 시간 측정

innerLoop를 반복 실행

경과 밀리초 출력

# 14. Chapter Summary (p.43–44)

핵심 요약:

스택은 PUSH/POP 구조로 프로시저 호출을 지원

CALL/RET은 return address를 기반으로 동작

레지스터 저장은 PUSH/POP 또는 USES 사용

배열/문자열/레지스터 기반 인자 전달 가능

라이브러리 사용을 통해 시스템 기능 호출 가능

Irvine32 라이브러리는 교육용 표준 I/O 기능 제공

주기억장치(RAM)에 

모든 생성한 객체는 힙에 저장

일부가 LIFO(후입선출)의 방식을 쓴다면 그 영역은 '스택'이라 부름

스택은 push 와 pop 2가지 연산을 함

값이 들어가면 스택(변수), 주소가 들어가면 힙에 저장됨(객체)

세그멘트 레지스터는 특정 데이터의 시작점 주소를 가지고 있다 (스택 세그멘트, 데이터 세그멘트)

ESP, SP(스택 세그멘트)는 데이터 입출력을 다룬다

------------------------------------------------------

SP는 세 값이 들어오면 4칸(4바이트 = 32비트) 만큼 '내려간' 위치로 스텍 포인터를 내리고 그 주소에 값을 넣는 방식으로 작동한다


플레그 레지스터는 cpu의 목적지와 시작지에 따라

cpu는 상당히 한정적인 자원을 가지고 연산 결과를 전부 레지스터에 보관됨 이후 지금 값을 킵해둔채로 다른 명령을 수행 후 다시 '이전 상태로 돌아가기 위해'
pushad popad 를 쓴다

예:) 반드시 ecx를 거쳐야 하는 loop 명령어로 다중루프를 만들기 위해서 외부loop를 실행하고 이후 내부loop를 실행할떄 외부loop값을 담고 있는 ecx값을 스택에 옮겨둔다


----------------------------------------------------- 

어셈블리어의 CALL과 RET 명령어(Call and Return instructions) 작동
함수, 메서드들이 수행하는 작업 
1: 스텍에서 복귀주소 push
2: 함수 주소 카피
3: 함수 실
4: 
5: RET 명령 
6: 스텍에서 복귀주소 pop

CALL = (현재 주소를 스택에 저장) + (함수로 점프)
RET  = (스택에서 주소 꺼냄) + (원래 위치로 점프)

------------------------------------------------------

레포트: 화면에 학번이름 + 레지스터 값 + 프로슈즈외 프로슈즈 2개 만들기 출력하는 결과 스샷 찍어서 카톡에 올리기 메인
