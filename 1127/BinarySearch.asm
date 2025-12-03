INCLUDE Irvine32.inc

;---------------------------------------------
; PROTOTYPES
;---------------------------------------------
BinarySearch PROTO,
    pArray:PTR DWORD,
    Count:DWORD,
    searchVal:DWORD

BubbleSort PROTO,
    pArray:PTR DWORD,
    Count:DWORD

;---------------------------------------------
; DATA
;---------------------------------------------
.data

; --- 정렬/탐색용 배열 (처음에는 섞여 있음) ---
array     DWORD 31, 7, 70, 3, 42, 25, 12, 56, 18
arraySize DWORD LENGTHOF array

msgOrig     BYTE "Original array:",0
msgSorted   BYTE "Sorted array:",0
msgInput    BYTE "Enter value to search: ",0
msgFound    BYTE "Found at index: ",0
msgNotFound BYTE "Not found",0
msgRowSum   BYTE "Row 1 sum in tableB: ",0

; --- calc_row_sum 테스트용 3x4 byte 테이블 ---
tableB BYTE  1,2,3,4,
             5,6,7,8,
             9,10,11,12

.code
;---------------------------------------------
; main
;---------------------------------------------
main PROC
    ; 원본 배열 출력
    mov edx, OFFSET msgOrig
    call WriteString
    call Crlf

    mov ecx, arraySize
    mov esi, OFFSET array
PrintOrigLoop:
    mov eax, [esi]
    call WriteDec
    call Crlf
    add esi, 4
    loop PrintOrigLoop
    call Crlf

    ; BubbleSort로 배열 정렬
    INVOKE BubbleSort, ADDR array, arraySize

    ; 정렬된 배열 출력
    mov edx, OFFSET msgSorted
    call WriteString
    call Crlf

    mov ecx, arraySize
    mov esi, OFFSET array
PrintSortedLoop:
    mov eax, [esi]
    call WriteDec
    call Crlf
    add esi, 4
    loop PrintSortedLoop
    call Crlf

    ; 검색 값 입력
    mov edx, OFFSET msgInput
    call WriteString
    call ReadInt            ; EAX = 입력 값

    ; BinarySearch(&array, arraySize, EAX)
    INVOKE BinarySearch,
           ADDR array,
           arraySize,
           eax              ; 세 번째 인자로 바로 값 전달

    ; 결과 출력
    cmp eax, -1
    je  NotFoundLabel

FoundLabel:
    mov edx, OFFSET msgFound
    call WriteString
    call WriteDec           ; EAX = index
    call Crlf
    jmp AfterSearch

NotFoundLabel:
    mov edx, OFFSET msgNotFound
    call WriteString
    call Crlf

AfterSearch:
    call Crlf

    ;-----------------------------------------
    ; calc_row_sum 테스트 (tableB의 2번째 행, row index = 1)
    ; EBX = table 주소, EAX = row index, ECX = row size (bytes)
    ;-----------------------------------------
    mov edx, OFFSET msgRowSum
    call WriteString

    mov ebx, OFFSET tableB  ; table start
    mov eax, 1              ; row index 1 (두 번째 행: 5,6,7,8)
    mov ecx, 4              ; row size = 4 bytes
    call calc_row_sum       ; EAX = 합계 5+6+7+8 = 26

    call WriteDec
    call Crlf

    exit
main ENDP

;------------------------------------------------------
; BubbleSort
; Sort an array of 32-bit signed integers in ascending
; order, using the bubble sort algorithm.
; Receives: pointer to array, array size
; Returns: nothing
;------------------------------------------------------
BubbleSort PROC USES eax ecx esi,
    pArray:PTR DWORD,        ; pointer to array
    Count:DWORD              ; array size

    mov ecx, Count
    dec ecx                  ; decrement count by 1

L1:
    push ecx                 ; save outer loop count
    mov  esi, pArray         ; point to first value

L2:
    mov eax, [esi]           ; get array value
    cmp [esi+4], eax         ; compare a pair of values
    jg  L3                   ; if [ESI] <= [ESI+4], no exchange
    xchg eax, [esi+4]        ; exchange the pair
    mov  [esi], eax

L3:
    add esi, 4               ; move both pointers forward
    loop L2                  ; inner loop

    pop ecx                  ; retrieve outer loop count
    loop L1                  ; repeat outer loop if needed

L4:
    ret
BubbleSort ENDP

;----------------------------------------------------
; BinarySearch
; Searches an array of signed integers for a value.
; Receives:
;   pArray    - pointer to DWORD array
;   Count     - array size
;   searchVal - value to search
; Returns:
;   EAX = index if found, -1 if not found
;----------------------------------------------------
BinarySearch PROC USES ebx edx esi edi,
    pArray:PTR DWORD,
    Count:DWORD,
    searchVal:DWORD

    LOCAL first:DWORD,
          last:DWORD,
          mid:DWORD

    mov first, 0
    mov eax, Count
    dec eax
    mov last, eax

    mov edi, searchVal      ; search value
    mov ebx, pArray         ; array base address

L1: ; while (first <= last)
    mov eax, first
    cmp eax, last
    jg  NotFoundSearch

    ; mid = (first + last) / 2
    mov eax, first
    add eax, last
    shr eax, 1
    mov mid, eax

    ; EDX = array[mid]
    mov esi, mid
    shl esi, 2              ; mid * 4 (DWORD)
    mov edx, [ebx + esi]

    ; if (array[mid] < searchVal)
    cmp edx, edi
    jl  MoveRight

    ; else if (array[mid] > searchVal)
    jg  MoveLeft

    ; else found
    mov eax, mid
    ret

MoveRight:
    mov eax, mid
    inc eax
    mov first, eax
    jmp L1

MoveLeft:
    mov eax, mid
    dec eax
    mov last, eax
    jmp L1

NotFoundSearch:
    mov eax, -1
    ret

BinarySearch ENDP

;----------------------------------------------------------
; calc_row_sum
; Calculates the sum of a row in a byte matrix.
; Receives: EBX = table offset, EAX = row index,
;           ECX = row size, in bytes.
; Returns: EAX holds the sum.
;----------------------------------------------------------
calc_row_sum PROC USES ebx ecx edx esi
    mul ecx                      ; row index * row size
    add ebx, eax                 ; row offset
    mov eax, 0                   ; accumulator
    mov esi, 0                   ; column index
L1:
    movzx edx, BYTE PTR [ebx + esi] ; get a byte
    add   eax, edx               ; add to accumulator
    inc   esi                    ; next byte in row
    loop  L1
    ret
calc_row_sum ENDP

END main
