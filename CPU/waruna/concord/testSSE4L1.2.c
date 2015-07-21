/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include <string.h>
#include "timer.h"

#ifdef OMP
#include <omp.h>
#endif

//#define IREPS 10000
#define REPS 160000000
//sun 20
#define ARRAY_SIZE 128

int oneThread(int threadId);

int main (int argv, char** argc) 
{
	int tds = 1;

	if (argv > 1) {
		tds = atoi(argc[1]);
	}
	int i = 0;

	int *sum = (int *)malloc(tds*sizeof(int));
	
	initialize_timer();
	start_timer();

	#pragma omp parallel num_threads(tds)
	{
		int tid = 0;
#ifdef OMP
		tid = omp_get_thread_num();
#endif
		int rr = oneThread(tid);
		sum[tid] = rr;
	}
	
	stop_timer();
	double vector_time = elapsed_time();
	double gops = (double)((double)((double)((double)4*(double)4)*(double)REPS*((((double)ARRAY_SIZE)/(double)32)-1.0f)*(double)tds)/vector_time)/((double)1e9);
	fprintf(stdout, "Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f\n", tds, ARRAY_SIZE, vector_time, gops);
	
	int out = 0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("sum: %d\n", out);

	return 0;
} 

int oneThread(int threadId)
{
	int cc[ARRAY_SIZE];
	int i;
	int j;
	int k;
	int itr;

#pragma omp declare reduction( + : __m128i : \
         omp_out=t_add__m128i(omp_in,omp_out)) \
                       initializer (omp_priv=_mm_set_epi32(0,0,0,0))


	memset(&cc[0], 0, ARRAY_SIZE*4);

  __m128i a,b0,b1,b2,b3;
	__m128i c0,c1,c2,c3;

	c0 = _mm_set_epi32(0,0,0,0);
	c1 = _mm_set_epi32(0,0,0,1);
	c2 = _mm_set_epi32(0,0,1,0);
	c3 = _mm_set_epi32(0,1,0,0);
	a = _mm_set_epi32(1,2,2,1);
	c0 = _mm_load_si128((__m128i*)&cc[ARRAY_SIZE-16]);
	c1 = _mm_load_si128((__m128i*)&cc[ARRAY_SIZE-12]);	
	c2 = _mm_load_si128((__m128i*)&cc[ARRAY_SIZE-8]);	
	c3 = _mm_load_si128((__m128i*)&cc[ARRAY_SIZE-4]);	

	for (k = 0; k < REPS; k++) 
	{
		for (itr = ARRAY_SIZE; itr>32; itr-=32)
		{

			b0 = _mm_load_si128((__m128i*)&cc[itr-32]);
			b1 = _mm_load_si128((__m128i*)&cc[itr-28]);	
			b2 = _mm_load_si128((__m128i*)&cc[itr-24]);	
			b3 = _mm_load_si128((__m128i*)&cc[itr-20]);	

			c0 = _mm_max_epi32(_mm_add_epi32(c0,a), b0);
			c1 = _mm_max_epi32(_mm_add_epi32(c1,a), b1);
			c2 = _mm_max_epi32(_mm_add_epi32(c2,a), b2);
			c3 = _mm_max_epi32(_mm_add_epi32(c3,a), b3);

			_mm_store_si128((__m128i*)&cc[itr-16], c0);
			_mm_store_si128((__m128i*)&cc[itr-12], c1);	
			_mm_store_si128((__m128i*)&cc[itr-8], c2);	
			_mm_store_si128((__m128i*)&cc[itr-4], c3);	


			c0 = _mm_load_si128((__m128i*)&cc[itr-48]);
			c1 = _mm_load_si128((__m128i*)&cc[itr-44]);	
			c2 = _mm_load_si128((__m128i*)&cc[itr-40]);	
			c3 = _mm_load_si128((__m128i*)&cc[itr-36]);	
		
			b0 = _mm_max_epi32(_mm_add_epi32(b0,a), c0);
			b1 = _mm_max_epi32(_mm_add_epi32(b1,a), c1);
			b2 = _mm_max_epi32(_mm_add_epi32(b2,a), c2);
			b3 = _mm_max_epi32(_mm_add_epi32(b3,a), c3);

			_mm_store_si128((__m128i*)&cc[itr-32], b0);
			_mm_store_si128((__m128i*)&cc[itr-28], b1);	
			_mm_store_si128((__m128i*)&cc[itr-24], b2);	
			_mm_store_si128((__m128i*)&cc[itr-20], b3);	
		}	
		a = _mm_min_epi32(a,b0);
	}

	int count =0;
	for (i=0; i< ARRAY_SIZE; i++)
	{
		count += cc[i];	
	}

	return count;
}


