/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include <string.h>
#include "timer.h"
#include "my_papi.h"


#ifdef OMP
#include <omp.h>
#endif

//#define IREPS 10000
#define REPS 500000000
//sun 20
#define ARRAY_SIZE 64

int oneThread(int threadId);
void *mykernel(void *nothing);

int *sum;
int tds;

int main (int argv, char** argc) 
{
	tds = 1;

	if (argv > 1) {
		tds = atoi(argc[1]);
	}
	int i = 0;

	sum = (int *)malloc(tds*sizeof(int));
	
	initialize_timer();
	start_timer();

	mykernel(NULL);

	stop_timer();
	double vector_time = elapsed_time();

	reset_timer();
	start_timer();

	mykernel(NULL);

	stop_timer();
	double vector_time_01 = elapsed_time();

	double gops = (double)((double)((double)((double)4*(double)4)*(double)REPS*((((double)ARRAY_SIZE)/(double)32)-1.0f)*(double)tds)/vector_time)/((double)1e9);
	double gops01 = (double)((double)((double)((double)4*(double)4)*(double)REPS*((((double)ARRAY_SIZE)/(double)32)-1.0f)*(double)tds)/vector_time_01)/((double)1e9);
	fprintf(stdout, "Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f REPS: %d\n", tds, ARRAY_SIZE, vector_time, gops, vector_time_01, gops01, REPS);

	my_papi_profile(mykernel);

/*#pragma omp parallel num_threads(tds)
	{
		int tid = 0;
#ifdef OMP
		tid = omp_get_thread_num();
#endif
		int rr = oneThread(tid);
		sum[tid] = rr;
	}
*/
	
	int out = 0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("sum: %d\n", out);

	return 0;
} 

void *mykernel(void *nothing)
{
#pragma omp parallel num_threads(tds)
	{
		int tid = 0;
#ifdef OMP
		tid = omp_get_thread_num();
#endif
		int rr = oneThread(tid);
		sum[tid] = rr;
	}
	return NULL;
}

int oneThread(int threadId)
{
	int cc[ARRAY_SIZE];
	int i;
	int k;
	int itr;


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


