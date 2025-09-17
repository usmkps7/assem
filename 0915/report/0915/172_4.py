def int_to_hex(u):
    return hex(u)[2:].upper()

value = 439041101
hex_str = int_to_hex(value)
print(hex_str)