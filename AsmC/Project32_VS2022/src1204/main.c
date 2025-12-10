#include <stdio.h>

// 어셈블리 함수 선언
extern int mul11(int n);

int main() {
    int n;
    printf("정수 n 입력: ");
    scanf("%d", &n);

    int result = mul11(n);
    printf("결과: %d\n", result);

    return 0;
}
