def hex32_to_int(u):  # (u) 사용자는 함수 이름 바꿔도 됨
    return int(u, 16)

s = "1A2B3C4D"
value = hex32_to_int(s)
print(value) 