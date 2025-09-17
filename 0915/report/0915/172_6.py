def add_hex_strings(hex1, hex2):
    # 16진수 문자열 → 정수
    int1 = int(hex1, 16)
    int2 = int(hex2, 16)
    
    # 합 계산
    total = int1 + int2
    
    # 정수 → 16진수 문자열, 대문자로 변환, '0x' 제거
    return hex(total)[2:].upper()

h1 = "1A3F"
h2 = "2B7"
print(add_hex_strings(h1, h2))

h1 = "F"*10
h2 = "1"
print(add_hex_strings(h1, h2))  