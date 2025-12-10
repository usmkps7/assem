# 2.8 Review Questions

## 1. In 32-bit mode, aside from the stack pointer (ESP), what other register points to variables on the stack?

번역 – 32비트 모드에서 ESP 외에 스택의 변수들을 가리키는 레지스터는 무엇인가?
정답 – EBP (Base Pointer)

## 2. Name at least four CPU status flags.

번역 – CPU 상태 플래그 최소 네 가지를 쓰시오.
정답 – CF, ZF, SF, OF 등

## 3. Which flag is set when the result of an unsigned arithmetic operation is too large to fit into the destination?

번역 – 부호 없는 연산 결과가 목적지에 들어가기에는 너무 클 때 설정되는 플래그는 무엇인가?
정답 – CF (Carry Flag)

## 4. Which flag is set when the result of a signed arithmetic operation is either too large or too small to fit into the destination?

번역 – 부호 있는 산술 연산에서 결과가 너무 크거나 작아 목적지 크기를 벗어날 때 설정되는 플래그는 무엇인가?
정답 – OF (Overflow Flag)

## 5. (True/False): If the operand size is 32 bits and the REX prefix is used, the R8D register is available for programs to use.

번역 – (참/거짓): 오퍼랜드 크기가 32비트이고 REX 프리픽스를 사용하면 R8D 레지스터를 사용할 수 있다.
정답 – True

## 6. Which flag is set when an arithmetic or logical operation generates a negative result?

번역 – 산술 또는 논리 연산 결과가 음수일 때 설정되는 플래그는 무엇인가?
정답 – SF (Sign Flag)

## 7. Which part of the CPU performs floating-point arithmetic?

번역 – CPU의 어떤 부분이 부동소수점 연산을 수행하는가?
정답 – FPU(x87), 또는 SSE/AVX 유닛

## 8. On a 32-bit processor, how many bits are contained in each floating-point data register?

번역 – 32비트 프로세서에서 부동소수점 데이터 레지스터 하나는 몇 비트인가?
정답 – 80비트 (x87 확장 정밀도)

## 9. (True/False): The x86-64 instruction set is backward-compatible with the x86 instruction set.

번역 – (참/거짓): x86-64 명령어는 x86 명령어와 하위 호환된다.
정답 – True

## 10. (True/False): In current 64-bit chip implementations, all 64 bits are used for addressing.

번역 – (참/거짓): 현재의 64비트 칩들은 주소 지정에 64비트를 모두 사용한다.
정답 – False (약 48비트만 사용)

## 11. (True/False): The Itanium instruction set is completely different from the x86 instruction set.

번역 – (참/거짓): 아이태니움 명령어는 x86 명령어와 완전히 다르다.
정답 – True

## 12. (True/False): Static RAM is usually less expensive than dynamic RAM.

번역 – (참/거짓): 정적 RAM(SRAM)은 동적 RAM(DRAM)보다 일반적으로 더 저렴하다.
정답 – False (SRAM이 더 비쌈)

## 13. (True/False): The 64-bit RDI register is available when the REX prefix is used.

번역 – (참/거짓): 64비트 RDI 레지스터는 REX 프리픽스를 사용해야만 사용할 수 있다.
정답 – False (REX 없어도 기본 사용 가능)

## 14. (True/False): In native 64-bit mode, you can use 16-bit real mode, but not the virtual-8086 mode.

번역 – (참/거짓): 네이티브 64비트 모드에서는 16비트 Real Mode는 가능하지만 Virtual-8086 모드는 사용할 수 없다.
정답 – True

## 15. (True/False): The x86-64 processors have 4 more general-purpose registers than the x86 processors.

번역 – (참/거짓): x86-64 프로세서는 x86보다 범용 레지스터가 4개 더 많다.
정답 – False (8개 더 많음: R8~R15)

## 16. (True/False): The 64-bit version of Microsoft Windows does not support virtual-8086 mode.

번역 – (참/거짓): 64비트 Windows는 virtual-8086 모드를 지원하지 않는다.
정답 – True

## 17. (True/False): EPROM can only be erased using ultraviolet light.

번역 – (참/거짓): EPROM은 자외선으로만 지울 수 있다.
정답 – True

## 18. (True/False): In 64-bit mode, you can use up to eight floating-point registers.

번역 – (참/거짓): 64비트 모드에서는 최대 8개의 부동소수점 레지스터를 사용할 수 있다.
정답 – False (XMM 16개 사용 가능)

## 19. A bus is a plastic cable that is attached to the motherboard at both ends, but does not sit directly on the motherboard.

번역 – 버스(bus)는 양 끝이 마더보드에 연결되어 있지만, 마더보드 위에 직접 놓이지 않는 플라스틱 케이블이다.
정답 – False (버스는 마더보드 내부 전기적 경로)

## 20. (True/False): CMOS RAM is the same as static RAM, meaning that it holds its value without any extra power or refresh cycles.

번역 – (참/거짓): CMOS RAM은 SRAM과 같으며 추가 전력 없이도 값을 유지한다.
정답 – False (CMOS는 배터리 필요)

## 21. PCI connectors are used for graphics cards and sound cards.

번역 – PCI 커넥터는 그래픽 카드와 사운드 카드에 사용된다.
정답 – True

## 22. The 8259A is a controller that handles external interrupts from hardware devices.

번역 – 8259A는 하드웨어 장치의 외부 인터럽트를 처리하는 컨트롤러이다.
정답 – True

## 23. The acronym PCI stands for programmable component interface.

번역 – PCI는 programmable component interface의 약자이다.
정답 – False (Peripheral Component Interconnect)

## 24. VRAM stands for virtual random access memory.

번역 – VRAM은 virtual random access memory의 약자이다.
정답 – False (Video RAM)

## 25. At which level(s) can an assembly language program manipulate input/output?

번역 – 어셈블리 언어 프로그램은 어느 수준(level)에서 I/O를 조작할 수 있는가?
정답 – BIOS, OS system call, 하드웨어 포트 등 여러 계층

## 26. Why do game programs often send their sound output directly to the sound card's hardware ports?

번역 – 왜 게임 프로그램이 사운드 출력을 사운드 카드 하드웨어 포트로 직접 보내지 않는가?
정답 – 현대 OS 보호 모드 때문에 응용 프로그램은 하드웨어 포트 직접 접근이 불가. 드라이버/API를 통해야 함.
