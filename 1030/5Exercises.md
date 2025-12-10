# 5.8.1 Short Answer
## 1. Which instruction pushes all of the 32-bit general-purpose registers on the stack?

번역 – 모든 32비트 범용 레지스터를 스택에 push하는 명령어는?
정답 – PUSHA (또는 32비트 확장 버전 PUSHAD)

## 2. Which instruction pushes the 32-bit EFLAGS register on the stack?

번역 – 32비트 EFLAGS 레지스터를 push하는 명령은?
정답 – PUSHFD

## 3. Which instruction pops the stack into the EFLAGS register?

번역 – 스택 값을 EFLAGS에 pop 하는 명령은?
정답 – POPFD

## 4. Challenge: Why is NASM’s PUSH EAX EBX ECX better than MASM’s PUSHAD?

번역 – NASM은 여러 레지스터를 나열해 push할 수 있는데, 왜 PUSHAD보다 더 나은가?
정답 –

PUSHAD는 정해진 레지스터 순서 전체를 push한다.

NASM 방식은 원하는 레지스터만 골라서 push 가능 →
불필요한 push/pop 감소 → 빠르고 최적화 가능.

## 5. Challenge: Suppose there were no PUSH instruction. Write two instructions that accomplish the same as push eax.

번역 – PUSH 명령이 없다고 가정하면 push eax와 동일한 효과를 내는 두 명령을 작성하라.
정답 –

sub esp,4
mov [esp],eax

## 6. (True/False): The RET instruction pops the top of the stack into the instruction pointer.

번역 – RET 명령은 스택의 최상위 값을 명령 포인터(EIP)에 pop한다.
정답 – True

## 7. (True/False): Nested procedure calls are not permitted unless the NESTED operator is used.

번역 – 중첩된 프로시저 호출은 NESTED 지시자를 사용해야만 가능하다.
정답 – False
(중첩 호출은 항상 가능. NESTED는 단지 PROC 내에서 EBP 사용 규칙을 조절함.)

## 8. (True/False): In protected mode, each procedure call uses a minimum of 4 bytes of stack space.

번역 – 보호 모드에서 프로시저 호출은 최소 4바이트의 스택 공간을 사용한다.
정답 – True
(= RET 주소 push 때문에)

## 9. (True/False): ESI and EDI cannot be used when passing 32-bit parameters to procedures.

번역 – 32비트 매개변수를 전달할 때 ESI/EDI는 사용할 수 없다.
정답 – False
(레지스터 전달은 가능. 단, 호출 규약에 따라 push 기반일 뿐.)

## 10. (True/False): The ArraySum procedure receives a pointer to any array of doublewords.

번역 – ArraySum 프로시저는 어떤 DWORD 배열이라도 포인터만 받으면 처리할 수 있다.
정답 – True

## 11. (True/False): The USES operator lets you name all registers modified in a procedure.

번역 – USES는 프로시저에서 수정되는 모든 레지스터 이름을 나열할 수 있다.
정답 – True

## 12. (True/False): The USES operator only generates PUSH instructions, so you must code POP instructions yourself.

번역 – USES는 PUSH만 생성하므로 POP은 직접 작성해야 한다.
정답 – False
(MASM은 PUSH/POP 모두 자동 생성함.)

## 13. (True/False): The register list in USES must use commas.

번역 – USES에서 레지스터 목록은 반드시 쉼표로 구분해야 한다.
정답 – False
(쉼표 없이도 공백으로 나열 가능.)

## 14. Which statement(s) in ArraySum must be modified so it can accumulate 16-bit words?

번역 – ArraySum이 DWORD 대신 WORD 배열 합을 계산하게 하려면 어떤 부분을 수정해야 하는가?
정답 –

배열 접근을 [esi]가 아닌 [esi] + WORD 크기 기반으로 변경

증가량을 add esi,4 → add esi,2 로 변경

DWORD read → WORD read로 변경 (movzx eax, WORD PTR [esi])

## 15. What will be the final value in EAX after the following executes?
push 5
push 6
pop eax
pop eax


번역 – 위 코드 실행 후 EAX의 값은?
정답 –
스택: push 5 → (top=5), push 6 → (top=6)
pop eax → 6
pop eax → 5
최종 값 = 5

## 16. What happens when this code runs?
코드
1: main PROC
2:    push 10
3:    push 20
4:    call Ex2Sub
5:    pop eax
6:    INVOKE ExitProcess,0

Ex2Sub PROC
10: pop eax
11: ret

선택지

a. EAX = 10 on line 6
b. Runtime error line 10
c. EAX = 20 on line 6
d. Runtime error line 11

분석

스택 흐름:
push10 → push20 → call → push return address → stack top = returnAddress,20,10
pop eax inside Ex2Sub → EAX = returnAddress →
ret → returnAddress가 날아갔기 때문에 잘못된 주소로 점프 → 런타임 오류 발생

정답 – d. runtime error on line 11

## 17. What happens when this code runs?
코드
push eax
push 40
call Ex3Sub


Ex3Sub:

pusha
mov eax,80
popa
ret

분석

pusha는 모든 레지스터 push

popa는 역순으로 모든 레지스터 pop

EAX는 popa에 의해 원래 값으로 복구됨
즉 mov eax,80 은 무효가 된다.

따라서 main 종료 시 EAX는 원래 push 전에 mov 했던 30이 된다.

정답 – c. EAX = 30 on line 6

## 18. What happens when this code runs?
push offset Here
jmp Ex4Sub
Here:
   mov eax,30


Ex4Sub:

ret

분석

push offset Here → 스택에 Here 주소 저장
jmp Ex4Sub → ret 실행 → 스택의 Here 주소로 복귀 →
즉 Here로 점프하여 eax=30 실행됨

정답 – c. EAX = 30 on line 6

19. What happens when this code runs?

main:

mov edx,0
mov eax,40
push eax     ; push 40
call Ex5Sub


Ex5Sub:

pop eax
pop edx
push eax
ret

스택 분석

call → push returnAddress
push eax → push 40

Ex5Sub 진입 시 스택 top: returnAddress, 40

pop eax → EAX = returnAddress
pop edx → EDX = 40
push eax → push returnAddress

ret → returnAddress로 정상 복귀

line 6에서의 EDX 값 = 40

정답 – a. EDX = 40 on line 6

20. What values will be written to the array?

배열:

array DWORD 4 DUP(0)


main/프로시저 구조:

각 proc_n 은 실행될 때마다:

add esi,4

add eax,10

mov array[esi],eax

초기 값:
eax = 10
esi = 0

흐름 정리
main:

mov eax,10

esi=0

call proc_1

proc_1:

call proc_2

proc_2:

call proc_3

proc_3:
mov array[esi],eax
ret


첫 번째 기록:
esi=0 → array[0] = eax = 10

proc_2 이어서:

add esi,4   ; esi=4
add eax,10  ; eax=20
mov array[esi],eax → array[1]=20


proc_1 이어서:

add esi,4   ; esi=8
add eax,10  ; eax=30
mov array[esi],eax → array[2]=30


main 이어서:

add esi,4   ; esi=12
add eax,10  ; eax=40
mov array[esi],eax → array[3]=40

최종 배열 값
array[0] = 10
array[1] = 20
array[2] = 30
array[3] = 40


정답 – 10, 20, 30, 40
