.386
.model flat, stdcall
option casemap : none

includelib kernel32.lib

GetStdHandle   proto : DWORD
WriteConsoleA  proto : DWORD, : ptr BYTE, : DWORD, : ptr DWORD, : DWORD
ExitProcess    proto : DWORD

STD_OUTPUT_HANDLE equ - 11
NUMBUF_SIZE      equ 16

.data
msg1       byte "학번: 202312345", 0Dh, 0Ah, 0
msg2       byte "이름: 홍길동", 0Dh, 0Ah, 0
msgEaxPref byte "EAX: ", 0
crlf       byte 0Dh, 0Ah, 0
hOut       dd ?
bytesWrote dd ?
numBuf     byte NUMBUF_SIZE dup(? )

.code
WriteStr proc uses esi ecx, pStr : ptr BYTE
mov  esi, pStr
xor ecx, ecx
@@len:
mov  al, [esi + ecx]
test al, al
jz   @doneLen
inc  ecx
jmp  @len
@doneLen:
invoke WriteConsoleA, hOut, pStr, ecx, addr bytesWrote, 0
ret
WriteStr endp

DecPrint proc uses ebx ecx edx esi edi ebp, value : SDWORD
mov   eax, value
xor ebp, ebp
cmp   eax, 0
jge   @pos
neg   eax
mov   ebp, 1
@pos:
mov   esi, OFFSET numBuf
mov   ebx, NUMBUF_SIZE
add   esi, ebx
xor ecx, ecx
cmp   eax, 0
jne   @conv
dec   esi
mov   BYTE PTR[esi], '0'
inc   ecx
jmp   @maybeSign
@conv:
@@digit:
xor edx, edx
mov   edi, 10
div   edi
add   dl, '0'
dec   esi
mov[esi], dl
inc   ecx
test  eax, eax
jnz   @digit
@maybeSign:
cmp   ebp, 1
jne   @write
dec   esi
mov   BYTE PTR[esi], '-'
inc   ecx
@write:
invoke WriteConsoleA, hOut, esi, ecx, addr bytesWrote, 0
ret
DecPrint endp

PrintInfo proc
invoke WriteStr, OFFSET msg1
invoke WriteStr, OFFSET msg2
ret
PrintInfo endp

PrintRegister proc
mov    eax, 12345
invoke WriteStr, OFFSET msgEaxPref
invoke DecPrint, eax
invoke WriteStr, OFFSET crlf
ret
PrintRegister endp

public main
main proc
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov    hOut, eax
call   PrintInfo
call   PrintRegister
invoke ExitProcess, 0
main endp

end main
