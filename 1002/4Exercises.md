# 4.9.1 Short Answer
## 1. What will be the value in EDX after each of the lines marked (a) and (b) execute?
.data
one WORD 8002h
two WORD 4321h
.code
mov  edx,21348041h
movsx edx,one        ; (a)
movsx edx,two        ; (b)


번역 - (a), (b) 줄이 실행된 후 각각 EDX 레지스터의 값은 무엇인가?
정답 -
(a) one = 8002h 는 16비트에서 최상위 비트가 1 → 음수이므로 부호 확장 → EDX = FFFF8002h
(b) two = 4321h 는 양수 → 부호 확장 → EDX = 00004321h

### 2. What will be the value in EAX after the following lines execute?
mov eax,1002FFFFh
inc ax


번역 - 위 코드 실행 후 EAX의 값은?
정답 - AX = FFFFh → inc ax 후 0000h, 상위 16비트는 그대로 1002h 유지 → EAX = 10020000h

## 3. What will be the value in EAX after the following lines execute?
mov eax,30020000h
dec ax


번역 - 위 코드 실행 후 EAX의 값은?
정답 - AX = 0000h → dec ax 후 FFFFh → EAX = 3002FFFFh

## 4. What will be the value in EAX after the following lines execute?
mov eax,1002FFFFh
neg ax


번역 - 위 코드 실행 후 EAX의 값은?
정답 - AX = FFFFh, NEG AX = 0001h → 상위 16비트 1002h 유지 → EAX = 10020001h

## 5. What will be the value of the Parity flag after the following lines execute?
mov al,1
add al,3


번역 - 위 코드 실행 후 Parity 플래그 값은?
정답 - AL: 1 + 3 = 4 (0000 0100b, 1비트만 1 → 홀수 개) → PF = 0 (클리어)

## 6. What will be the value of EAX and the Sign flag after the following lines execute?
mov eax,5
sub eax,6


번역 - 위 코드 실행 후 EAX와 Sign 플래그 값은?
정답 - 5 − 6 = −1 → EAX = FFFFFFFFh, 최상위 비트 1 → SF = 1

## 7. In the following code, the value in AL is intended to be a signed byte. Explain how the Overflow flag helps, or does not help you, to determine whether the final value in AL falls within a valid signed range.
mov al,-1
add al,130


번역 - AL을 signed byte로 볼 때, 최종 결과가 유효 범위(−128~127)에 있는지 판단하는 데 Overflow 플래그가 어떻게 도움이 되는지(혹은 도움이 안 되는지) 설명하라.
정답 -

AL = -1 = 0FFh, 130 = 82h → 0FFh + 82h = 181h → 결과 8비트 = 81h (−127).

두 피연산자는 둘 다 음수(FFh, 82h), 결과도 음수(81h)이므로 OF = 0.

OF = 0 이므로 signed 범위를 벗어난 오버플로는 발생하지 않았음을 의미 → 결과 −127은 유효 범위 내.

따라서 이 경우 Overflow 플래그를 보면 결과가 범위를 넘어갔는지 여부를 알 수 있다.

## 8. What value will RAX contain after the following instruction executes?
mov rax,44445555h


번역 - 위 명령 실행 후 RAX의 값은?
정답 - mov rax,imm32 는 32비트를 부호 확장하여 64비트에 저장. 44445555h의 최상위 비트는 0 → 상위 32비트 0 →
RAX = 00000000 44445555h

## 9. What value will RAX contain after the following instructions execute?
.data
dwordVal DWORD 84326732h
.code
mov rax,0FFFFFFFF00000000h
mov rax,dwordVal


번역 - 위 명령들 실행 후 RAX의 값은?
정답 - mov rax,dwordVal 은 32비트 메모리를 64비트 레지스터로 로드할 때 zero-extend.
→ RAX = 00000000 84326732h

## 10. What value will EAX contain after the following instructions execute?
.data
dVal DWORD 12345678h
.code
mov ax,3
mov WORD PTR dVal+2,ax
mov eax,dVal


번역 - 위 코드 실행 후 EAX의 값은?
정답 -

초기 dVal = 12345678h → 메모리: 78 56 34 12

WORD PTR dVal+2 는 상위 워드(34 12)를 가리킴. 여기에 0003h 저장 → 03 00

새 메모리: 78 56 03 00 → 역순으로 읽으면 00035678h
→ EAX = 00035678h

## 11. What will EAX contain after the following instructions execute?
.data
dVal DWORD ?
.code
mov dVal,12345678h
mov ax,WORD PTR dVal+2
add ax,3
mov WORD PTR dVal,ax
mov eax,dVal


번역 - 위 코드 실행 후 EAX의 값은?
정답 -

dVal = 12345678h → 메모리: 78 56 34 12

WORD PTR dVal+2 = 상위 워드 = 1234h

AX = 1234h + 3 = 1237h → 메모리로 저장 시 하위 워드(바이트 0,1)에 37 12

최종 메모리: 37 12 34 12 → 역순으로 읽으면 12341237h
→ EAX = 12341237h

## 12. (Yes/No): Is it possible to set the Overflow flag if you add a positive integer to a negative integer?

번역 - (예/아니오): 양수와 음수를 더할 때 Overflow 플래그가 설정될 수 있는가?
정답 - No.
서로 부호가 다른 두 수의 덧셈에서는 signed overflow가 발생하지 않는다.

## 13. (Yes/No): Will the Overflow flag be set if you add a negative integer to a negative integer and produce a positive result?

번역 - (예/아니오): 음수 + 음수의 결과가 양수가 되면 Overflow 플래그가 설정되는가?
정답 - Yes.
동일한 부호(둘 다 음수)의 합이 반대 부호(양수)가 되면 OF = 1.

## 14. (Yes/No): Is it possible for the NEG instruction to set the Overflow flag?

번역 - (예/아니오): NEG 명령이 Overflow 플래그를 설정할 수 있는가?
정답 - Yes.
최소값(예: 80h, 8000h, 80000000h)을 부호 반전하면 표현 불가능한 양수가 되어 OF = 1.

## 15. (Yes/No): Is it possible for both the Sign and Zero flags to be set at the same time?

번역 - (예/아니오): Sign 플래그와 Zero 플래그가 동시에 1이 될 수 있는가?
정답 - No.
ZF = 1이면 결과가 0 → 최상위 비트 0 → SF = 0 이어야 한다.

다음 변수 정의는 16–19번에 사용된다:

.data
var1 SBYTE -4,-2,3,1
var2 WORD 1000h,2000h,3000h,4000h
var3 SWORD -16,-42
var4 DWORD 1,2,3,4,5

## 16. For each of the following statements, state whether or not the instruction is valid:

a. mov ax,var1
b. mov ax,var2
c. mov eax,var3
d. mov var2,var3
e. movzx ax,var2
f. movzx var2,al
g. mov ds,ax
h. mov ds,1000h

번역 - 다음 각 명령이 유효한지(올바른지) 여부를 답하라.
정답 -

a. 메모리 8비트 → 레지스터 16비트 (크기 불일치) → Invalid

b. 메모리 WORD → AX(16비트) → Valid

c. 메모리 16비트 → 레지스터 32비트, MOV는 단순 크기 변경 불가 → Invalid

d. 메모리 → 메모리 MOV는 허용되지 않음 → Invalid

e. MOVZX reg16,r/m8만 가능, 16→16 zero-extend 형식 없음 → Invalid

f. MOVZX의 목적지는 반드시 레지스터 → Invalid

g. 16비트 레지스터 AX → 세그먼트 레지스터 DS 로 이동 → Valid

h. 세그먼트 레지스터에 즉값 직접 로드는 불가 → Invalid
(반드시 mov ax,1000h 후 mov ds,ax 형태)

## 17. What will be the hexadecimal value of the destination operand after each of the following instructions execute in sequence?
mov al,var1        ; a.
mov ah,[var1+3]    ; b.


번역 - 위 두 명령이 순서대로 실행된 후, 각 명령의 목적지 피연산자 값(AL, AH)은 16진수로 얼마인가?
정답 -

var1 요소들: -4, -2, 3, 1 → 16진: FC, FE, 03, 01

a. AL = FC

b. [var1+3] = 네 번째 요소 = 01h → AH = 01

## 18. What will be the value of the destination operand after each of the following instructions execute in sequence?
mov ax,var2        ; a.
mov ax,[var2+4]    ; b.
mov ax,var3        ; c.
mov ax,[var3-2]    ; d.


번역 - 위 네 명령 실행 후 각 명령의 목적지(AX) 값은?
정답 -

var2 = WORD 1000h,2000h,3000h,4000h

var3 = SWORD -16,-42 (→ FFF0h, FFD6h)

a. AX = 1000h (var2 첫 WORD)
b. [var2+4] = 세 번째 WORD = 3000h → AX = 3000h
c. AX = FFF0h (−16의 16비트 표현)
d. [var3-2] 는 var3 앞 주소의 WORD → 어떤 값인지 정의되지 않음 → AX = (알 수 없음, 정의되지 않은 값)

## 19. What will be the value of the destination operand after each of the following instructions execute in sequence?
mov   edx,var4        ; a.
movzx edx,var2        ; b.
mov   edx,[var4+4]    ; c.
movsx edx,var1        ; d.


번역 - 위 네 명령 실행 후 각 명령의 목적지(EDX) 값은?
정답 -

var4 = DWORD 1,2,3,4,5

var2 첫 WORD = 1000h

var1 첫 바이트 = -4 = FCh

a. EDX = 00000001h
b. EDX = 00001000h (WORD 1000h zero-extend)
c. [var4+4] = 두 번째 DWORD = 2 → EDX = 00000002h
d. movsx edx,var1 : -4 sign-extend → EDX = FFFFFFFCh

-----------------------------------------------------------

# 4.9.2 Algorithm Workbench

(여기부터는 “어떻게 작성해야 하는지”가 핵심이므로, 정답에 예시 명령어 시퀀스를 함께 적어준다.)

## 1. Write a sequence of MOV instructions that will exchange the upper and lower words in a doubleword variable named three.

번역 - three라는 더블워드 변수에서 상위 16비트와 하위 16비트를 서로 교환하는 MOV 명령 시퀀스를 작성하라.
정답 - 임시 레지스터를 사용해 교환:

mov ax,WORD PTR three      ; 하위 워드
mov bx,WORD PTR three+2    ; 상위 워드
mov WORD PTR three,bx
mov WORD PTR three+2,ax

## 2. Using the XCHG instruction no more than three times, reorder the values in four 8-bit registers from the order A,B,C,D to B,C,D,A.

번역 - 네 개의 8비트 레지스터에 A,B,C,D 순서로 들어 있는 값을, XCHG를 최대 세 번만 사용하여 B,C,D,A 순서로 재배열하라.
정답 - 예: AL=A, BL=B, CL=C, DL=D 라고 하면

xchg al,bl    ; B,A,C,D
xchg al,cl    ; B,C,A,D
xchg al,dl    ; B,C,D,A

## 3. … parity bit … AL register contains 01101001.

번역 - 전송 메시지는 짝수 개의 1비트를 만들기 위해 parity bit를 함께 보낸다. AL 레지스터에 01101001b가 들어 있다고 할 때, 산술(또는 논리) 연산과 Parity 플래그를 사용해서 이 바이트가 짝수 패리티인지 홀수 패리티인지 판별하는 방법을 보여라.
정답 - 값은 변경하지 않고 Parity 플래그만 갱신하면 된다.

add al,0      ; 또는 test al,al
; PF = 1 이면 짝수 개의 1비트 (even parity)
; PF = 0 이면 홀수 개의 1비트 (odd parity)

## 4. Write code using byte operands that adds two negative integers and causes the Overflow flag to be set.

번역 - 바이트 피연산자를 사용하여 두 음수를 더한 결과 Overflow 플래그가 설정되도록 하는 코드를 작성하라.
정답 - 예: −100 + −50 = −150 (표현 불가, 양수로 wrap)

mov al,-100
add al,-50    ; OF = 1

## 5. Write a sequence of two instructions that use addition to set the Zero and Carry flags at the same time.

번역 - 덧셈으로 Zero와 Carry 플래그를 동시에 1로 만드는 두 개의 명령을 작성하라.
정답 -

mov al,0FFh
add al,1      ; 결과 00h, ZF=1, CF=1

## 6. Write a sequence of two instructions that set the Carry flag using subtraction.

번역 - 뺄셈으로 Carry 플래그를 1로 만드는 두 개의 명령을 작성하라.
정답 -

mov al,0
sub al,1      ; 0 − 1 → borrow 발생 → CF = 1

## 7. Implement the following arithmetic expression in assembly language:

EAX = −val2 + 7 − val3 + val1.
(32-bit int)

번역 - EAX = -val2 + 7 - val3 + val1을 어셈블리 명령으로 구현하라. (val1,val2,val3는 32비트 정수 변수)
정답 - 한 가지 예:

mov eax,7
sub eax,val2     ; -val2 + 7
sub eax,val3     ; -val2 + 7 - val3
add eax,val1     ; 최종식

## 8. Write a loop that iterates through a doubleword array and calculates the sum of its elements using a scale factor with indexed addressing.

번역 - 더블워드 배열의 모든 원소를 순회하며 합을 구하는 루프를 작성하되, 인덱스에 스케일 팩터(×4)를 사용하는 주소지정을 사용하라.
정답 - 개념 예:

; ESI = 배열 시작 주소, ECX = 요소 개수
xor eax,eax          ; 합 = 0
mov ebx,0            ; 인덱스 i = 0
L1:
  add eax,[esi+ebx*4] ; DWORD[i]
  inc ebx
  loop L1
; EAX에 합이 저장

## 9. Implement the following expression in assembly language:

AX = (val2 + BX) − val4. (val2,val4: 16-bit)

번역 - AX = (val2 + BX) - val4 를 어셈블리 명령으로 구현하라. (val2, val4는 16비트 정수 변수)
정답 -

mov ax,val2
add ax,bx
sub ax,val4

## 10. Write a sequence of two instructions that set both the Carry and Overflow flags at the same time.

번역 - Carry와 Overflow 플래그가 동시에 1이 되도록 하는 두 개의 명령을 작성하라.
정답 - 예: −128 + −128 (signed) → 0, CF와 OF 모두 1

mov al,80h     ; -128
add al,80h     ; 결과 00h, CF=1, OF=1

## 11. Write a sequence of instructions showing how the Zero flag could be used to indicate unsigned overflow after executing INC and DEC instructions.

번역 - INC, DEC 명령을 사용한 뒤, Zero 플래그를 이용해 부호 없는 오버플로(또는 언더플로)를 감지하는 예를 작성하라.
정답 - 예: 16비트 카운터가 0xFFFF에서 0으로 넘어가면 unsigned overflow로 취급:

inc ax
jnz  NoOverflow   ; ZF=1 이면 0이 됨 → overflow
; 여기서 overflow 처리
NoOverflow:


DEC도 마찬가지로, 1에서 0으로 내려갈 때 ZF=1을 이용해 경계 도달을 감지할 수 있다.

다음 데이터는 12–18번에서 사용:

.data
myBytes BYTE 10h,20h,30h,40h
myWords WORD 3 DUP(?),2000h
myString BYTE "ABCDE"

## 12. Insert a directive in the given data that aligns myBytes to an even-numbered address.

번역 - myBytes가 짝수 주소에 위치하도록 정렬하는 지시자를 추가하라.
정답 - myBytes 선언 앞에 다음과 같이 정렬:

ALIGN 2
myBytes BYTE 10h,20h,30h,40h

## 13. What will be the value of EAX after each of the following instructions execute?

a. mov eax,TYPE myBytes
b. mov eax,LENGTHOF myBytes
c. mov eax,SIZEOF myBytes
d. mov eax,TYPE myWords
e. mov eax,LENGTHOF myWords
f. mov eax,SIZEOF myWords
g. mov eax,SIZEOF myString

번역 - 각 명령 실행 후 EAX 값은?
정답 -

a. TYPE = 요소 크기 = 바이트 1 → EAX = 1

b. LENGTHOF = 요소 개수 = 4 → EAX = 4

c. SIZEOF = 전체 바이트 수 = 4×1 = 4 → EAX = 4

d. myWords는 WORD → TYPE = 2 → EAX = 2

e. myWords 요소: 3 DUP(?),2000h → 4개 → EAX = 4

f. 전체 크기 = 4×2 = 8 바이트 → EAX = 8

g. "ABCDE" → 5바이트 → SIZEOF = 5 → EAX = 5

## 14. Write a single instruction that moves the first two bytes in myBytes to the DX register. The resulting value will be 2010h.

번역 - myBytes의 처음 두 바이트를 DX 레지스터로 옮기는 단일 명령을 쓰고, 그 결과가 2010h가 되도록 하라.
정답 -

mov dx,WORD PTR myBytes      ; 메모리: 10h,20h → DX = 2010h

## 15. Write an instruction that moves the second byte in myWords to the AL register.

번역 - myWords의 “두 번째 바이트” 를 AL로 옮기는 명령을 작성하라.
정답 - 배열의 두 번째 바이트는 myWords+1 위치:

mov al,BYTE PTR myWords+1

## 16. Write an instruction that moves all four bytes in myBytes to the EAX register.

번역 - myBytes의 네 바이트 전체를 EAX로 옮기는 명령을 작성하라.
정답 -

mov eax,DWORD PTR myBytes

## 17. Insert a LABEL directive in the given data that permits myWords to be moved directly to a 32-bit integer register.

번역 - myWords를 32비트 레지스터로 바로 옮길 수 있도록 LABEL 지시자를 추가하라.
정답 - WORD 배열을 DWORD로 다시 라벨링:

myWords WORD 3 DUP(?),2000h
myWordsD LABEL DWORD
; 이후  mov eax,myWordsD  와 같이 사용 가능

## 18. Insert a LABEL directive in the given data that permits myBytes to be moved directly to a 16-bit register.

번역 - myBytes를 16비트 레지스터로 바로 옮길 수 있도록 LABEL 지시자를 추가하라.
정답 -

myBytes BYTE 10h,20h,30h,40h
myBytesW LABEL WORD
; 이후  mov ax,myBytesW  로 첫 두 바이트(2010h)를 AX로 이동

------------------------------------------------------------

# 4.10 Programming Exercises

## 1. Converting from Big Endian to Little Endian

원문
Write a program that uses the variables below and MOV instructions to copy the value from bigEndian to littleEndian, reversing the order of the bytes. The number’s 32-bit value is understood to be 12345678h.

.data
bigEndian  BYTE 12h,34h,56h,78h
littleEndian DWORD ?


번역
아래 변수를 사용하고 MOV 명령만 사용하여, bigEndian에 저장된 바이트 순서를 뒤집어서 littleEndian에 복사하는 프로그램을 작성하라. 전체 32비트 값은 12345678h가 되어야 한다.

정답 (풀이 아이디어)

bigEndian 은 메모리에 12 34 56 78 순서로 있음.

리틀엔디안 DWORD 12345678h는 메모리에 78 56 34 12 순으로 저장되어야 함.

따라서 littleEndian의 각 바이트 위치에 bigEndian 의 반대 순서를 써 주면 된다.

예시 동작 흐름(개념):

; littleEndian의 첫 바이트에 bigEndian의 마지막 바이트
mov al, [bigEndian+3]   ; 78h
mov BYTE PTR littleEndian, al

mov al, [bigEndian+2]   ; 56h
mov BYTE PTR littleEndian+1, al

mov al, [bigEndian+1]   ; 34h
mov BYTE PTR littleEndian+2, al

mov al, [bigEndian]     ; 12h
mov BYTE PTR littleEndian+3, al

## 2. Exchanging Pairs of Array Values

원문
Write a program with a loop and indexed addressing that exchanges every pair of values in an array with an even number of elements. Therefore, item1 will exchange with item2, item3 with item4, and so on.

번역
원소 수가 짝수인 배열에서, 루프와 인덱스 주소 지정을 사용하여 인접한 값들을 서로 교환하는 프로그램을 작성하라. 즉, 1번과 2번, 3번과 4번, … 이런 식으로 자리 바꿈.

정답 (풀이 아이디어)

인덱스 i를 0,2,4,… 로 증가시키며 A[i] ↔ A[i+1] 교환.

교환은 임시 레지스터 하나(예: EAX)를 사용.

개념 흐름:

; ESI = 배열 시작 주소, ECX = 배열 원소 개수(짝수)
xor ebx, ebx               ; ebx = i = 0
L1:
    mov ax, [esi+ebx*2]       ; A[i]
    mov dx, [esi+ebx*2+2]     ; A[i+1]
    mov [esi+ebx*2], dx
    mov [esi+ebx*2+2], ax
    add ebx, 2
    cmp ebx, ecx
    jb  L1


(원소가 WORD라고 가정; DWORD면 *4 로 변경하면 됨.)

## 3. Summing the Gaps Between Array Values

원문
Write a program with a loop and indexed addressing that calculates the sum of all the gaps between successive array elements. The array elements are doublewords, sequenced in nondecreasing order. For example, the array [0,2,5,9,10] has gaps of 2,3,4,1, whose sum equals 10.

번역
루프와 인덱스 주소 지정을 사용하여, 배열의 인접한 원소들 사이의 “차이(갭)”를 모두 더하는 프로그램을 작성하라. 배열은 DWORD들이고 오름차순(내림하지 않음)으로 정렬되어 있다. 예: [0,2,5,9,10] → 갭은 2,3,4,1 → 합 10.

정답 (풀이 아이디어)

갭 = A[i+1] − A[i].

i = 0..(n−2) 까지 반복하며 갭을 누적합.

알고리즘:

; ESI = 배열 시작, ECX = 요소 개수
xor eax,eax        ; sum = 0
mov ebx,0          ; i = 0
Lgap:
    mov edx,[esi+ebx*4]      ; A[i]
    mov edi,[esi+ebx*4+4]    ; A[i+1]
    sub edi,edx              ; gap
    add eax,edi              ; sum += gap
    inc ebx
    cmp ebx,ecx
    jb  Lgap_end_check
Lgap_end_check:
    ; 종료 조건: i <= n-2 → 실제 코드는 ECX-1와 비교


마지막 인덱스 처리만 조심해서 i < n-1 조건으로 루프.

## 4. Copying a Word Array to a DoubleWord Array

원문
Write a program that uses a loop to copy all the elements from an unsigned Word (16-bit) array into an unsigned doubleword (32-bit) array.

번역
부호 없는 WORD(16비트) 배열의 모든 원소를 부호 없는 DWORD(32비트) 배열로 복사하는 프로그램을 루프를 사용하여 작성하라.

정답 (풀이 아이디어)

소스: WORD[], 대상: DWORD[].

각 원소에 대해 movzx 또는 zero-extend 로 32비트로 복사.

알고리즘 예:

; ESI = src 시작 (WORD 배열)
; EDI = dst 시작 (DWORD 배열)
; ECX = 요소 개수
Lcopy:
    movzx eax,WORD PTR [esi]    ; 16 → 32비트
    mov   [edi],eax
    add esi,2
    add edi,4
    loop Lcopy

## 5. Fibonacci Numbers

원문
Write a program that uses a loop to calculate the first seven values of the Fibonacci number sequence, described by the formula:
Fib(1) = 1, Fib(2) = 1, Fib(n) = Fib(n−1) + Fib(n−2).

번역
루프를 사용하여 피보나치 수열의 처음 7개 값을 계산하는 프로그램을 작성하라.
정의: Fib(1)=1, Fib(2)=1, Fib(n)=Fib(n-1)+Fib(n-2).

정답 (풀이 아이디어)

두 개의 레지스터에 prev2, prev1 을 저장해 가며 새 값을 계산.

계산 결과를 배열에 저장해도 되고, 단순히 레지스터에만 유지해도 됨.

알고리즘:

; Fib1..Fib7을 배열에 저장한다고 가정
mov eax,1        ; Fib(1)
mov ebx,1        ; Fib(2)
; 배열[0] = 1, 배열[1] = 1 저장
; 그 다음 n=3..7
mov ecx,5        ; 남은 5개
Lfib:
    mov edx,eax      ; edx = Fib(n-2)
    add edx,ebx      ; edx = Fib(n-1)+Fib(n-2)
    ; edx를 배열에 저장
    mov eax,ebx      ; prev2 ← prev1
    mov ebx,edx      ; prev1 ← new
    loop Lfib

##  6. Reverse an Array

원문
Use a loop with indirect or indexed addressing to reverse the elements of an integer array in place. Do not copy the elements to any other array. Use the SIZEOF, TYPE, and LENGTHOF operators to make the program as flexible as possible if the array size and type should be changed in the future.

번역
간접 또는 인덱스 주소 지정을 사용하는 루프를 이용해, 정수 배열을 “제자리(in place)” 에서 역순으로 뒤집는 프로그램을 작성하라. 다른 배열로 복사하면 안 된다. 나중에 배열 크기나 타입이 바뀌어도 쓸 수 있게 SIZEOF, TYPE, LENGTHOF 연산자를 사용하라.

정답 (풀이 아이디어)

앞에서부터 i, 뒤에서부터 j 인덱스를 사용해 A[i] ↔ A[j] 교환.

i < j 동안 계속.

주소 계산 시 TYPE을 곱해서 바이트 오프셋 얻기.

알고리즘 예:

; ESI = 배열 시작 주소
mov ecx, LENGTHOF arr          ; 요소 개수
mov eax, TYPE arr              ; 요소 크기 (예: 4)
mov ebx,0                      ; i = 0
mov edx,ecx
dec edx                        ; j = n-1

Lrev:
    cmp ebx,edx
    jge Done
    mov edi,ebx
    imul edi,eax               ; offset i
    mov ebp,edx
    imul ebp,eax               ; offset j

    mov temp, [esi+edi]        ; swap
    mov  reg, [esi+ebp]
    mov  [esi+edi], reg
    mov  [esi+ebp], temp

    inc ebx
    dec edx
    jmp Lrev
Done:


(레지스터·temp 변수는 적절히 선택.)

##  7. Copy a String in Reverse Order

원문
Write a program with a loop and indirect addressing that copies a string from source to target, reversing the character order in the process. Use the following variables:

source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')


번역
루프와 간접 주소 지정을 사용하여, source 문자열의 문자를 역순으로 target에 복사하는 프로그램을 작성하라. 위의 변수 정의를 사용하라.

정답 (풀이 아이디어)

문자열 길이 = SIZEOF source - 1 (널 문자 제외).

source 뒤에서부터 앞으로 읽고, target은 앞에서부터 채운 뒤 마지막에 널 문자 추가.

알고리즘 개요:

mov ecx, SIZEOF source
dec ecx                   ; 실제 문자 수 n
mov esi, OFFSET source    ; 소스 시작
mov edi, OFFSET target    ; 타깃 시작

; ESI를 소스의 마지막 문자로 이동
add esi, ecx              ; source + n

mov ebx,ecx               ; 카운터 n
Lstr:
    dec esi               ; 이전 문자
    mov al,[esi]
    mov [edi],al
    inc edi
    dec ebx
    jnz Lstr

mov BYTE PTR [edi],0      ; target 끝에 널 문자

##  8. Shifting the Elements in an Array

원문
Using a loop and indexed addressing, write code that rotates the members of a 32-bit integer array forward one position. The value at the end of the array must wrap around to the first position. For example, the array [10,20,30,40] would be transformed into [40,10,20,30].

번역
루프와 인덱스 주소 지정을 사용하여, 32비트 정수 배열의 원소들을 “앞으로” 한 칸씩 회전시키는 코드를 작성하라. 마지막 원소는 맨 앞으로 돌아와야 한다. 예: [10,20,30,40] → [40,10,20,30].

정답 (풀이 아이디어)

마지막 값을 미리 temp에 저장.

뒤에서부터 앞으로 이동: A[i] = A[i-1].

마지막으로 A[0] = temp.

알고리즘 예:

; ESI = 배열 시작, ECX = 요소 개수 n
mov ebx,ecx
dec ebx                         ; 마지막 인덱스 n-1
mov eax,[esi+ebx*4]             ; temp = A[n-1]

; 뒤에서 앞으로 이동
Lrot:
    mov edx,[esi+(ebx-1)*4]     ; A[i-1]
    mov [esi+ebx*4],edx         ; A[i] = A[i-1]
    dec ebx
    jnz Lrot                    ; ebx>0 동안 반복

mov [esi],eax                   ; A[0] = temp
