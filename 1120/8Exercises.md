# 8.10.1 Short Answer
## 1. Which statements belong in a procedure’s epilogue when the procedure has stack parameters and local variables?

번역 - 스택 매개변수와 로컬 변수를 가진 프로시저에서, 에필로그에 포함되어야 하는 명령들은 무엇인가?
정답 -

mov esp,ebp (로컬 변수 영역 제거)

pop ebp (이전 베이스 포인터 복원)

필요하다면 ret N (STD­CALL이면 매개변수 바이트수 N을 함께 사용하여 스택 정리)

## 2. When a C function returns a 32-bit integer, where is the return value stored?

번역 - C 함수가 32비트 정수를 반환할 때, 반환 값은 어디에 저장되는가?
정답 - EAX 레지스터.

## 3. How does a program using the STDCALL calling convention clean up the stack after a procedure call?

번역 - STD­CALL 호출 규약을 사용할 때, 프로시저 호출 후 스택은 어떻게 정리되는가?
정답 - 피호출자(callee)가 에필로그에서 ret N을 사용하여 RET가 매개변수 바이트수만큼 스택을 한 번에 정리한다.

## 4. How is the LEA instruction more powerful than the OFFSET operator?

번역 - LEA 명령어가 OFFSET 연산자보다 더 강력한 이유는 무엇인가?
정답 -

OFFSET 는 컴파일 시점에 심벌 주소만 계산할 수 있다.

LEA 는 실행 시점에 임의의 유효 주소(베이스 + 인덱스×스케일 + 변위)를 계산할 수 있어, 주소 계산뿐 아니라 정수 연산(간단한 곱셈/덧셈)에도 활용 가능하다.

## 5. In the C++ example shown in Section 8.2.3, how much stack space is used by a variable of type int?

번역 - 8.2.3절의 C++ 예제에서, int 형 변수 하나가 사용하는 스택 공간은 얼마인가?
정답 - 4바이트.

## 6. What advantages might the C calling convention have over the STDCALL calling convention?

번역 - C(또는 CDECL) 호출 규약이 STD­CALL에 비해 가질 수 있는 장점은 무엇인가?
정답 -

호출자(caller)가 스택을 정리하므로 가변 인자 함수(printf 등)를 지원하기 쉽다.

C/C++ 라이브러리와의 호환성이 높다.

## 7. (True/False): When using the PROC directive, all parameters must be listed on the same line.

번역 - (참/거짓): PROC 지시자를 사용할 때 모든 매개변수는 같은 줄에 적어야 한다.
정답 - False.
줄 바꿈과 계속(line continuation)을 사용하여 여러 줄에 나눠 쓸 수 있다.

## 8. (True/False): If you pass a variable containing the offset of an array of bytes to a procedure that expects a pointer to an array of words, the assembler will flag this as an error.

번역 - (참/거짓): 바이트 배열의 오프셋을 담은 변수를, 워드 배열 포인터를 기대하는 프로시저에 넘기면 어셈블러가 오류로 잡아준다.
정답 - False.
둘 다 32비트 주소이므로 어셈블러는 구분하지 못하고, 타입 불일치는 런타임 논리 오류일 뿐이다.

## 9. (True/False): If you pass an immediate value to a procedure that expects a reference parameter, you can generate a general-protection fault.

번역 - (참/거짓): 참조 매개변수를 기대하는 프로시저에 즉값(immediate)을 넘기면 일반 보호 예외(GPF)가 발생할 수 있다.
정답 - True.
즉값이 잘못된 메모리 주소로 해석되어, 그 위치에 접근하려 할 때 보호 오류가 발생할 수 있다.

-------------------------------------------

# 8.10.2 Algorithm Workbench
## 1. Here is a calling sequence for a procedure named AddThree that adds three doublewords (assume that the STDCALL calling convention is used):
push 10h
push 20h
push 30h
call AddThree


Draw a picture of the procedure’s stack frame immediately after EBP has been pushed on the runtime stack.
번역 - 위와 같이 AddThree를 호출한다고 할 때(STD­CALL), 런타임 스택에서 EBP가 push된 직후의 스택 프레임 모양을 그려라.
정답 - push ebp 후 mov ebp,esp 가 실행됐다고 보면, 스택(EBP 기준)은:

[EBP+16] = 10h (세 번째 인수)

[EBP+12] = 20h (두 번째 인수)

[EBP+8 ] = 30h (첫 번째 인수)

[EBP+4 ] = 반환 주소(return address)

[EBP ] = 호출자의 EBP (saved EBP)

(주소는 위에서 아래로 증가한다고 가정)

## 2. Create a procedure named AddThree that receives three integer parameters and calculates and returns their sum in the EAX register.

번역 - 세 개의 정수 매개변수를 받아 그 합을 EAX 레지스터에 반환하는 AddThree 프로시저를 작성하라.
정답 - 동작 아이디어:

매개변수 정의: a:DWORD, b:DWORD, c:DWORD

EAX = a + b + c 계산 후 반환.

STD­CALL이면 ret 12 로 세 인수(3×4바이트)를 정리.

예시 동작:

AddThree PROC a:DWORD, b:DWORD, c:DWORD
    mov eax,a
    add eax,b
    add eax,c
    ret 12            ; 세 개 인수(3*4바이트) 제거
AddThree ENDP

## 3. Declare a local variable named anArray that is a pointer to an array of doublewords.

번역 - 더블워드 배열을 가리키는 포인터형 로컬 변수 anArray 를 선언하라.
정답 -

LOCAL anArray:PTR DWORD

## 4. Declare a local variable named buffer that is an array of 20 bytes.

번역 - 바이트 20개짜리 배열 buffer를 로컬 변수로 선언하라.
정답 -

LOCAL buffer[20]:BYTE

## 5. Declare a local variable named pwArray that points to a 16-bit unsigned integer.

번역 - 16비트 부호 없는 정수를 가리키는 포인터형 로컬 변수 pwArray를 선언하라.
정답 -

LOCAL pwArray:PTR WORD

## 6. Declare a local variable named myByte that holds an 8-bit signed integer.

번역 - 8비트 signed 정수를 저장하는 myByte라는 로컬 변수를 선언하라.
정답 -

LOCAL myByte:SBYTE

## 7. Declare a local variable named myArray that is an array of 20 doublewords.

번역 - 더블워드 20개짜리 배열 myArray 를 로컬 변수로 선언하라.
정답 -

LOCAL myArray[20]:DWORD

## 8. Create a procedure named SetColor that receives two stack parameters: forecolor and backcolor, and calls the SetTextColor procedure from the Irvine32 library.

번역 - 두 개의 스택 매개변수 forecolor, backcolor를 받아 Irvine32 라이브러리의 SetTextColor를 호출하는 SetColor 프로시저를 작성하라.
정답 - 개념적으로:

SetColor PROC forecolor:DWORD, backcolor:DWORD
    push backcolor        ; Irvine32 SetTextColor(fore, back) 순서에 맞게
    push forecolor
    call SetTextColor
    ret 8                 ; 두 인수 제거 (STD­CALL이면)
SetColor ENDP

## 9. Create a procedure named WriteColorChar that receives three stack parameters: char, forecolor, and backcolor. It displays a single character, using the color attributes specified in forecolor and backcolor.

번역 - char, forecolor, backcolor 세 개의 스택 매개변수를 받아, 해당 전경/배경 색으로 문자 하나를 출력하는 WriteColorChar 프로시저를 작성하라.
정답 - 동작 아이디어:

SetColor처럼 SetTextColor를 먼저 호출해 색을 설정.

char 값을 AL 또는 EAX로 옮겨 Irvine32 WriteChar 나 WriteString에 전달.

예시:

WriteColorChar PROC ch:BYTE, forecolor:DWORD, backcolor:DWORD
    ; 색 설정
    push backcolor
    push forecolor
    call SetTextColor

    ; 문자 출력
    movzx eax,ch        ; ch 를 AL/EAX에
    call WriteChar

    ret 12              ; 세 인수(3*4바이트) 제거
WriteColorChar ENDP

## 10. Write a procedure named DumpMemory that encapsulates the DumpMem procedure in the Irvine32 library. Use declared parameters and the USES directive. The following is an example of how it should be called:

INVOKE DumpMemory, OFFSET array, LENGTHOF array, TYPE array
번역 - Irvine32의 DumpMem을 감싸는 DumpMemory 프로시저를 작성하라. 선언된 매개변수와 USES 지시자를 사용하고, 위와 같은 형태로 호출될 수 있어야 한다.
정답 - 세 개의 매개변수(배열 주소, 길이, 타입)를 받아 그대로 DumpMem에 전달하는 래퍼.

DumpMemory PROTO pArray:PTR BYTE, len:DWORD, elemSize:DWORD

DumpMemory PROC USES esi, pArray:PTR BYTE, len:DWORD, elemSize:DWORD
    INVOKE DumpMem, pArray, len, elemSize
    ret
DumpMemory ENDP


(실제 USES 레지스터는 필요에 따라 조정 가능)

## 11. Declare a procedure named MultArray that receives two pointers to arrays of doublewords, and a third parameter indicating the number of array elements. Also, create a PROTO declaration for this procedure.

번역 - 더블워드 배열 두 개의 포인터와, 배열 원소 개수를 나타내는 세 번째 매개변수를 받는 MultArray 프로시저를 선언하고, 그에 대한 PROTO 선언도 작성하라.
정답 -

MultArray PROTO pArr1:PTR DWORD, pArr2:PTR DWORD, count:DWORD

MultArray PROC USES esi edi ecx, pArr1:PTR DWORD, pArr2:PTR DWORD, count:DWORD
    ; 여기서 pArr1, pArr2, count를 사용해 두 배열의 요소를
    ; 곱하거나 원하는 연산을 수행하는 본문을 작성
    ret 12
MultArray ENDP
