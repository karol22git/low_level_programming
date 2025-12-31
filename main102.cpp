#include <stdio.h>
#include <smmintrin.h>
#include <immintrin.h>
void scaleSSE(float * wynik, float * data, int n){
    __m128 four = _mm_set1_ps(4.0);
    for(int i=0; i<n/4; ++i) {
        //wynik[i] = data[i];
    __m128 v1 = _mm_loadu_ps(data+4*i);
    __m128 v2 = _mm_loadu_ps(data + 4*i+ 1);
    __m128 v3 = _mm_loadu_ps(data + 4*i+ n);
    __m128 v4 = _mm_loadu_ps(data + 4*i+ n + 1);

    __m128 v1v2 = _mm_add_ps(v1,v2);
    __m128 v3v4 = _mm_add_ps(v3,v4);
    __m128 total = _mm_add_ps(v1v2,v3v4);

    __m128 result = _mm_div_ps(total,four);
    __m128 perm = _mm_shuffle_ps(result, result, _MM_SHUFFLE(2,0,2,0));
     //_mm_storeu_pd(wynik +2*i, perm);
     _mm_storel_pi((__m64*)(wynik+2*i), perm);
    }
}

int main(void){

    const int N=400,HL=1078;
    float data[N][N],
    wynik[N][N];
    unsigned char header[HL];
    int i,j;

    FILE *strm;
    strm=fopen("circle3.bmp","rb");
    fread(header, 1, HL, strm);  // wczytuje header
    for(i=0;i<N;i++)             // wczytuje dane bitmapy
        for(j=0;j<N;j++)         // konwertując piksele na float
            data[i][j]=(float)fgetc(strm);
    fclose(strm);

    // właściwe skalowanie bitmapy wiersz po wierszu
    for(i=0;i<N/2;i++)
        scaleSSE(wynik[i],data[2*i],N);
    
    // Modyfikujemy rozmiar bitmapy w nagłówku
    header[4]=0; header[3]=160; header[2]=118; // rozmiar pliku

    header[18]=200;   header[19]=0;  // szerokość bitmapy
    header[22]=200;   header[23]=0;  // wysokość bitmapy

    // Zapisuje wynik do pliku
    strm=fopen("testwynik.bmp","wb");
    fwrite(header, 1, HL, strm);
    for(i=0;i<N/2;i++)
        for(j=0;j<N/2;j++)    // konwertuje wyniki na skalę szarości
            fputc((unsigned char)wynik[i][j],strm);
    fclose(strm);
}
