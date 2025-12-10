; DllMain.asm  (AsmCryptoDll 프로젝트에 추가)

.386
.model flat, stdcall
option casemap:none

; (필요하면 Irvine / Windows include 추가)
INCLUDE Irvine32.inc

PUBLIC DllMain         ; 엔트리로 쓸 이름을 공개

.code

; BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
DllMain PROC hInst:DWORD, reason:DWORD, reserved:DWORD

    ; 여기서는 아무것도 안 하고 그냥 TRUE 반환
    mov eax, 1         ; TRUE
    ret 12             ; stdcall: 3개 인자(4*3 = 12바이트) 정리

DllMain ENDP

END            ; 이 파일 자체는 엔트리 지정 안 함 (링커에서 지정할 거라서)
