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
#define REPS 7255771
//sun 20
#define ARRAY_SIZE 4480

int oneThread(int threadId);
void *mykernel(void *nothing);

int *sum;
int tds;
//int reps; 

int main (int argv, char** argc) 
{
	tds = 1;
//	reps = REPS;
	
	if (argv > 1) {
		tds = atoi(argc[1]);
	}
/*	if (argv > 2) {
		reps = atoi(argc[2]);
	}
*/
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

	double gops = (double)((double)ARRAY_SIZE*(double)REPS*(double)tds)/vector_time/((double)1e9);
	double bw = (double)((double)ARRAY_SIZE*(double)REPS)*(double)4*(double)tds/vector_time/((double)1e9);
	double gops01 = (double)((double)ARRAY_SIZE*(double)REPS*(double)tds)/vector_time_01/((double)1e9);
	double bw1 = (double)((double)ARRAY_SIZE*(double)REPS)*(double)4*(double)tds/vector_time_01/((double)1e9);
	fprintf(stdout, "Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f REPS: %d BW: %.2f BW1: %.2f\n", tds, ARRAY_SIZE, vector_time, gops, vector_time_01, gops01, REPS, bw, bw1);

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
	int *aa;
	int k;
	int itr;

	aa = (int *)_mm_malloc(sizeof(int)*ARRAY_SIZE, 16);

	memset(&aa[0], 3, ARRAY_SIZE*4);

  __m128i a0,a1,a2,a3;
  __m128i a4,a5,a6,a7;
	__m128i cc;
	cc = _mm_set_epi32 (0, 0, 0, 0);

	for (k = 0; k < REPS; k++) 
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

			a0 = _mm_add_epi32(a0, a1);
			a1 = _mm_add_epi32(a2, a3);
			a2 = _mm_add_epi32(a4, a5);
			a3 = _mm_add_epi32(a6, a7);

			a0 = _mm_add_epi32(a0, a1);
			a1 = _mm_add_epi32(a2, a3);

			a0 = _mm_add_epi32(a0, a1);
			cc = _mm_add_epi32(a0, cc);
		}	
	}
	cc = _mm_hadd_epi32(cc,cc);
	cc = _mm_hadd_epi32(cc,cc);

	int count =0;
	count = _mm_cvtsi128_si32(cc) ;	

	free(aa);

	return count;
}


