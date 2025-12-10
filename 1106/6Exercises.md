
# 6.11.1 Suggestions for Testing Your Code

(코드 테스트를 위한 권장 사항)

● 원문

Always step through your program with a debugger the first time you test it…

● 번역

프로그램을 처음 테스트할 때는 반드시 디버거로 한 단계씩 실행해라. 작은 실수를 놓치기 쉽기 때문이며, 디버거는 내부 동작을 정확하게 보여준다.

● 핵심 요약

프로그램 테스트의 첫 단계는 반드시 디버깅 실행(step run)

초보 실수를 빠르게 잡을 수 있음

● 원문

If the specifications call for a signed array, be sure to include some negative values.

● 번역

signed 배열을 테스트해야 한다면, 반드시 몇 개의 음수 값도 포함해 테스트하라.

● 핵심 요약

signed 연산 테스트 = 음수 포함 필수

● 원문

When a range of input values is specified, include test data that falls before, on, and after these boundaries.

● 번역

입력 값의 범위가 지정된 경우, 그 범위 이전·경계·이후 모두를 테스트에 포함하라.

● 핵심 요약

boundary test (lower, boundary, upper) 진행해야 함

● 원문

Create multiple test cases, using arrays of different lengths.

● 번역

서로 다른 길이를 가진 배열로 여러 테스트 케이스를 만들어라.

● 핵심 요약

다양한 배열 길이로 테스트

● 원문

When writing a program that writes to an array, the Visual Studio debugger’s Memory window is the best tool…

● 번역

배열에 데이터를 쓰는 프로그램을 작성할 때, 배열의 상태를 확인하기 위해 Visual Studio의 Memory window가 가장 유용하다.

● 핵심 요약

디버거의 Memory window 활용 (hex/decimal 보기 가능)

● 원문

Immediately after calling the procedure you’re testing, call it a second time to verify that the procedure has preserved all registers…

● 번역

테스트하는 프로시저를 한 번 호출한 직후, 바로 다시 한 번 호출해서 레지스터가 제대로 보존됐는지 확인하라.

● 핵심 요약

프로시저 호출 2회 반복 → 레지스터 보존 여부 확인

특히 ESI/EDI/EBX 같은 보존 레지스터 체크

예시 코드 원문
mov esi,OFFSET array
mov ecx,count
call CalcSum
call CalcSum ; call second time to see if registers are preserved

해석

두 번째 호출에서 레지스터가 깨졌다면, 프로시저 내부에서 보존해야 할 레지스터를 잘못 사용한 것이다.

● 원문

Usually there is a single return value in EAX… therefore you usually should not use EAX as an input parameter.

● 번역

대부분 반환값은 EAX에 들어가므로, 입력 인자로 EAX를 사용해서는 안 된다.

● 요약

EAX는 반환 값 용도로 예약된 레지스터

입력용으로 사용하면 호출 후 값이 덮어쓰기 됨

● 원문

If you’re planning to pass more than one array to a procedure, make sure you do not refer to the array by name inside the procedure. Instead, pass the offset using ESI or EDI…

● 번역

여러 배열을 프로시저에 넘길 때는, 프로시저 내부에서 배열 이름을 직접 참조하지 마라.
대신 호출 전에 ESI/EDI에 배열 주소(OFFSET)를 넣어 전달하라.

● 핵심 요약

배열 이름 직접 접근 X

ESI, EDI 사용하여 간접 주소 방식으로 접근

● 원문

If you need to create a variable for use only inside the procedure, you can use the .data directive before the variable…

● 번역

프로시저 내부에서만 사용될 변수가 필요하다면, .data 지시자를 프로시저 내부에 작성하여 정의할 수 있다.

● 핵심 요약

프로시저 내부에 .data 선언 가능

단, 이는 지역 변수처럼 보이지만 전역 데이터 세그먼트에 실제로는 존재함

재호출 시 leftover 값이 남아 있으므로, 매 호출마다 초기화 필요

원문 예시 코드
MyCoolProcedure PROC
.data
  sum SDWORD ?
.code
  mov sum,0

번역 + 요약

sum은 지역 변수처럼 보이지만 실제로는 전역 데이터 세그먼트에 위치

프로시저 내부 전용이라는 의도를 보여줄 수 있음

여러 번 호출할 경우 초기화를 반드시 수행해야 한다
