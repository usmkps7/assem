# 1. Structures (구조체)

구조체(structure)는 논리적으로 관련된 여러 필드를 하나의 템플릿으로 묶는 자료 구조이다.
필드는 서로 다른 자료형을 포함할 수 있으며, 구조체 이름을 통해 하나의 단위처럼 다룰 수 있다.

## 1-1. 구조체 정의
기본 문법
name STRUCT
    field-declarations
name ENDS

필드 초기화 방식
종류	설명
?	초기화 안 함 (undefined)
문자열	"ABC"처럼 문자 배열 초기화
정수	100, 10 DUP(0) 등 상수/표현식
배열	DUP 사용하여 반복 초기화 가능
예시
Employee STRUCT
    IdNum        BYTE "00000000"
    LastName     BYTE 30 DUP(0)
    ALIGN WORD      ; 정렬 패딩
    Years        WORD 0
    ALIGN DWORD
    SalaryHistory DWORD 0,0,0,0
Employee ENDS

## 1-2. 구조체 정렬(Alignment)

CPU는 자료형 크기 단위로 정렬된 메모리 접근 시 가장 효율적이다.

자료형	정렬 기준
BYTE	1바이트 경계
WORD	2바이트 경계
DWORD	4바이트 경계
QWORD	8바이트 경계

ALIGN 지시어로 강제 정렬 가능.

## 1-3. 구조체 변수 선언
문법
identifier structureType < initializer-list >

특징

< > 안을 비우면 구조체 정의의 기본 초기값 사용

일부 필드만 선택적으로 초기화 가능

예시
point1 COORD <5,10>
point2 COORD <20>      ; X=20, Y는 기본값
point3 COORD <>        ; 기본 초기자 사용
worker Employee <>     

1-4. 구조체 크기 및 참조
연산자	기능
TYPE structureName	구조체 1개 크기
SIZEOF structureName	구조체 전체 크기
OFFSET var.field	필드 주소

예:

TYPE Employee    ; 60
SIZEOF Employee  ; 60
SIZEOF worker    ; 60

## 1-5. 구조체 멤버 접근
직접 접근
mov emp.Years, 5
mov emp.SalaryHistory, 35000

간접 접근 (ESI 등)
mov esi, OFFSET emp
mov (Employee PTR [esi]).Years, 5

## 1-6. 구조체 배열 및 반복 처리
배열 선언
AllPoints COORD NumPoints DUP(<0,0>)

반복문을 통한 처리
mov edi,0
mov ecx,NumPoints
mov ax,1
L1:
    mov (COORD PTR AllPoints[edi]).X, ax
    mov (COORD PTR AllPoints[edi]).Y, ax
    add edi, TYPE COORD
    inc ax
loop L1

## 1-7. 구조체 안에 구조체 포함 (Nested Structure)
Rectangle STRUCT
    UpperLeft  COORD <>
    LowerRight COORD <>
Rectangle ENDS


접근:

mov rect1.UpperLeft.X, 10
mov rect2.LowerRight.Y, 50

# 2. Unions (공용체)

Union은 여러 필드가 같은 메모리 영역을 공유하는 자료 구조이다.
가장 큰 필드 크기만큼 공간을 사용한다.

특징

모든 필드는 offset 0에서 시작

초기자는 단 하나만 허용

실제 사용할 때는 필드 이름을 반드시 지정

# 3. Macros (매크로)

매크로는 어셈블리 코드 조각을 이름으로 정의한 것이며,
호출 시 코드가 그대로 삽입되는 inline expansion이 발생한다.

3-1. 매크로 정의 문법
macroName MACRO param1, param2
    instructions
ENDM

특성

파라미터는 텍스트 치환 방식

코드·데이터 모두 포함 가능

호출하면 전개된 코드가 LST 파일에서 확인됨

## 3-2. LOCAL 레이블

매크로 내부에서 중복 레이블 문제를 방지하기 위해 LOCAL 사용.

makeString MACRO text
    LOCAL string
    .data
        string BYTE text,0
    .code
        mov edx, OFFSET string
        call WriteString
ENDM

## 3-3. 중첩 매크로 (Nested Macro)

매크로 안에서 다른 매크로 호출 가능.
상위 매크로 인자가 그대로 전달됨.

## 3-4. 조건부 어셈블러 지시어(IFB, IFIDN 등)

PDF에서 다루는 주요 조건부 지시어:

Directive	설명
IF, ELSE, ENDIF	조건 평가 후 코드 포함/제외
IFB arg	인자가 비었을 때 true
IFIDN <a>,<b>	텍스트 동일 비교(대소문자 구분 X)
EXITM	매크로 전개 종료
ECHO	어셈블 시 진단 메시지 출력

예: 인자 누락 검사

mWriteString MACRO text
    IFB <text>
        ECHO Error: missing parameter
        EXITM
    ENDIF
    ...
ENDM

## 3-5. Special Operators
연산자	역할
&	파라미터 이름 명확화(Substitution)
%	상수/텍스트 매크로 전개
<>	literal-text (구분자 무시)
!	literal-character (연산자 무효화)

# 4. Repeat Blocks (WHILE, REPEAT, FOR, FORC)

MASM은 Assembly-time 반복을 제공함.

지시어 | 기능

---|---
WHILE | 조건이 참일 동안 반복
REPEAT | 지정된 횟수만큼 반복
FOR | 기호 리스트 반복
FORC | 문자열의 각 문자에 대해 반복

예:

FOR item, <10,20,30>
    DWORD item
ENDM
