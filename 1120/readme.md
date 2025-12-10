# 1. Advanced Procedures

(고급 프로시저·스택 프레임·재귀·INVOKE/ADDR/PROC/PROTO·모듈 구조)

이 장은 x86 어셈블리에서 정확하고 안정적인 함수 호출을 구현하기 위해 필요한 스택 프레임 구조,
레지스터 보존, 지역 변수, C/C++ 호출 규약(cdecl, stdcall), 재귀(recursion),
MASM의 PROC/PROTO/INVOKE 문법, 모듈 간 함수 공개/비공개 처리를 다룬다.

# 2. Stack Frames (스택 프레임)
## 2-1. 스택 프레임 개념

스택 프레임(activation record)은 다음을 저장하는 영역이다:

구성 요소	내용
Arguments	호출자가 push한 파라미터
Return Address	call 후 복귀 주소
Saved Registers	EBP/EBX/ESI/EDI 등
Local Variables	지역 변수 저장 공간

스택 프레임 생성 순서(PDF p.2):

push arguments

call subroutine → return address push됨

push EBP

mov EBP, ESP

allocate locals (sub esp, N)

save registers (필요 시)

## 2-2. Register Parameters의 문제점

fastcall처럼 레지스터 기반 파라미터 전달은
절약되는 것 같지만 결국 register를 push/pop 해야 하므로 성능 이점이 사라짐.
(PDF p.3의 예시 코드 참고)

## 2-3. Pass by Value vs Pass by Reference
전달 방식	설명
Value	값의 복사본을 스택에 push
Reference	변수의 주소를 push

참고: 배열은 항상 참조(reference) 로 전달된다. (PDF p.6)

## 2-4. Stack Parameter Access

x86에서 스택 파라미터는 EBP + offset 방식으로 접근:

오프셋	의미
[EBP + 8]	첫 번째 파라미터
[EBP + 12]	두 번째 파라미터
[EBP + 4]	return address

예: AddTwo(x,y) (PDF p.7)

AddTwo PROC
    push ebp
    mov  ebp, esp
    mov  eax, [ebp+12] ; y
    add  eax, [ebp+8]  ; x
    pop  ebp
    ret
AddTwo ENDP

## 2-5. Stack Cleanup
cdecl 규약 (C 언어 기본)

호출자가 스택 정리
예 (PDF p.10):

push 6
push 5
call AddTwo
add esp, 8 ; cleanup by caller

stdcall 규약

피호출자가 스택 정리
예 (PDF p.11):

ret 8 ; parameters 8바이트 정리

## 2-6. Saving & Restoring Registers

(PDF p.12)

프로시저는 자신이 사용하는 레지스터를 스택에 저장 후 복원해야 한다:

push ebp
mov  ebp, esp
push ecx
push edx
...
pop  edx
pop  ecx
pop  ebp
ret

## 2-7. Local Variables (지역 변수)

지역 변수는 EBP 아래(EBP-4, EBP-8 …) 로 생성된다.
(PDF p.14)

sub esp, 8        ; 8바이트 지역 변수 공간 생성
mov DWORD PTR [ebp-4], 10
mov DWORD PTR [ebp-8], 20


종료 시:

mov esp, ebp   ; locals 제거
pop ebp
ret

## 2-8. Reference Parameters

참조 매개변수는 EBP 기준 base-offset 방식으로 접근.
(PDF p.15)

예: ArrayFill(arrayPtr, count)

arrayPtr → [EBP+12]

count → [EBP+8]

루프 내에서 TYPE·OFFSET 등을 이용해 배열 요소를 조작.

## 2-9. LEA Instruction

LEA는 실제 값을 가져오지 않고 주소(Address) 계산만 수행한다.
(PDF p.16)

lea esi, [ebp-30]  ; local 배열의 주소 계산

## 2-10. ENTER & LEAVE

ENTER는 스택 프레임을 자동 생성하며,
LEAVE는 ENTER의 동작을 반대로 수행해 프레임을 종료한다.
(PDF p.17–19)

enter 8, 0  ; 지역변수 8바이트 확보
...
leave       ; mov esp,ebp / pop ebp 자동 수행
ret

## 2-11. LOCAL Directive

LOCAL은 지역 변수 이름을 선언하는 MASM 문법.
ENTER는 공간만 만들고 이름은 만들지 않음.
(PDF p.20)

# 3. Recursion (재귀)
## 3-1. Endlessly Recursive Procedure

재귀 호출에는 반드시 종료 조건이 필요하다. (PDF p.22)

## 3-2. Recursive Sum Example

(PDF p.23–24)

CalcSum(ECX):
 if ECX == 0 → return 0
 else → return ECX + CalcSum(ECX-1)


PDF는 스택 변화/레지스터 변화를 표로 정리(PDF p.24).

## 3-3. Factorial Example

PDF p.25–28 전체 활용:

Factorial(n):
 if n == 0 return 1
 else return n * Factorial(n-1)


assembly 구현:

push ebp
mov  ebp, esp
mov  eax, [ebp+8] ; n
cmp  eax, 0
ja   L1
mov  eax, 1
jmp  L2
L1:
    dec eax
    push eax
    call Factorial
    mov ebx, [ebp+8]
    mul ebx
L2:
pop  ebp
ret 4


PDF는 n=3일 때 프레임 구조 변화를 도식화함.

# 4. INVOKE, ADDR, PROC, PROTO
## 4-1. INVOKE

MASM에서 함수 호출을 간소화하는 매크로. (PDF p.30–31)

기능:

파라미터 자동 push

호출 규칙에 맞춰 스택 정리

call 자동 실행

지원되는 인자 형태 (PDF Table 8-2):

즉시값

OFFSET / TYPE

변수 이름

메모리 표현식

레지스터

ADDR name (포인터 전달)

## 4-2. ADDR

INVOKE와 함께만 사용 가능.
파라미터로 포인터(주소) 를 전달.

예:

INVOKE FillArray, ADDR myArray

## 4-3. PROC / PROTO
PROTO

다른 파일/위치에서 사용할 함수 원형 선언.

PROC

프로시저 구현 시작.

예 (PDF p.35):

AddTwo PROC, x:DWORD, y:DWORD
    mov eax, x
    add eax, y
    ret
AddTwo ENDP

## 4-4. USES Clause

USES는 자동으로 지정 레지스터를 push/pop한다. (PDF p.41)

예:

Swap PROC USES eax esi edi, pValX:PTR DWORD, pValY:PTR DWORD

## 4-5. Swap Example

INVOKE + ADDR + PROC 활용 (PDF p.40–41)

INVOKE Swap, ADDR Array, ADDR [Array+4]


Swap 구현은 XCHG 기반:

mov esi, pValX
mov edi, pValY
mov eax, [esi]
xchg eax, [edi]
mov  [esi], eax
ret   ; automatically ret 8

## 4-6. 타입 불일치 오류

Swap이 DWORD 포인터를 기대하는데 BYTE 포인터 전달 시
메모리 오류 발생. (PDF p.42–43)

## 4-7. WriteStackFrame Procedure

Irvine32 제공 함수로 현재 스택 프레임을 출력. (PDF p.44)

# 5. Multi-Module Programs (모듈 분리)

(PDF p.46–53)

## 5-1. 모듈 분리 장점

수정된 모듈만 재컴파일

링크 속도 증가

대규모 프로그램 구조화 용이

## 5-2. PUBLIC / PRIVATE
키워드	기능
PUBLIC	외부 모듈에서 접근 가능
PRIVATE	모듈 내부에만 공개

OPTION PROC:PRIVATE → 모든 PROC를 기본 비공개로 만들고
필요한 함수만 PUBLIC 처리. (PDF p.47)

## 5-3. EXTERN

외부 모듈에 있는 프로시저 선언. (PDF p.49–50)

형식:

EXTERN ProcName@8 : PROC


@n은 파라미터 크기(byte 단위).

## 5-4. EXTERNDEF

PUBLIC + EXTERN을 대체하는 통합 선언 방식. (PDF p.52)

# 6. Chapter Summary

핵심 정리:

스택 프레임은 arguments, return address, locals, saved regs로 구성

cdecl/stfastcall/stdcall 호출 규약 차이

LOCAL / ENTER / LEAVE 를 통한 지역 변수 관리

재귀는 종료 조건이 필수이며, 스택 프레임이 중첩 생성됨

INVOKE는 파라미터 전달/호출/정리 자동화

PROC/PROTO는 구조적 함수 선언 제공

모듈 분리는 PUBLIC/PRIVATE/EXTERN/EXTERNDEF로 관리
