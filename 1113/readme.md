# 1. Integer Arithmetic

본 장은 x86에서 제공되는 시프트/로테이트, 곱셈, 나눗셈, 확장(sign/zero), ASCII·Packed BCD 연산 등을 다룬다.

# 2. Shift and Rotate Instructions (비트 이동/순환)

PDF p.2 Table 7-1 기준:

명령어	기능 요약
SHL	논리적 왼쪽 시프트
SHR	논리적 오른쪽 시프트
SAL	산술적 왼쪽 시프트 (= SHL)
SAR	산술적 오른쪽 시프트
ROL	순환 왼쪽 회전
ROR	순환 오른쪽 회전
RCL	Carry 포함 왼쪽 회전
RCR	Carry 포함 오른쪽 회전
SHLD	더블-프리시전 왼쪽 시프트
SHRD	더블-프리시전 오른쪽 시프트

## 2-1. Logical vs Arithmetic Shift

(p.3–4 다이어그램 설명)

종류	설명
Logical shift	비어 있는 자리 → 0 삽입
Arithmetic shift	부호 비트 유지하며 이동 (특히 오른쪽 시프트에서 중요)

## 2-2. SHL (Shift Left)

(p.5 그림)

왼쪽으로 밀고 LSB(최하위 비트) = 0

MSB(최상위 비트)는 CF(캐리 플래그)로 이동

형식:

SHL dest, count


예 (p.6):

mov bl,8Fh      ; 10001111b
shl bl,1        ; CF=1, BL=00011110b


비트 곱셈 예:

1비트 왼쪽 이동 = *2

2비트 여부는 *4 …

## 2-3. SHR (Shift Right)

(p.7 그림)

오른쪽으로 이동

MSB → 0 으로 채움

비트 나눗셈 예:
1비트 오른쪽 이동 = /2

## 2-4. SAL / SAR

(p.8–9)

SAL = SHL

SAR: 오른쪽 이동하면서 부호 비트 유지

Signed division 사용 예:

mov dl,-128
sar dl,3       ; arithmetic shift, sign 유지

# 3. Rotate Instructions (비트 회전)
## 3-1. ROL

(p.10 그림)

비트가 왼쪽으로 순환

MSB → CF, LSB로 들어감

비트 유실 없음

예:

mov al,40h
rol al,1

## 3-2. ROR

(p.11 그림)

비트가 오른쪽 순환

LSB → CF, MSB로 이동

## 3-3. RCL / RCR

(p.12)

Carry flag을 포함하여 회전

9비트 또는 33비트 회전처럼 동작

## 3-4. Overflow Flag (OF) 주의

(p.13)

shift/rotate count = 1일 때만 OF 의미 있음

1 초과 shifting은 OF 값이 정의되지 않음

# 4. SHLD / SHRD (Double-Precision Shift)
## 4-1. SHLD

(p.14)

SHLD dest, src, count


dest를 왼쪽으로 밀고

빈 자리를 src의 상위 비트로 채움

src는 변하지 않음

## 4-2. SHRD

(p.15)

SHRD dest, src, count


dest를 오른쪽으로 밀고

빈 자리를 src의 하위 비트로 채움

## 4-3. 예제

(p.16)

Example 1: AX와 wval 조합
Example 2: DX와 AX 조합
→ 시프트 결과를 그림으로 설명되어 있음.

# 5. Shift Applications (응용)
## 5-1. 프로그램 구조 설명 예 (p.17)

코드 요약:

배열에서 doubleword(32비트) 단위로 가져옴

SHRD를 이용해 상위-하위 doubleword 결합

다음 쌍으로 이동하며 반복

마지막 doubleword는 SHR로 이동

## 5-2. 바이트 배열 전체를 오른쪽 1비트 shift (p.19–20)

첫 byte는 SHR

중간 byte는 RCR (carry 포함)

마지막 byte도 RCR

PDF의 그림은 각 단계에서 CF 값이 어떻게 흘러가는지 정확히 보여준다.

## 5-3. Binary Multiplication (p.21)

EAX * 36 예:

36 = 32 + 4
= 2⁵ + 2²

따라서:

mov eax,123
mov ebx,eax
shl eax,5   ; * 32
shl ebx,2   ; * 4
add eax,ebx

## 5-4. 32bit → ASCII Binary 변환 (BinToAsc, p.22)

핵심 아이디어:

EAX를 왼쪽 shift

MSB가 Carry로 나오므로 이를 '0' 또는 '1'로 기록

32번 반복하여 ASCII ‘0’, ‘1’ 문자열 생성

코드 요약:

shl eax,1
jnc write_0
write_1:

## 5-5. 파일 날짜 필드 추출 (p.23)

DX 레지스터 분해:

비트 구역	의미
9–15	year (1980 + value)
5–8	month
0–4	day

비트 연산:

and dl,00011111b   ; day
shr dx,5           ; month
...
add ax,1980        ; year

# 6. Multiplication / Division Instructions
## 6-1. MUL (Unsigned Multiply)

(p.25)

피연산자 규칙(표):

Multiplicand	Multiplier	Product
AL	reg/mem8	AX
AX	reg/mem16	DX:AX
EAX	reg/mem32	EDX:EAX

주의:

product 상위 절반이 0이 아니면 CF = 1

따라서 CF 체크 = overflow 체크

## 6-2. IMUL (Signed Multiply)

(p.28–33)

형식:

IMUL reg
IMUL reg, r/m
IMUL reg, r/m, imm


특징:

두-오퍼랜드 / 세-오퍼랜드 형식은 결과가 destination 크기로 잘림

잘린 경우 OF, CF = 1

signed overflow 가능 → 반드시 OF 체크

## 6-3. Sign Extension (p.37–38)

크기 변환:

명령	설명
CBW	AL → AX sign-extend
CWDE	AX → EAX sign-extend
CWD	AX → DX:AX sign-extend
CDQ	EAX → EDX:EAX sign-extend

표(p.38)에는 byte→word, word→dword, dword→qword 변환 그림이 포함됨.

## 6-4. IDIV / DIV

(p.39–42)

DIV (Unsigned Divide)
피연산자 크기	Dividend	Quotient	Remainder
8bit	AX	AL	AH
16bit	DX:AX	AX	DX
32bit	EDX:EAX	EAX	EDX
IDIV (Signed Divide)

dividend는 반드시 완전 sign-extend 되어야 함

division by zero → 예외

quotient overflow → 예외

PDF p.41 제안:

32비트 divisor + 64비트 dividend를 사용하면 overflow 위험이 감소.

# 7. Extended Addition/Subtraction (ADC / SBB)
## 7-1. ADC (Add with Carry)

(p.47)

adc dest, src


= dest + src + CF

다중 정밀도(64bit, 128bit 등) 정수 덧셈 구현에 필수.

## 7-2. SBB (Subtract with Borrow)

(p.48)

sbb dest, src


= dest - src - CF

큰 정수 뺄셈 구현에 사용.

# 8. ASCII & Unpacked Decimal Arithmetic
## 8-1. ASCII 숫자의 성질

(p.50)

ASCII '0' = 30h
→ 상위 4비트 = 0011b

## 8-2. AAA (ASCII Adjust after Addition)

(p.51)

ADD/ADC 후 AL에 저장된 값을 unpacked decimal 형태로 조정
AH = carry 반영

## 8-3. ASCII Addition 알고리즘 (p.52–54)

핵심 단계:

뒤에서부터 한 자리씩 계산

carry 저장

AAA로 십진법 정규화

carry 누적 OR 처리

PDF p.53–54에는 실제 ASM 코드 전체가 포함되어 있음.

## 8-4. AAS, AAM, AAD (p.55–58)
명령	기능
AAS	SUB/SBB 후 ASCII subtract 조정
AAM	MUL 결과를 unpacked decimal로 변환
AAD	DIV 이전 unpacked decimal을 binary로 변환

# 9. Packed Decimal Arithmetic (DAA / DAS)
## 9-1. DAA (Decimal Adjust after Addition)

(p.59)

ADD/ADC 후 AL을 BCD(packed decimal)로 조정

AL이 0–9 범위 밖이면 6을 더함

carry 발생 시 AH 영향

## 9-2. Packed Addition 예제 (p.60)
packed_1 = 4536h
packed_2 = 7207h


ADD + DAA + ADC + DAA로 packed BCD 더하기 구현.

## 9-3. DAS (Decimal Adjust after Subtraction)

(p.61)

SUB/SBB 후 BCD를 조정.

# 10. Chapter Summary

(PDF p.63)

핵심 요약:

비트 시프트와 로테이트는 CF/OF에 영향을 주며 곱셈/나눗셈/암호/비트 조작에 필수

MUL/IMUL: product 크기가 두 배

DIV/IDIV: 나머지/몫 레지스터 구성 주의

sign-extension 명령(CBQ/CWD/CDQ)은 나눗셈 준비에 중요

ADC/SBB는 고정 폭 이상의 큰 정수 연산 처리에 사용

ASCII/BCD 연산은 사람이 보는 숫자 문자열을 처리할 때 사용
