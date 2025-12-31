#include <cstdlib>
#include <cstdio>
#include <ctime>
#include <smmintrin.h>
#include <immintrin.h>

using namespace std;
int main(){
	const int prog = 100000;
	const int rozmiar = 100;
	unsigned int tab[rozmiar];

	srand(2021);  // dla powtarzalności testów

	for(int i=0; i<rozmiar; ++i){
	    tab[i] = rand() % prog;
	}


	__m128i maxi = _mm_loadu_si128((const __m128i_u*)tab);

	for(unsigned int i = 0 ; i < rozmiar; i+=4) {
		__m128i next =  _mm_loadu_si128((const __m128i_u*)(tab+i));
		maxi = _mm_max_epu32(maxi,next);
	}

	unsigned int tmp[4];
	_mm_storeu_si128((__m128i*)tmp, maxi);

	unsigned int m = tmp[0];
	if(tmp[1] > m) m = tmp[1];
	if(tmp[2] > m) m = tmp[2];
	if(tmp[3] > m) m = tmp[3];

	printf("%d\n", m);
}
