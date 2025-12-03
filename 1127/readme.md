# 1. String Primitive Instructions

32-bit 모드에서 문자열 관련 명령어들은 ESI, EDI 레지스터를 암묵적으로 사용하며,
데이터 크기에 따라 AL / AX / EAX가 사용된다.
이 명령어들은 자동 반복 및 인덱스 증가/감소 기능을 제공하여 배열 처리에 효율적이다.

## 1-1. 기본 문자열 명령어
명령어	기능
MOVSB / MOVSW / MOVSD	ESI가 가리키는 메모리 → EDI로 복사
CMPSB / CMPSW / CMPSD	ESI와 EDI가 가리키는 메모리 비교
SCASB / SCASW / SCASD	AL/AX/EAX 와 EDI가 가리키는 메모리 비교
STOSB / STOSW / STOSD	AL/AX/EAX 값을 EDI가 가리키는 메모리에 저장
LODSB / LODSW / LODSD	ESI가 가리키는 메모리를 AL/AX/EAX로 로드

## 1-2. Repeat Prefix
문자열 명령어는 단일 요소만 처리하지만,
repeat prefix를 사용하면 ECX를 카운터로 자동 반복 실행된다.

Prefix	동작 조건
REP	ECX > 0 동안 반복
REPE / REPZ	ZF = 1 이고 ECX > 0
REPNE / REPNZ	ZF = 0 이고 ECX > 0

반복 시 ECX는 자동 감소하며,
ESI·EDI 증감은 Direction Flag(DF) 상태에 따라 결정된다.

## 1-3. Direction Flag

CLD : forward 방향 (주소 증가)

STD : backward 방향 (주소 감소)

문자열 명령어 실행 시 ESI, EDI의 증감 방향을 제어한다.

## 1-4. 문자열 명령어 세부 동작

MOVSB : 1바이트 이동

MOVSW : 2바이트 이동

MOVSD : 4바이트 이동
➡ 명령어 종류에 따라 ESI, EDI 증감 크기가 다름

## 1-5. 문자열 비교와 검색

CMPSx : 두 문자열(또는 배열) 비교

REPE CMPSx : 다른 값이 나올 때까지 비교

SCASx : 특정 값이 문자열에 존재하는지 검색

# 2. Irvine32 String Procedures

Irvine32 라이브러리는 널 종료 문자열을 다루는 고수준 프로시저를 제공한다.

## 2-1. Str_compare

문자열을 앞에서부터 비교

대소문자 구분 (ASCII 기반)

반환값 없음

결과는 Carry Flag / Zero Flag로 판단

비교 결과	CF	ZF	분기
string1 < string2	1	0	JB
string1 = string2	0	1	JE
string1 > string2	0	0	JA
2-2. Str_length

문자열 길이를 계산

반환값: EAX

널 문자(0) 등장 시 종료

## 2-3. Str_copy

소스 문자열 → 타겟 문자열 복사

타겟 버퍼 크기가 충분해야 함

내부적으로 REP MOVSB 사용

## 2-4. Str_trim

문자열 끝의 특정 문자(delimiter) 제거

문자열 끝에서 역방향으로 검사

처음 만나는 non-delimiter 뒤에 널 문자 삽입

처리 케이스:

빈 문자열

delimiter만 있는 문자열

delimiter가 없는 문자열

delimiter가 문자열 앞쪽에 있는 경우

## 2-5. Str_ucase

문자열의 소문자를 대문자로 변환

ASCII 비트 연산 사용 (AND 11011111b)

반환값 없음

3. Two-Dimensional Arrays

## 3-1. Row-major / Column-major

Row-major: 행 단위 연속 저장 (x86, C 계열)

Column-major: 열 단위 연속 저장

## 3-2. Base-Index Addressing
[base + index]


base: 배열 시작 주소

index: 오프셋

2차원 배열 접근의 기본 형태

## 3-3. Row-major 2차원 배열 접근

base 레지스터 → 행 시작 주소

index 레지스터 → 열 오프셋

주소 = base + (row_index × row_size) + column_index

## 3-4. Scale Factor

자료형 크기에 따라 인덱스에 배율 적용

자료형	배율
BYTE	1
WORD	2
DWORD	4

## 3-5. Base-Index-Displacement
[base + index * scale + displacement]


displacement는 배열 이름 또는 상수

완전한 유효 주소 계산 방식

# 4. Searching and Sorting Integer Arrays
## 4-1. Bubble Sort

인접한 두 요소 비교

순서가 틀리면 교환

가장 큰 값이 한 패스마다 뒤로 이동

총 n-1 패스 수행

## 4-2. Binary Search

정렬된 배열 필요

탐색 범위: first ~ last

mid = (first + last) / 2

비교 결과에 따라 범위 반으로 축소

찾으면 위치 반환, 실패 시 -1 반환

어셈블리 구현에서는:

인덱스 × 4 (DWORD)

레지스터 기반 반복 및 분기 처리

Chapter Summary

문자열 처리는 ESI, EDI, ECX, DF에 의해 제어된다

REP 접두사는 문자열 명령어의 핵심

Irvine32는 문자열 처리를 단순화한다

2차원 배열은 주소 계산이 본질이다

정렬과 탐색은 반복문과 분기 명령의 조합으로 구현된다
