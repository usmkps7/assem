def multiply_hex_digit_by_string(digit, hex_str):
        # 단일 16진수 → 정수
    d = int(digit, 16)
    
    # 16진수 문자열 → 정수
    num = int(hex_str, 16)
    
    # 곱셈
    product = d * num
    
    # 정수 → 16진수 문자열, 대문자로, '0x' 제거
    return hex(product)[2:].upper()

digit = "F"
hex_str = "1A3F"
print(multiply_hex_digit_by_string(digit, hex_str))
digit = "A"
hex_str = "F"*10
print(multiply_hex_digit_by_string(digit, hex_str)) 