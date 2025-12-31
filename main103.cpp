#include <iostream>
#include <cmath>
#include <smmintrin.h>
#include <immintrin.h>
using namespace std;
// width powinien dzielic sie przez 4
const int width = 300, height = 168;

void filtr(int imageWidth, int imageHeight, float image[height][width], 
           float weight[3][3], float result[height][width]){

  // TODO !!!
  float weight_sum = 0.0;
  __m128 v_weights[3][3];
  for(unsigned int i = 0 ; i < 3 ; ++i) {
    for(unsigned int j = 0 ; j < 3; ++j) {
        weight_sum +=weight[i][j];
        v_weights[i][j] = _mm_set1_ps(weight[i][j]);
    }
  }

  if(weight_sum == 0.0) weight_sum = 1.0;
  __m128 v_weights_sum = _mm_set1_ps(weight_sum);

  __m128 pixels[3][3];
  __m128 pixels_multiplied[3][3];
  for(unsigned int y = 1; y < imageHeight -1 ; ++y) {
    for(unsigned int x = 1 ; x < imageWidth - 1; x +=4  ) {
        //__m128 p1 = _mm_loadu_ps(&image[y-1][x-1]);
        //__m128 p2 = _mm_loadu_ps(&image[y-1][x]);
        //__m128 p3 = _mm_loadu_ps(&image[y-1][x+1]);y
        //__m128 p4 = _mm_loadu_ps(&image[y][x-1]);
        //__m128 p5 = _mm_loadu_ps(&image[y][x]);
        //__m128 p6 = _mm_loadu_ps(&image[y][x+1]);y
        //__m128 p7 = _mm_loadu_ps(&image[y+1][x-1]);
        //__m128 p8 = _mm_loadu_ps(&image[y+1][x]);
        //__m128 p9 = _mm_loadu_ps(&image[y+1][x+1]);
        for( int i = -1 ; i < 2 ; ++i) {
            for( int j = -1 ; j< 2; ++j) {
                pixels[i+1][j+1] = _mm_loadu_ps(&image[y+i][x+j]);
            }
        }
        for(unsigned int i = 0 ; i < 3 ; ++i) {
            for(unsigned int j = 0 ; j< 3; ++j) {
                pixels_multiplied[i][j] = _mm_mul_ps(pixels[i][j],v_weights[i][j]);
            }
        }
        __m128 acc = _mm_setzero_ps();
        for(unsigned int i = 0 ; i < 3 ; ++i) {
            for(unsigned int j = 0 ; j< 3; ++j) {
               acc = _mm_add_ps(pixels_multiplied[i][j],acc);
            }
        }
        __m128 r = _mm_div_ps(acc,v_weights_sum);
        //psum =  _mm_add_ps(psum,p3);
        //psum =  _mm_add_ps(psum,p4);
        //psum =  _mm_add_ps(psum,p5);
        //psum =  _mm_add_ps(psum,p6);
        //psum =  _mm_add_ps(psum,p7);
        //psum =  _mm_add_ps(psum,p8);
        //psum =  _mm_add_ps(psum,p9);

        _mm_storeu_ps(&result[y][x], r);
              if(x + 4 >= imageWidth - 1) {
                for(int rx = x; rx < imageWidth - 1; ++rx) {
                    float sum = 0.0f;
                    for(int ky = -1; ky <= 1; ++ky) {
                        for(int kx = -1; kx <= 1; ++kx) {
                            sum += image[y + ky][rx + kx] * weight[ky + 1][kx + 1];
                        }
                    }
                    result[y][rx] = sum / weight_sum;
                }
                break;
        }
    }
    
  }
}

int main(void)
{
    const int headerLength = 122; // 64; //sizeof(BMPHEAD);
    char header[headerLength];
    float data[3][height][width];    // tablica dla każdej składowej koloru
    float result[3][height][width];

    float weight[3][3]= { {0, -2, 0}, { -2, 11, -2}, {0, -2, 0} };
    
    int i,j,k;
    FILE *file;
    file=fopen("pigeon.bmp","rb");
    if(!file) { std::cerr << " Error opening file !"; exit(1); }
    fread(header, headerLength, 1, file);
    for(i=0;i<height;i++)
        for(j=0;j<width;j++)
           for(k=0; k<3; ++k)   
            data[k][i][j]=fgetc(file);
    fclose(file);
    
    for(i=0;i<3;i++)   // filtrujemy dla każdej składowej osobno
        filtr(width, height, data[i], weight, result[i]);

    file=fopen("result.bmp","wb");
    fwrite(header, headerLength, 1, file);
    for(i=0;i<height;i++)
      for(j=0;j<width;j++)
        for(k=0; k<3; ++k)
          fputc((unsigned char)result[k][i][j],file);
    fclose(file);
}
