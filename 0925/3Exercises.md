# 3.9.1 Short Answer — 원문 / 번역 / 정답
## 1. Provide examples of three different instruction mnemonics.

번역 – 서로 다른 종류의 명령어 니모닉 세 가지를 예로 들어라.
정답 – MOV, ADD, SUB (또는 JMP, PUSH 등도 가능)

## 2. What is a calling convention, and how is it used in assembly language declarations?

번역 – 호출 규약(calling convention)이란 무엇이며, 어셈블리 선언에서 어떻게 사용되는가?
정답 – 함수 호출 시 인자 전달 방식, 스택 정리 책임 등을 정의하는 규칙.
PROC 선언 시 STDCALL, CDECL 등 규약을 지정하여 사용.

## 3. How do you reserve space for the stack in a program?

번역 – 프로그램에서 스택 공간을 어떻게 예약하는가?
정답 – .STACK 지시자 또는 스택 크기 선언을 사용하여 예약한다.

## 4. Explain why the term assembler language is not quite correct.

번역 – ‘assembler language’라는 용어가 정확하지 않은 이유는 무엇인가?
정답 – 언어는 “assembly language”이고, assembler는 이를 번역하는 프로그램이기 때문에 용어가 잘못됨.

## 5. Explain the difference between big endian and little endian. Also, look up the origins of this term on the Web.

번역 – 빅엔디안과 리틀엔디안의 차이를 설명하라. 또한 용어의 기원을 설명하라.
정답 – 빅엔디안: 최상위 바이트를 앞 주소에 저장.
리틀엔디안: 최하위 바이트를 앞 주소에 저장.
기원: 소설 '걸리버 여행기'의 계란(big end/little end).

## 6. Why might you use a symbolic constant rather than an integer literal in your code?

번역 – 왜 코드에서 정수 리터럴 대신 기호 상수를 사용할 수 있는가?
정답 – 유지보수 용이, 의미 명확성 증가, 여러 곳에서 값 변경 시 편리.

## 7. How is a source file different from a listing file?

번역 – 소스 파일과 리스팅 파일의 차이는 무엇인가?
정답 – 소스 파일: 사람이 작성한 코드.
리스팅 파일: 어셈블러가 생성한 기계어·오프셋·에러 정보 등이 포함된 출력 파일.

## 8. How are data labels and code labels different?

번역 – 데이터 라벨과 코드 라벨의 차이는?
정답 – 데이터 라벨: 변수·데이터 위치를 지시.
코드 라벨: 실행 제어 흐름(jump, loop 등)에서 사용되는 위치 표시.

## 9. (True/False): An identifier cannot begin with a numeric digit.

번역 – (참/거짓): 식별자는 숫자로 시작할 수 없다.
정답 – True

## 10. (True/False): A hexadecimal literal may be written as 0x3A.

번역 – (참/거짓): 16진수 리터럴은 0x3A처럼 쓸 수 있다.
정답 – False (MASM은 3Ah 같은 형식을 사용)

## 11. (True/False): Assembly language directives execute at runtime.

번역 – (참/거짓): 어셈블리 지시자는 실행 시간에 실행된다.
정답 – False (어셈블 타임에만 처리됨)

## 12. (True/False): Assembly language directives can be written in any combination of uppercase and lowercase letters.

번역 – (참/거짓): 어셈블리 지시자는 대소문자 혼합하여 쓸 수 있다.
정답 – True

## 13. Name the four basic parts of an assembly language instruction.

번역 – 어셈블리 명령어의 네 가지 기본 구성 요소를 써라.
정답 – 라벨, 니모닉, 피연산자, 주석

## 14. (True/False): MOV is an example of an instruction mnemonic.

번역 – (참/거짓): MOV는 명령어 니모닉의 예이다.
정답 – True

## 15. (True/False): A code label is followed by a colon (;), but a data label does not end with a colon.

번역 – (참/거짓): 코드 라벨은 콜론으로 끝나지만 데이터 라벨은 콜론이 없다.
정답 – False (MASM에서는 둘 다 콜론 사용 가능)

## 16. Show an example of a block comment.

번역 – 블록 주석의 예를 보여라.
정답 – 예:

COMMENT !
This is a block comment.
It spans multiple lines.
!

## 17. Why is it not a good idea to use numeric addresses when writing instructions that access variables?

번역 – 변수를 접근하는 명령어를 작성할 때 숫자 주소를 사용하는 것이 좋지 않은 이유는?
정답 – 주소 변경 시 모든 코드를 수정해야 하므로 유지보수성이 매우 떨어짐.

## 18. What type of argument must be passed to the ExitProcess procedure?

번역 – ExitProcess 프로시저에 전달해야 하는 인자의 타입은 무엇인가?
정답 – 32비트 정수 종료 코드 (DWORD)

## 19. Which directive ends a procedure?

번역 – 어떤 지시자가 프로시저를 종료시키는가?
정답 – ENDP

## 20. In 32-bit mode, what is the purpose of the identifier in the END directive?

번역 – 32비트 모드에서 END 지시자 뒤의 식별자는 무엇을 의미하는가?
정답 – 프로그램의 시작점(entry point) 지정

## 21. What is the purpose of the PROTO directive?

번역 – PROTO 지시자의 목적은 무엇인가?
정답 – 프로시저의 원형 선언(인수 타입 등)

## 22. (True/False): An Object file is produced by the Linker.

번역 – (참/거짓): 오브젝트 파일은 링커에 의해 생성된다.
정답 – False (어셈블러가 생성함)

## 23. (True/False): A Listing file is produced by the Assembler.

번역 – (참/거짓): 리스팅 파일은 어셈블러가 생성한다.
정답 – True

## 24. (True/False): A link library is added to a program just before producing an Executable file.

번역 – (참/거짓): 링크 라이브러리는 실행 파일 생성 직전에 프로그램에 추가된다.
정답 – True (링킹 단계에서 포함)

## 25. Which data directive creates a 32-bit signed integer variable?

번역 – 어떤 데이터 지시자가 32비트 signed 정수 변수를 생성하는가?
정답 – SDWORD

## 26. Which data directive creates a 16-bit signed integer variable?

번역 – 어떤 데이터 지시자가 16비트 signed 정수를 생성하는가?
정답 – SWORD

## 27. Which data directive creates a 64-bit unsigned integer variable?

번역 – 어떤 데이터 지시자가 64비트 unsigned 정수를 생성하는가?
정답 – QWORD

## 28. Which data directive creates an 8-bit signed integer variable?

번역 – 어떤 데이터 지시자가 8비트 signed 정수 변수를 생성하는가?
정답 – SBYTE

## 29. Which data directive creates a 10-byte packed BCD variable?

번역 – 어떤 지시자가 10바이트 packed BCD 변수를 생성하는가?
정답 – TBYTE (packed BCD용)

--------------------------------------------------------------

# 3.9.2 Algorithm Workbench

## 1. Define four symbolic constants that represent integer 25 in decimal, binary, octal, and hexadecimal formats.

번역 – 정수 25를 10진수, 2진수, 8진수, 16진수 표현으로 나타내는 기호 상수 4개를 정의하시오.
정답 – 예:

DECVAL = 25
BINVAL = 11001b
OCTVAL = 31o
HEXVAL = 19h

## 2. Find out, by trial and error, if a program can have multiple code and data segments.

번역 – 프로그램이 여러 개의 코드 세그먼트와 데이터 세그먼트를 가질 수 있는지 시험적으로 알아보시오.
정답 – 현대 MASM에서는 일반적으로 하나의 .code, .data 세그먼트 사용을 권장하지만
기술적으로는 여러 세그먼트 선언이 가능하다.
단, 링크 규칙과 segment ordering 문제가 발생하므로 실무에서는 사용하지 않는다.

## 3. Create a data definition for a doubleword that stored it in memory in big endian format.

번역 – 메모리에 빅엔디안 형식으로 저장되는 더블워드 데이터를 정의하시오.
정답 – MASM은 리틀엔디안을 기본 사용하므로, 빅엔디안을 원하면 바이트를 직접 배열해야 한다.
예:

myVal BYTE 12h, 34h, 56h, 78h   ; big-endian 표현

## 4. Find out if you can declare a variable of type DWORD and assign it a negative value. What does this tell you about the assembler’s type checking?

번역 – DWORD 타입 변수에 음수를 저장할 수 있는지 확인하시오. 이것이 어셈블러의 타입 검사에 대해 무엇을 의미하는가?
정답 – 가능하다.

myVar DWORD -5


이는 어셈블러가 자료형을 엄격히 검사하지 않고, 비트 패턴만 저장함을 의미한다.

## 5. Write a program that contains two instructions: (1) add the number 5 to the EAX register, and (2) add 5 to the EDX register. Generate a listing file and examine the machine code generated by the assembler. What differences, if any, did you find between the two instructions?

번역 – 다음 두 명령을 포함하는 프로그램을 작성하고, 생성된 리스팅 파일에서 기계어 코드를 비교하시오.
(1) EAX에 5 더하기
(2) EDX에 5 더하기
두 명령 사이에 어떤 차이가 있는가?
정답 – EAX에 즉값을 더할 때는 단축 인코딩이 존재한다:

ADD EAX, 5   → 05 05 00 00 00  
ADD EDX, 5   → 81 C2 05 00 00 00


즉, EAX 전용 단축 opcode(05) 때문에 기계어가 다르다.

## 6. Given the number 456789ABh, list out its bytes in little-endian order.

번역 – 값 456789ABh을 리틀엔디안 순서의 바이트들로 나열하시오.
정답 –
원래 순서: 45 67 89 AB
리틀엔디안: AB 89 67 45

## 7. Declare an array of 20 initialized unsigned doubleword values.

번역 – 초기값이 있는 unsigned 더블워드 20개 배열을 선언하시오.
정답 – 예:

array DWORD 20 DUP(0)

## 8. Declare an array of 5 bytes and initialize it to the first 5 letters of the alphabet.

번역 – 5바이트 배열을 선언하고 알파벳 처음 5글자로 초기화하시오.
정답 –

letters BYTE 'A','B','C','D','E'

## 9. Declare a 32-bit signed integer variable and initialize it with the smallest possible negative decimal value.

번역 – 32비트 signed 정수에서 표현 가능한 가장 작은 음수 값으로 초기화하시오.
정답 – 가장 작은 값 = –2,147,483,648

minVal SDWORD -2147483648

## 10. Declare an unsigned 16-bit integer variable named wArray and store three initializer values.

번역 – wArray라는 unsigned 16비트 변수(또는 배열)를 선언하고 3개 값을 초기화하시오.
정답 –

wArray WORD 10, 20, 30

## 11. Declare a string variable containing the name of your favorite color. Initialize it as a null-terminated string.

번역 – 좋아하는 색깔 이름을 담는 문자열 변수를 널 종료 문자열로 초기화하시오.
정답 –

colorName BYTE "blue",0

## 12. Declare an uninitialized array of 50 signed doublewords named dArray.

번역 – dArray라는 이름을 가지는, 초기화되지 않은 signed doubleword 50개 배열을 선언하시오.
정답 –

dArray SDWORD 50 DUP(?)

## 13. Declare a string variable containing the word "TEST" repeated 500 times.

번역 – "TEST"라는 단어가 500회 반복된 문자열 변수를 선언하시오.
정답 –
간단히 쓰면:

testStr BYTE 500 DUP("TEST")


(주의: 실제 메모리 크기는 4 * 500 = 2000 bytes)

## 14. Declare an array of 20 unsigned bytes named bArray and initialize all elements to zero.

번역 – bArray라는 unsigned byte 20개 배열을 선언하고 모든 요소를 0으로 초기화하시오.
정답 –

bArray BYTE 20 DUP(0)

## 15. Show the order of individual bytes in memory (lowest to highest) for the following doubleword variable:

val1 DWORD 87654321h
번역 – 다음 더블워드 값이 메모리에 저장될 때, 바이트 순서를 주소 낮은 순 → 높은 순으로 나열하시오.
정답 –
87654321h → 87 65 43 21
리틀엔디안 저장: 21 43 65 87
