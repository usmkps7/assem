# 2. General Concepts (일반 아키텍처 개념)
## 2-1. 마이크로컴퓨터 블록 다이어그램

페이지 3의 그림은 CPU·메모리·I/O장치·버스 구조의 관계를 표현한다. 

구성 요소	설명
CPU (ALU / CU / Clock)	연산과 제어 수행
Registers	내부 임시 저장 공간
Memory Storage	명령어 및 데이터 저장
I/O Device	외부 장치와 통신
Data/Address/Control Bus	CPU–Memory–I/O 간 데이터·주소·제어 신호 전달
## 2-2. CPU Instruction Execution Sequence (명령 실행 단계)

페이지 4 다이어그램 기준. 

단계	설명

Fetch Instruction | 메모리에서 명령어 opcode 읽기

Decode Instruction | CPU가 opcode 분석

Fetch Operands | 레지스터/메모리에서 피연산자 로드

Execute | ALU/연산 유닛이 실행

Update Flags | CF/ZF/SF/OF 등 갱신

Store Result | 결과 저장

Increment IP | 다음 명령어로 이동

## 2-3. Instruction Decode Timeline 예시

PDF p.5의 MOV AX,1234h 예시. 

절차:

IP=1000 → opcode(B8) Fetch

CPU는 MOV AX, imm16 인식

operand 하위 바이트 Fetch

operand 상위 바이트 Fetch

명령어 완성

AX ← 1234h

# 3. 32-bit x86 Processors (32비트 CPU 구조)

## 3-1. Processor Modes (실행 모드)

페이지 10 그림 기준. 

모드	특징
Real-Address Mode	1MB 주소, 직접 하드웨어 접근 가능
Protected Mode	4GB 주소, 보호 기능, 현대 OS 사용
Virtual-8086 Mode	실모드를 가상 환경에서 실행
System Management Mode	제조사 보안·전원 관리 용도

## 3-2. Addressing Capabilities (주소 공간)

페이지 11 그림 기준. 

모드	주소 가능 범위
Real-Address	1MB 제한
Virtual-8086	1MB per program
Protected Mode	4GB 선형 주소
Extended Physical Addressing	최대 64GB 이상(물리)
## 3-3. Register Set (레지스터 구조)

페이지 12 그림 기준. 

General Purpose Registers (32-bit)
레지스터	역할
EAX	연산, 반환값
EBX	주소 계산, 베이스
ECX	반복·카운터
EDX	I/O, 확장 연산
ESI/EDI	메모리 문자열 처리
EBP	스택 프레임 베이스
ESP	스택 포인터
EIP	다음 실행할 명령 주소
EFLAGS	상태 플래그 저장
세부 분할

EAX → AX → AH/AL

EBX → BX → BH/BL

… 동일 구조

## 3-4. Specialized Register Functions (특수 목적 레지스터)

페이지 14 그림 기준. 

레지스터	기능
ESP	스택 주소 관리
EBP	함수 인자·지역 변수 접근
ESI/EDI	고속 메모리 복사(문자열 명령)
EAX	곱셈·나눗셈 등 기본 연산에 사용
ECX	Loop 카운터

## 3-5. Segment Registers

페이지 15 기준. 

세그먼트	용도
CS	명령어 저장
DS	데이터 접근
SS	스택 프레임
ES	문자열 복사
FS	스레드 지역 저장소
GS	OS 내부 데이터

## 3-6. EIP Register

페이지 16 그림 요약. 


EIP는 다음 실행할 명령어의 주소를 저장

명령 실행 시 자동 증가

JMP/CALL/RET 또는 조건 분기에서 변경됨

## 3-7. EFLAGS Register (플래그)

페이지 17 그림 기준. 


플래그	의미
CF	Carry
ZF	Zero
SF	Sign
OF	Overflow
AF	BCD 연산용
PF	Parity

Control Flags(DF, IF 등)도 포함됨.

## 3-8. MMX Technology Overview

페이지 18 그림 기준. 


구성 요소	설명
MMX Registers	64-bit, SIMD 처리
SIMD Instructions	여러 데이터 동시 처리
FPU Sharing	FPU 레지스터와 하드웨어 공유
Multimedia Processing	영상·오디오 성능 향상

## 3-9. Floating-Point Unit (FPU)

페이지 19–20 기준. 


FPU 스택 구조 (80-bit)
레지스터	기능
ST(0)~ST(7)	8개 스택형 레지스터
Opcode Register	FPU 명령어 저장
Control/Status/Tag Register	FPU 상태 관리
3-10. Processor Mode Comparison

페이지 21 표 기준. 


특징	Real Mode	Protected Mode	Virtual-8086
Memory Access	직접 접근	보호됨	제한된 가상 접근
Memory Limit	1MB	4GB	1MB virtual
Program Exec	단일	다중	가상 머신
HW Access	직접	제한	제한

# 4. 64-bit x86-64 Processors

PDF에서는 x86-64의 레지스터 확장·주소 확장·호환성 모드 등을 설명한다. (p.13~27)
핵심만 동일 포맷으로 요약:

항목	내용
확장 레지스터	RAX~R15 (16개), 64-bit
하위 호환	32-bit/16-bit/8-bit 분할 지원
주소 크기	64-bit 선형 주소
64-bit 전용 모드	Long Mode
호환 모드	32-bit/16-bit 실행 가능

# 5. Components of a Typical x86 Computer

(페이지 28~37 전체) 

섹션에서 다루는 구성 요소:

분류	설명
Motherboard	칩셋, 버스, 슬롯 구성
CPU & GPU	연산 처리, 그래픽 렌더링
Main Memory	실행 중 코드/데이터 저장
SSD/HDD	영구 저장장치
I/O Devices	키보드, 마우스, 모니터
System Bus	메모리/CPU/I/O 연결

# 6. Input–Output System

(페이지 38~41) 

I/O 모델 개념 요약:

구성	설명
Port-Mapped I/O	IN/OUT 명령 사용
Memory-Mapped I/O	메모리 주소 공간에 I/O 매핑
Device Drivers	OS 레벨 장치 제어
Interrupts	CPU와 디바이스 간 이벤트 처리

# 7. Chapter Summary (PDF p.43)

핵심 요약:

CPU는 fetch–decode–execute 파이프라인으로 작동

x86은 다양한 모드를 제공 (Real/Protected/V8086)

32-bit와 64-bit 레지스터 모델은 하위 호환 기반

FPU/MMX/SIMD는 연산 성능 향상 기술

메모리·I/O·버스 구성은 시스템 전체 성능을 결정
--------------------------------------------

CPU(ALU, CU, 레지스터, 클)

GHz = 기가헤르츠(GHz) = 10⁹ Hz = 초당 10억 번의 주기(사이클)

3.3GHz cpu= 초당 33억번 주기 cpu

단 "클럭 = 연산" 은 아님

bus = 데이터를 주고받는 통로(통신 회로) = 메모리·입출력 장치를 연결한 회

bus는 하드웨어에서 물리적으로 연결

주로 버스 3종
1. data bus
2. address bus
3. control bus

캐시(cache)는 CPU와 메인 메모리(RAM) 사이에 있는 작은 초고속 메모리

cpu는 빠르지만 메모리는 상대적으로 많이 느림

-> 둘 사이에 cache(캐시)를 사용

---------------------------------------

#프로그램 실행

운영체제에 exe 실행 명령 -> 프로그램의 dir 탐색 -> exe 유무 확인 (if 없음) -> 환경변수 탐색 (if 있으면) -> 파일의 사이즈를 확인해 비어있는 메모리에 올림 -> 닫기버튼 등 종료시 메모리에서 제거

-------------------------------------------------------------------------------

프로텍트 모드: (기본모드)메모리에서 작동중인 각 프로그램 서로 간섭하지 않음

리얼 어드레스 모드: 하드웨어에 직접 접근 할 수 있음

시스템 메니지드 모드: 제조사가 만지는 모드

--------------------------------------------------------------------------------

제네럴 레지스터 vs 특수목적 레지스터

제네럴: EAX, EBX, ECX, EDX


--------------------------------------------------------------------------------

context swiching = 엣지 -> 엑셀로 작업 프로그램을 바꾸면 메모리에 내용을 변경해
