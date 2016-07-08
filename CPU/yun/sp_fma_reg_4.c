#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <limits.h>
#include <float.h>
#include <omp.h>
#include <malloc.h>
#include <time.h>
#include <sys/time.h>
#include <sys/errno.h>
#include <immintrin.h>

//#include "rapl.h"

double test_sp_avx_4_internal(size_t iterations){
	register __m256 r0, rA0, rB0, rInc0, rMul0, r1, rA1, rB1, rInc1, rMul1, r2, rA2, rB2, rInc2, rMul2, r3, rA3, rB3, rInc3, rMul3;

	r0 = _mm256_set1_ps(8.248671);
	rA0 = _mm256_set1_ps(9.323381);
	rB0 = _mm256_set1_ps(9.957336);
	rInc0 = _mm256_set1_ps(0.094433);
	rMul0 = _mm256_set1_ps(0.146911);
	r1 = _mm256_set1_ps(1.306266);
	rA1 = _mm256_set1_ps(4.853354);
	rB1 = _mm256_set1_ps(8.289525);
	rInc1 = _mm256_set1_ps(0.701048);
	rMul1 = _mm256_set1_ps(0.432712);
	r2 = _mm256_set1_ps(7.582443);
	rA2 = _mm256_set1_ps(2.718192);
	rB2 = _mm256_set1_ps(2.453280);
	rInc2 = _mm256_set1_ps(0.831679);
	rMul2 = _mm256_set1_ps(0.824627);
	r3 = _mm256_set1_ps(1.171852);
	rA3 = _mm256_set1_ps(7.733772);
	rB3 = _mm256_set1_ps(1.155836);
	rInc3 = _mm256_set1_ps(0.444299);
	rMul3 = _mm256_set1_ps(0.202265);

	unsigned long long iMask = 0x800fffffffffffffull;
	__m256 Mask = _mm256_set1_ps(*(float*)&iMask);
	__m256 VONE = _mm256_set1_ps(1.0);

	size_t i, j;
	for(i = 0; i < iterations; i++){
		for(j = 0; j < 1000; j++){
			r0 = _mm256_add_ps(r0, _mm256_mul_ps(rA0, rB0));
			r1 = _mm256_add_ps(r1, _mm256_mul_ps(rA1, rB0));
			r2 = _mm256_add_ps(r2, _mm256_mul_ps(rA2, rB0));
			r3 = _mm256_add_ps(r3, _mm256_mul_ps(rA3, rB0));

			r0 = _mm256_add_ps(r0, _mm256_mul_ps(rA0, rB1));
			r1 = _mm256_add_ps(r1, _mm256_mul_ps(rA1, rB1));
			r2 = _mm256_add_ps(r2, _mm256_mul_ps(rA2, rB1));
			r3 = _mm256_add_ps(r3, _mm256_mul_ps(rA3, rB1));

			r0 = _mm256_add_ps(r0, _mm256_mul_ps(rA0, rB2));
			r1 = _mm256_add_ps(r1, _mm256_mul_ps(rA1, rB2));
			r2 = _mm256_add_ps(r2, _mm256_mul_ps(rA2, rB2));
			r3 = _mm256_add_ps(r3, _mm256_mul_ps(rA3, rB2));

			r0 = _mm256_add_ps(r0, _mm256_mul_ps(rA0, rB3));
			r1 = _mm256_add_ps(r1, _mm256_mul_ps(rA1, rB3));
			r2 = _mm256_add_ps(r2, _mm256_mul_ps(rA2, rB3));
			r3 = _mm256_add_ps(r3, _mm256_mul_ps(rA3, rB3));

			rA0 = _mm256_mul_ps(rA0, rMul0);
			rA1 = _mm256_mul_ps(rA1, rMul1);
			rA2 = _mm256_mul_ps(rA2, rMul2);
			rA3 = _mm256_mul_ps(rA3, rMul3);

			rA0 = _mm256_add_ps(rA0, rInc0);
			rA1 = _mm256_add_ps(rA1, rInc1);
			rA2 = _mm256_add_ps(rA2, rInc2);
			rA3 = _mm256_add_ps(rA3, rInc3);

			rB0 = _mm256_mul_ps(rB0, rMul0);
			rB1 = _mm256_mul_ps(rB1, rMul1);
			rB2 = _mm256_mul_ps(rB2, rMul2);
			rB3 = _mm256_mul_ps(rB3, rMul3);

			rB0 = _mm256_add_ps(rB0, rMul0);
			rB1 = _mm256_add_ps(rB1, rMul1);
			rB2 = _mm256_add_ps(rB2, rMul2);
			rB3 = _mm256_add_ps(rB3, rMul3);
		}
		//reset the vector
		r0 = _mm256_and_ps(r0, Mask);
		r1 = _mm256_and_ps(r1, Mask);
		r2 = _mm256_and_ps(r2, Mask);
		r3 = _mm256_and_ps(r3, Mask);

		r0 = _mm256_or_ps(r0, VONE);
		r1 = _mm256_or_ps(r1, VONE);
		r2 = _mm256_or_ps(r2, VONE);
		r3 = _mm256_or_ps(r3, VONE);
	}
	r0 = _mm256_add_ps(r0, r1);
	r2 = _mm256_add_ps(r2, r3);

	r0 = _mm256_add_ps(r0, r2);

	double out = 0.0;
	__m256 tmp = r0;

	out += (double)tmp[0];
	out += (double)tmp[1];
	out += (double)tmp[2];
	out += (double)tmp[3];
	out += (double)tmp[4];
	out += (double)tmp[5];
	out += (double)tmp[6];
	out += (double)tmp[7];

	return out;
}

void test_sp_avx_4(int tds, size_t iterations){
	printf("Start testing single precision avx 4....\n");

	/*int fd;
	int cpu_model;
	struct rapl_units ru;
	struct rapl_pkg_power_info pinfo;
	struct rapl_raw_energy_counters before, after, consumed;

	//check CPU
	cpu_model = detect_cpu();
	if(cpu_model < 0){
		printf("Unsupported CPU type\n");
		exit(-1);
	}
	printf("Checking core #%d\n", core);
	//mornitoring through msr
	fd=open_msr(core);

	ru = rapl_get_units(fd);
*/
	double *sum = (double *)malloc(tds*sizeof(double));
	//Timing
	struct timeval time;
	double elapsed_time;

	//start timing
	gettimeofday(&time, NULL);
	elapsed_time = (((double) time.tv_sec) + ((double) time.tv_usec)/1000000);

	//read energy before
	//before = rapl_get_raw_energy_counters(fd, ru);

	#pragma omp parallel num_threads(tds)
	{
		double ret = test_sp_avx_4_internal(iterations);
		sum[omp_get_thread_num()] = ret;
	}

	//after = rapl_get_raw_energy_counters(fd, ru);

	//end timing
	gettimeofday(&time, NULL);
	elapsed_time = (((double) time.tv_sec) + ((double) time.tv_usec)/1000000) - elapsed_time;
	//compute consumed energy
	//consumed = rapl_get_energy_diff(before, after);

	long long nops = 48*iterations*tds*8*1000;

	printf("Elapsed time for single precision avx: %.6lf\n", elapsed_time);
	printf("Number of FP operations: %lld\n", nops);
	printf("GFlops: %.6lf\n", (double)(nops/1000000000)/elapsed_time);
/*
	printf("The energy information...\n");
	rapl_print_energy_diff(before, after);
	printf("Eneregy per op: %.6lf (nJ/op)\n", consumed.pkg/(((double)nops)/1000000000));
*/
	int i;
	double out = 0.0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("the final sum: %.6lf\n", out);
	printf("End testing for single precision avx.\n");

//	close(fd);
	free(sum);
}

int main(int argc, char **argv){
	if(argc < 3){
		printf("Expect argument nthread, N,  core\n");
		exit(-1);
	}

	//read the parameters
	int nthread = atoi(argv[1]);
	long N = atol(argv[2]);
	//int core = atoi(argv[3]);

	//call the test
	test_sp_avx_4(nthread, N);

	return 0;
}
