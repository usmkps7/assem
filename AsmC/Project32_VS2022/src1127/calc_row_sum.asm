calc_row_sum PROC USES ebx ecx edx esi
mul ecx ; row index * row size
add ebx,eax ; row offset
mov eax,0 ; accumulator
mov esi,0 ; column index
L1: movzx edx,BYTE PTR[ebx + esi] ; get a byte
add eax,edx ; add to accumulator
inc esi ; next byte in row
loop L1
ret
calc_row_sum ENDP