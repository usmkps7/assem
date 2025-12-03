# 9.9.1 Short Answer

## 1. Which Direction flag setting causes index registers to move backward through memory when executing string primitives?

번역
문자열 기본 명령어를 실행할 때, 인덱스 레지스터가 메모리에서 뒤쪽 방향으로 이동하게 만드는 Direction Flag 설정은 무엇인가?

정답

DF = 1 (STD 명령어로 설정됨)
→ ESI, EDI가 감소하면서 backward 방향으로 이동한다.

## 2. When a repeat prefix is used with STOSW, what value is added to or subtracted from the index register?

번역
STOSW에 repeat prefix를 사용할 때, 인덱스 레지스터에 더해지거나 빼지는 값은 무엇인가?

정답

2 바이트
→ WORD 크기이므로 EDI가 ±2씩 이동한다.

## 3. In what way is the CMPS instruction ambiguous?

번역
CMPS 명령어는 어떤 점에서 모호한가?

정답

어떤 피연산자가 기준(left/right)인지 명확하지 않다

즉, 두 메모리를 비교하지만 어느 쪽이 source인지 결과만으로는 직관적이지 않다

결과 해석은 플래그(CF, ZF 등) 에 의존한다

## 4. When the Direction flag is clear and SCASB has found a matching character, where does EDI point?

번역
Direction Flag가 클리어된 상태에서 SCASB가 일치하는 문자를 찾았을 때, EDI는 어디를 가리키는가?

정답

일치한 문자의 바로 다음 위치

이유: 비교 후 EDI가 자동 증가하기 때문

## 5. When scanning an array for the first occurrence of a particular character, which repeat prefix would be best?

번역
배열에서 특정 문자의 첫 번째 등장 위치를 찾을 때 가장 적절한 repeat prefix는 무엇인가?

정답

REPNE (또는 REPNZ)
→ 같지 않은 동안 반복하다가 처음으로 같은 값(ZF=1)을 만나면 중단

## 6. What Direction flag setting is used in the Str_trim procedure from Section 9.3?

번역
9.3절의 Str_trim 프로시저에서는 Direction Flag를 어떻게 설정하는가?

정답

DF = 0 (CLD)
→ 문자열을 forward 방향으로 처리한 후, 논리적으로 끝 위치를 계산

## 7. Why does the Str_trim procedure from Section 9.3 use the JNE instruction?

번역
9.3절의 Str_trim 프로시저가 JNE 명령어를 사용하는 이유는 무엇인가?

정답

현재 문자가 지정된 구분자(delimiter)가 아닐 때 반복을 계속하기 위해

즉, delimiter가 아닌 문자를 만날 때까지 뒤로 이동하기 위함

## 8. What happens in the Str_ucase procedure from Section 9.3 if the target string contains a digit?

번역
9.3절의 Str_ucase 프로시저에서 문자열에 숫자가 포함되어 있다면 어떻게 되는가?

정답

아무 변화도 없다

숫자는 ASCII 범위 검사('a' ~ 'z')에서 제외되므로 변환되지 않는다

## 9. If the Str_length procedure from Section 9.3 used SCASB, which repeat prefix would be most appropriate?

번역
9.3절의 Str_length 프로시저가 SCASB를 사용한다면, 가장 적절한 repeat prefix는 무엇인가?

정답

REPNE

이유:

널 문자(0)가 나올 때까지 반복 비교해야 함

널 문자는 비교 조건에서 “일치”이므로, 같지 않은 동안 반복

## 10. If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and return the string length?

번역
9.3절의 Str_length가 SCASB를 사용한다면 문자열 길이를 어떻게 계산하고 반환하는가?

정답

ECX를 최대 길이로 초기화

REPNE SCASB 실행

실행 후:

(초기 ECX − 현재 ECX − 1) = 문자열 길이

결과를 EAX에 저장하여 반환

## 11. What is the maximum number of comparisons needed by the binary search algorithm when an array contains 1,024 elements?

번역
원소가 1,024개인 배열에서 이진 탐색이 필요로 하는 최대 비교 횟수는 얼마인가?

정답

10회

이유:

1024
=
2
10
1024=2
10

최대 비교 횟수 = log₂(1024)

## 12. In the FillArray procedure from the Binary Search example in Section 9.5, why must the Direction flag be cleared by the CLD instruction?

번역
9.5절 이진 탐색 예제의 FillArray 프로시저에서 왜 CLD로 Direction Flag를 클리어해야 하는가?

정답

문자열/배열을 앞에서 뒤로 순차적으로 저장해야 하기 때문

DF가 설정되어 있으면 주소가 감소하여 잘못된 메모리에 저장된다

## 13. In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be removed without affecting the outcome?

번역
9.5절의 BinarySearch 프로시저에서 L2 레이블의 문장은 왜 제거해도 결과에 영향을 주지 않는가?

정답

이미 이전 비교 결과 플래그를 그대로 사용하기 때문

중복 비교이므로 논리적으로 불필요하다

## 14. In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be eliminated?

번역
9.5절의 BinarySearch 프로시저에서 L4 레이블의 문장은 어떻게 제거할 수 있는가?

정답

분기 구조를 재배치하여
불필요한 jmp 없이 바로 루프 시작으로 제어 이동

즉, 조건 분기 흐름을 단순화하면 L4가 필요 없어짐
