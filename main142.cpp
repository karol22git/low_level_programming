
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char* dodaj(char * tab1, char * tab2, int n) {
    char* result = (char*) malloc(sizeof(char)*n+1);
    result[n] = 0;
    int rep = n/16;
    int offset = n%16;
    int index = 0;
    for(int i = 0 ; i <offset ; ++i) {
        result[index] = tab1[index] + tab2[index];
        ++index;
    }
    char* p1 = tab1 + index;
    char* p2 = tab2 + index;
    char* pr = result + index;
    asm (
        "dodaj_loop:\n\t"
        "movdqu (%0), %%xmm0\n\t"
        "movdqu (%1), %%xmm1\n\t"
        "paddsb %%xmm1, %%xmm0\n\t"
        "movdqu %%xmm0, (%2)\n\t"
        "add $16, %0\n\t"
        "add $16, %1\n\t"
        "add $16, %2\n\t"
        "loop dodaj_loop\n\t"
        
        :"+r"(p1),"+r"(p2),"+r"(pr)
        :"c"(rep)
        :"xmm0", "xmm1", "memory"


    );
    return result;
}

int main() {
    int n = 40; // 40 bajtów = 8 bajtów (offset) + 2 bloki po 16 bajtów
    char tab1[n], tab2[n];

    // Wypełniamy tablice przykładowymi danymi
    for (int i = 0; i < n; i++) {
        tab1[i] = i;        // 0, 1, 2...
        tab2[i] = 10;       // stała 10
    }

    printf("Testowanie funkcji dodaj dla n = %d...\n", n);
    char* res = dodaj(tab1, tab2, n);

    if (res == NULL) {
        printf("Błąd alokacji pamięci!\n");
        return 1;
    }

    // Sprawdzanie poprawności
    int bledy = 0;
    for (int i = 0; i < n; i++) {
        char oczekiwany = tab1[i] + tab2[i];
        if (res[i] != oczekiwany) {
            printf("Błąd na indeksie %d: jest %d, powinno być %d\n", i, res[i], oczekiwany);
            bledy++;
        }
    }

    if (bledy == 0) {
        printf("Sukces! Wszystkie wartości obliczone poprawnie.\n");
        
        // Wyświetlenie fragmentu wyniku
        printf("Fragment wyniku: ");
        for(int i = 0; i < 10; i++) printf("%d ", res[i]);
        printf("...\n");
    } else {
        printf("Znaleziono %d błędów.\n", bledy);
    }

    free(res);
    return 0;
}
