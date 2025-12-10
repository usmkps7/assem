#include <stdio.h>
#include <string.h>
#include "EncryptDecrypt.h"


// 어셈블리 함수 선언 (cdecl)
void EncryptBuffer(char* buffer, int len);
void DecryptBuffer(char* buffer, int len);

int main(void)
{
    char text[256];
    int mode;

    while (1) {
        printf("\n==== 암호화 프로그램 ====\n");
        printf("1. 암호화\n");
        printf("2. 복호화\n");
        printf("0. 종료\n");
        printf("선택: ");

        if (scanf("%d", &mode) != 1) {
            break;
        }
        getchar();  // 개행 제거

        if (mode == 0)
            break;

        printf("문자열 입력 : ");
        if (fgets(text, sizeof(text), stdin) == NULL) {
            break;
        }

        // 줄바꿈 제거
        text[strcspn(text, "\n")] = 0;

        int len = (int)strlen(text);

        if (mode == 1) {
            EncryptBuffer(text, len);
            printf("암호문: %s\n", text);
        }
        else if (mode == 2) {
            DecryptBuffer(text, len);
            printf("복호화 결과: %s\n", text);
        }
        else {
            printf("잘못된 선택입니다.\n");
        }
    }

    return 0;
}
