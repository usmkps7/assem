def add_base_b(num1, num2, b):  # (u) 사용자는 함수 이름 바꿔도 됨
    # 문자열 → 정수
    int1 = int(num1, b)
    int2 = int(num2, b)
    
    # 합 계산
    total = int1 + int2
    
    # 정수 → 진수 문자열
    if b == 2:
        return bin(total)[2:]
    elif b == 8:
        return oct(total)[2:]
    elif b == 16:
        return hex(total)[2:].upper()
    else:
        digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        res = ""
        if total == 0:
            return "0"
        while total > 0:
            res = digits[total % b] + res
            total //= b
        return res

num1 = "1101"      
num2 = "1011"
b = 2
print(add_base_b(num1, num2, b))  

num1 = "1A3"       
num2 = "2F"
b = 16
print(add_base_b(num1, num2, b))  