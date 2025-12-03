1. String Primitive Instructions

32-bit 모드에서 문자열 관련 명령어들은 ESI, EDI 레지스터를 암묵적으로 사용하며,
데이터 크기에 따라 AL / AX / EAX가 사용된다.
이 명령어들은 자동 반복과 인덱스 증감 기능을 제공하여 배열 처리에 적합하다.

1.1 기본 문자열 명령어
명령어	기능
MOVSB / MOVSW / MOVSD	ESI → EDI 메모리 복사
CMPSB / CMPSW / CMPSD	두 메모리 영역 비교
SCASB / SCASW / SCASD	AL/AX/EAX 와 메모리 비교
STOSB / STOSW / STOSD	AL/AX/EAX → 메모리 저장
LODSB / LODSW / LODSD	메모리 → AL/AX/EAX 로드
1.2 Repeat Prefix

문자열 명령어는 기본적으로 한 요소만 처리하지만,
Repeat Prefix를 사용하면 ECX를 카운터로 사용하여 반복 실행된다.

Prefix	조건
REP	ECX > 0
REPE / REPZ	ZF = 1 그리고 ECX > 0
REPNE / REPNZ	ZF = 0 그리고 ECX > 0

반복 시 ECX는 자동 감소한다.

1.3 Direction Flag (DF)

문자열 명령어 실행 시 ESI, EDI 증감 방향을 제어한다.

CLD : forward (주소 증가)

STD : backward (주소 감소)

1.4 문자열 이동 크기
명령어	증감 크기
MOVSB	1 byte
MOVSW	2 bytes
MOVSD	4 bytes
1.5 문자열 비교 및 검색

CMPSx : 두 문자열 또는 배열 요소 비교

REPE CMPSx : 값이 다를 때까지 반복 비교

SCASx : 특정 값 검색

2. Irvine32 String Procedures

Irvine32 라이브러리는 널 종료 문자열(null-terminated string) 처리용 프로시저를 제공한다.

2.1 Str_compare

문자열을 첫 문자부터 비교

대소문자 구분

반환값 없음

결과는 플래그로 판단

결과	CF	ZF	분기
string1 < string2	1	0	JB
string1 = string2	0	1	JE
string1 > string2	0	0	JA
2.2 Str_length

문자열 길이 계산

반환값: EAX

널 문자(0)에서 종료

2.3 Str_copy

소스 문자열을 타겟 문자열로 복사

타겟 버퍼 크기 보장 필요

내부적으로 REP MOVSB 사용

2.4 Str_trim

문자열 끝의 특정 문자 제거

문자열 끝에서 역방향 검사

non-delimiter 이후에 널 문자 삽입

처리 가능한 경우:

빈 문자열

delimiter만 있는 문자열

delimiter가 없는 문자열

delimiter가 문자열 앞에만 존재하는 경우

2.5 Str_ucase

문자열의 소문자를 대문자로 변환

ASCII 비트 연산 사용

반환값 없음

3. Two-Dimensional Arrays
3.1 Row-major / Column-major

Row-major: 행 단위 저장

Column-major: 열 단위 저장

x86 및 C 계열 언어는 Row-major 방식을 사용한다.

3.2 Base-Index Addressing
[base + index]


base: 배열 시작 주소

index: 오프셋

3.3 Row-major 2차원 배열 접근
주소 = base + (row_index × row_size) + column_index


base → 행 시작 주소

index → 열 오프셋

3.4 Scale Factor
자료형	배율
BYTE	1
WORD	2
DWORD	4
3.5 Base-Index-Displacement
[base + index × scale + displacement]


displacement는 배열 이름 또는 상수

4. Searching and Sorting Integer Arrays
4.1 Bubble Sort

인접한 요소 비교

순서가 잘못되면 교환

패스마다 최대값이 뒤로 이동

n-1 패스 수행

4.2 Binary Search

정렬된 배열 필요

탐색 범위: first ~ last

mid 계산 후 범위 반으로 축소

발견 시 인덱스 반환
