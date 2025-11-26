📌 Assembly – Advanced Procedures 요약
1️⃣ Stack Frame (스택 프레임)

정의: 함수(프로시저) 호출 시 생성되는 스택 영역

포함 요소

매개변수(parameters)

반환 주소(return address)

지역 변수(local variables)

저장된 레지스터(saved registers)

push ebp
mov  ebp, esp   ; 스택 프레임 기준 설정


📌 파라미터 접근:

[EBP+8] : 첫 번째 인자

[EBP+12]: 두 번째 인자

2️⃣ 값 전달 vs 참조 전달
구분	설명
Pass by Value	값 자체를 스택에 복사
Pass by Reference	변수의 주소(offset) 를 전달
배열	항상 참조 전달
AddTwo(val1, val2);        // 값 전달
Swap(&val1, &val2);        // 참조 전달

3️⃣ Calling Convention (32-bit)
✅ C Calling Convention (cdecl)

인자 오른쪽 → 왼쪽 push

호출자(caller) 가 스택 정리

push B
push A
call AddTwo
add esp, 8

✅ STDCALL

피호출자(callee) 가 스택 정리

ret 8

4️⃣ 레지스터 저장/복원

함수 내부에서 레지스터를 사용한다면 반드시 저장 후 복원

push ecx
push edx
...
pop  edx
pop  ecx

5️⃣ Local Variables (지역 변수)

지역 변수는 EBP 아래 (음수 offset) 에 위치

sub esp, 8          ; 로컬 변수 공간 확보
mov [ebp-4], 10
mov [ebp-8], 20
mov esp, ebp        ; 로컬 변수 해제

6️⃣ LEA / ENTER / LEAVE
✅ LEA

주소 계산 전용 명령어 (메모리 접근 ❌)

lea esi, [ebp-30]

✅ ENTER / LEAVE

스택 프레임 자동 생성/해제

enter 8, 0
...
leave


✅ 수동 코드와 동일:

push ebp
mov  ebp, esp
sub  esp, 8

7️⃣ Recursion (재귀)

함수가 자기 자신을 호출

반드시 종료 조건 필요

✅ 팩토리얼 예제 개념:

factorial(n) {
  if (n == 0) return 1;
  return n * factorial(n-1);
}


📌 핵심:

각 호출마다 독립적인 스택 프레임

재귀 종료 시 스택이 역순으로 해제(unwinding)

8️⃣ INVOKE / ADDR / PROC / PROTO
✅ INVOKE

함수 호출을 한 줄로 처리

push / call / stack cleanup 자동

INVOKE Swap, ADDR Array, ADDR [Array+4]

✅ ADDR

INVOKE에서 주소 전달 전용

어셈블리 타임 상수만 허용

9️⃣ PROC Directive
label PROC USES eax ebx,
      param1:PTR DWORD,
      param2:DWORD


USES: 자동 레지스터 저장/복원

매개변수 타입 지정 → 안정성 ↑

기본 calling convention: STDCALL

🔟 다중 모듈 & 접근 제어

PUBLIC: 외부 모듈에서 사용 가능

PRIVATE: 내부 전용

EXTERN / EXTERNDEF: 외부 함수 참조

PUBLIC main
EXTERN AddTwo@8:PROC


📌 @8: 파라미터 총 크기(바이트)

✅ 핵심 요약

스택 프레임 = 함수 실행의 핵심 구조

EBP 기준 주소 계산은 필수 개념

INVOKE + PROC + PROTO → 가독성 & 안정성 최고

재귀 = 스택 흐름 이해의 끝판왕
