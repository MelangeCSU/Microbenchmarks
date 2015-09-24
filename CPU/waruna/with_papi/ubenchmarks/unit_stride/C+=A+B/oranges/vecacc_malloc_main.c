/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include <string.h>



#define ARRAY_SIZE 992


int *sum;
int tds;
int reps; 

int main (int argv, char** argc) 
{
	reps = 1;
	
	if (argv > 1) {
		reps = atoi(argc[1]);
	}
	
	sum = (int *)malloc(tds*sizeof(int));

	int *aa;
	int *bb;
	int *cc;
	int i;
	int k;
	int itr;

	aa = (int *)_mm_malloc(sizeof(int)*ARRAY_SIZE, 16);
	bb = (int *)_mm_malloc(sizeof(int)*ARRAY_SIZE, 16);
	cc = (int *)_mm_malloc(sizeof(int)*ARRAY_SIZE, 16);

	memset(&aa[0], 1, ARRAY_SIZE*4);
	memset(&bb[0], 2, ARRAY_SIZE*4);
	memset(&cc[0], 0, ARRAY_SIZE*4);

  __m128i a0,a1,a2,a3,b0,b1,b2,b3;
  __m128i a4,a5,a6,a7,b4,b5,b6,b7;
	__m128i c0,c1,c2,c3;
	__m128i c4,c5,c6,c7;

	for (k = 0; k < reps; k++) 
	{
		for (itr = 0; itr<ARRAY_SIZE; itr+=32)
		{
			a0 = _mm_load_si128((__m128i*)&aa[itr]);
			a1 = _mm_load_si128((__m128i*)&aa[itr+4]);	
			a2 = _mm_load_si128((__m128i*)&aa[itr+8]);	
			a3 = _mm_load_si128((__m128i*)&aa[itr+12]);	
			a4 = _mm_load_si128((__m128i*)&aa[itr+16]);
			a5 = _mm_load_si128((__m128i*)&aa[itr+20]);	
			a6 = _mm_load_si128((__m128i*)&aa[itr+24]);	
			a7 = _mm_load_si128((__m128i*)&aa[itr+28]);	
			b0 = _mm_load_si128((__m128i*)&bb[itr]);
			b1 = _mm_load_si128((__m128i*)&bb[itr+4]);	
			b2 = _mm_load_si128((__m128i*)&bb[itr+8]);	
			b3 = _mm_load_si128((__m128i*)&bb[itr+12]);	
			b4 = _mm_load_si128((__m128i*)&bb[itr+16]);
			b5 = _mm_load_si128((__m128i*)&bb[itr+20]);	
			b6 = _mm_load_si128((__m128i*)&bb[itr+24]);	
			b7 = _mm_load_si128((__m128i*)&bb[itr+28]);	

			c0 = _mm_add_epi32(a0, b0);
			c1 = _mm_add_epi32(a1, b1);
			c2 = _mm_add_epi32(a2, b2);
			c3 = _mm_add_epi32(a3, b3);
			c4 = _mm_add_epi32(a4, b4);
			c5 = _mm_add_epi32(a5, b5);
			c6 = _mm_add_epi32(a6, b6);
			c7 = _mm_add_epi32(a7, b7);

			_mm_store_si128((__m128i*)&cc[itr], c0);
			_mm_store_si128((__m128i*)&cc[itr+4], c1);	
			_mm_store_si128((__m128i*)&cc[itr+8], c2);	
			_mm_store_si128((__m128i*)&cc[itr+12], c3);	
			_mm_store_si128((__m128i*)&cc[itr+16], c4);
			_mm_store_si128((__m128i*)&cc[itr+20], c5);	
			_mm_store_si128((__m128i*)&cc[itr+24], c6);	
			_mm_store_si128((__m128i*)&cc[itr+28], c7);	
		}	
	}

	//To avoid optimizing away computations
	int count =0;
	for (i=0; i< ARRAY_SIZE; i=i+4)
	{
		count += cc[i];	
	}

	free(aa);
	free(bb);
	free(cc);


	printf("sum: %d\n", count);

	return 0;
} 


