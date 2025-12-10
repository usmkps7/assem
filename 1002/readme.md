# 1. Data Transfers, Addressing, and Arithmetic

(x86 Assembly – Chapter 4 핵심 정리)

이 장은 데이터 이동 명령어(MOV 계열), 주소 계산 방식, 산술 연산, 플래그 변화, 간접 주소 지정, LOOP/JMP 구조 등을 다룬다.

# 2. Data Transfer Instructions (데이터 이동 명령어)
## 2-1. Operand Types

형식:

mnemonic [destination],[source]


오퍼랜드 유형:

구분	설명
Immediate	즉시값 (숫자 리터럴)
Register	CPU 내부 레지스터
Memory	메모리 주소 참조

PDF p.3의 표 기준으로 정리하면:

operand	의미
reg8	8-bit 레지스터
reg16	16-bit 레지스터
reg32	32-bit 레지스터
sreg	세그먼트 레지스터(CS/DS/ES/...)
imm	즉시값
mem	메모리 오퍼랜드(8/16/32bit)

## 2-2. MOV Instruction

MOV dest, source
→ source 값을 dest로 복사.

규칙:

두 피연산자는 같은 크기여야 함

memory→memory 직접 이동 불가

EIP/RIP는 destination 불가

예:

mov reg,reg
mov mem,reg
mov reg,mem
mov reg,imm

## 2-3. Overlapping Values (겹치는 값 영향)

.data

oneByte BYTE 78h
oneWord WORD 1234h
oneDword DWORD 12345678h


레지스터의 일부(AL/AH/AX/EAX)를 사용하면 기존 레지스터 값과 겹쳐 저장되는 것을 PDF p.6에서 보여준다.

## 2-4. Zero-Extension / Sign-Extension

작은 크기를 큰 크기로 옮길 때 확장 발생.

Zero-extend 예
mov cx,count   ; WORD → CX, 상위는 0

Sign-extend 예

signedVal = -16 (SWORD)

mov cx,signedVal ; ECX = FFFF0h (-16)

## 2-5. MOVZX / MOVSX

전용 확장 명령어:

명령	기능
MOVZX	Zero-extend
MOVSX	Sign-extend

예 (PDF p.8–9):

movzx ax, byteVal
movsx ax, byteVal

## 2-6. LAHF / SAHF

Flags ↔ AH 이동 명령어:

명령	설명
LAHF	EFLAGS 하위 8비트를 AH로 로드
SAHF	AH 값을 EFLAGS 하위 바이트로 저장
## 2-7. XCHG (교환)

두 오퍼랜드의 값을 교환한다.

형식:

xchg reg,reg
xchg reg,mem
xchg mem,reg


메모리끼리 교환하려면 레지스터를 거쳐야 한다.

## 2-8. Direct-Offset Operands

명시적 레이블 없이 배열 접근:

예:

arrayB BYTE 10h,20h,30h
mov al,arrayB
mov al,[arrayB+1]
mov al,[arrayB+2]


배열 크기에 따라 오프셋 증가량이 달라짐.

# 3. Arithmetic Instructions (산술 명령어)
## 3-1. INC / DEC
INC reg/mem
DEC reg/mem


특징:

CF(Carry flag)를 변경하지 않는다

결과만 기반으로 다른 플래그(ZF, SF, OF 등) 갱신

## 3-2. ADD (덧셈)
add dest, source


소스는 변경되지 않고, 결과는 dest에 저장.

플래그 영향:

CF, ZF, SF, OF, AF, PF 모두 업데이트

## 3-3. NEG (부호 반전)
neg operand


Two's Complement을 취한다.

특징:

0이 아닌 값에 NEG 적용 시 CF=1

## 3-4. 산술 표현식 구현

PDF p.18 예제:

Rval = -Xval + (Yval - Zval)


구현:

mov eax,Xval
neg eax
mov ebx,Yval
sub ebx,Zval
add eax,ebx
mov Rval,eax

# 4. Flags for Arithmetic (플래그 변화)

PDF p.19–24 전체 정리.

## 4-1. Zero Flag (ZF)

연산 결과가 0이면 설정.

## 4-2. Carry Flag (CF) - unsigned overflow

ADD에서 자리 올림 발생 시 CF=1
SUB에서 작은 값 - 큰 값 = borrow 발생 시 CF=1

예:

mov al,0FFh
add al,1  ; CF = 1

## 4-3. Auxiliary Carry (AC)

3번 비트에서 carry/borrow 발생 시 AC=1
(BCD 연산에서 많이 사용)

## 4-4. Parity Flag (PF)

하위 8비트에서 1 비트의 개수가 짝수면 PF=1

## 4-5. Sign Flag (SF)

결과의 최상위 비트가 1이면 SF=1
즉 음수 값.

## 4-6. Overflow Flag (OF) - signed overflow

양수+양수 → 음수 결과

음수+음수 → 양수 결과

예:

mov al, +127
add al,1   ; OF = 1

# 5. Data-Related Operators & Directives

PDF p.31–38 요약.

연산자	기능
OFFSET	변수의 오프셋(주소) 반환
ALIGN	데이터 정렬(word, dword 등)
PTR	선언된 데이터 크기를 무시하고 새로운 크기로 취급
TYPE	단일 요소의 크기
LENGTHOF	배열 요소 개수
SIZEOF	LENGTHOF × TYPE
LABEL	새 레이블 생성(공간 할당 없음)

# 6. Indirect Addressing (간접 주소 지정)

ESI/EDI/EBX 등 레지스터에 주소를 저장하여 사용하는 방식.

형식:

mov esi, OFFSET array
mov al, [esi]

## 6-1. Indexed Addressing

레지스터 + 상수(offset)

mov al, arrayB[esi]
mov ax, arrayW[esi*2]


배열 요소 크기에 따라 오프셋을 곱해야 한다.

## 6-2. Pointer Variables (TYPEDEF)

PDF p.47 예제에서 TYPEDEF를 사용해 사용자 정의 포인터 생성:

PBYTE  TYPEDEF PTR BYTE
PWORD  TYPEDEF PTR WORD
PDWORD TYPEDEF PTR DWORD


사용:

ptr1 PBYTE arrayB
mov esi,ptr1
mov al,[esi]

# 7. JMP and LOOP Instructions
## 7-1. JMP

무조건 분기.
레이블 주소로 점프한다.

예:

jmp target

## 7-2. LOOP

ECX을 카운터로 사용하는 반복문.

동작:

ECX ← ECX - 1

ECX != 0 이면 레이블로 점프

예제(PDF p.53):

mov ecx,LENGTHOF intarray
L1:
 add eax,[edi]
 add edi,TYPE intarray
 loop L1

## 7-3. 문자 배열 복사 예제

PDF p.54:

mov esi,0
mov ecx, SIZEOF source
L1:
 mov al, source[esi]
 mov target[esi], al
 inc esi
 loop L1

# 8. Chapter Summary

핵심 요약:

MOV/MOVZX/MOVSX/LAHF/SAHF/XCHG 등 주요 데이터 이동 명령어

Direct-offset, indirect, indexed addressing 완전 정복

ADD/SUB/INC/DEC/NEG 연산과 플래그 변화

OFFSET, TYPE, SIZEOF, LENGTHOF 등 데이터 관련 지시어

포인터(TYPEDEF), 배열 처리, 간접 주소 접근

JMP/LOOP을 통한 반복 구조 구현
