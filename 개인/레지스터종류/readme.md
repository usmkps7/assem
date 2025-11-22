## 1. 범용 레지스터

| 64-bit | 32-bit | 16-bit | 8-bit   | 용도                      |
| ------ | ------ | ------ | ------- | ----------------------- |
| RAX    | EAX    | AX     | AL / AH | 연산 결과 저장(Accumulator)   |
| RBX    | EBX    | BX     | BL / BH | 베이스 주소(Base)            |
| RCX    | ECX    | CX     | CL / CH | 반복/루프 카운터(Counter)      |
| RDX    | EDX    | DX     | DL / DH | 입·출력, 곱셈/나눗셈에서 사용(Data) |
| RSI    | ESI    | SI     | SIL     | 문자열 처리 시 소스 포인터         |
| RDI    | EDI    | DI     | DIL     | 문자열 처리 시 목적지 포인터        |
| RBP    | EBP    | BP     | BPL     | 스택 프레임 기준(Base Pointer) |
| RSP    | ESP    | SP     | SPL     | 스택 포인터(Stack Pointer)   |

-----------------------

## 2. 인덱스 / 포인터 레지스터

| 레지스터          | 설명                                 |
| ------------- | ---------------------------------- |
| **RIP**       | 다음 실행될 명령어 주소(Instruction Pointer) |
| **RSP**       | 스택 최상단 주소(Stack Pointer)           |
| **RBP**       | 스택 프레임 기준(Base Pointer)            |
| **RSI / RDI** | 문자열 이동, 배열 탐색 등에 사용                |

------------------------

## 3. 세그먼트 레지스터 (Segment Registers)

| 레지스터        | 의미                  |
| ----------- | ------------------- |
| **CS**      | Code Segment        |
| **DS**      | Data Segment        |
| **SS**      | Stack Segment       |
| **ES**      | Extra Segment       |
| **FS / GS** | 추가 세그먼트(스레드·시스템 용도) |


## 4. 플래그 레지스터 (RFLAGS / EFLAGS)

| 이름              | 약자     | 의미                 |
| --------------- | ------ | ------------------ |
| Carry Flag      | **CF** | 무부호 연산에서 자리올림/언더플로 |
| Zero Flag       | **ZF** | 결과가 0인지 여부         |
| Sign Flag       | **SF** | 결과가 음수인지 여부        |
| Overflow Flag   | **OF** | 부호 있는 연산의 오버플로     |
| Parity Flag     | **PF** | 결과의 하위 바이트 짝수 파리티  |
| Auxiliary Carry | **AF** | BCD 연산용            |
| Direction Flag  | **DF** | 문자열 처리 방향          |
| Interrupt Flag  | **IF** | 인터럽트 허용 여부         |
