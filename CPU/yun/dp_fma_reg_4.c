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

double test_dp_avx_4_internal(size_t iterations){
	register __m256d r0, rA0, rB0, rInc0, rMul0, r1, rA1, rB1, rInc1, rMul1, r2, rA2, rB2, rInc2, rMul2, r3, rA3, rB3, rInc3, rMul3;

	r0 = _mm256_set_pd(6.800227, 6.617181, 2.059858, 9.124105);
	rA0 = _mm256_set_pd(7.208148, 5.870733, 3.900293, 2.529605);
	rB0 = _mm256_set_pd(3.137842, 1.190382, 9.883139, 5.652790);
	rInc0 = _mm256_set1_pd(0.228398);
	rMul0 = _mm256_set1_pd(0.322228);
	r1 = _mm256_set_pd(3.262978, 6.761228, 9.721907, 8.075916);
	rA1 = _mm256_set_pd(8.334882, 7.532320, 8.037163, 4.859266);
	rB1 = _mm256_set_pd(9.079756, 4.226589, 9.828144, 7.686861);
	rInc1 = _mm256_set1_pd(0.927340);
	rMul1 = _mm256_set1_pd(0.805186);
	r2 = _mm256_set_pd(6.082434, 7.758212, 1.735838, 8.459376);
	rA2 = _mm256_set_pd(1.330829, 4.896219, 6.391733, 8.638847);
	rB2 = _mm256_set_pd(9.646921, 1.951312, 2.108035, 7.095330);
	rInc2 = _mm256_set1_pd(0.670083);
	rMul2 = _mm256_set1_pd(0.169955);
	r3 = _mm256_set_pd(2.218916, 3.943002, 4.234430, 7.353952);
	rA3 = _mm256_set_pd(5.330590, 6.755454, 4.669177, 6.225066);
	rB3 = _mm256_set_pd(8.732171, 8.628063, 2.832430, 6.858128);
	rInc3 = _mm256_set1_pd(0.279491);
	rMul3 = _mm256_set1_pd(0.302977);

	unsigned long long iMask = 0x800fffffffffffffull;
	__m256d Mask = _mm256_set1_pd(*(double*)&iMask);
	__m256d VONE = _mm256_set1_pd(1.0);

	size_t i, j;
	for(i = 0; i < iterations; i++){
		for(j = 0; j < 1000; j++){
			r0 = _mm256_add_pd(r0, _mm256_mul_pd(rA0, rB0));
			r1 = _mm256_add_pd(r1, _mm256_mul_pd(rA1, rB0));
			r2 = _mm256_add_pd(r2, _mm256_mul_pd(rA2, rB0));
			r3 = _mm256_add_pd(r3, _mm256_mul_pd(rA3, rB0));

			r0 = _mm256_add_pd(r0, _mm256_mul_pd(rA0, rB1));
			r1 = _mm256_add_pd(r1, _mm256_mul_pd(rA1, rB1));
			r2 = _mm256_add_pd(r2, _mm256_mul_pd(rA2, rB1));
			r3 = _mm256_add_pd(r3, _mm256_mul_pd(rA3, rB1));

			r0 = _mm256_add_pd(r0, _mm256_mul_pd(rA0, rB2));
			r1 = _mm256_add_pd(r1, _mm256_mul_pd(rA1, rB2));
			r2 = _mm256_add_pd(r2, _mm256_mul_pd(rA2, rB2));
			r3 = _mm256_add_pd(r3, _mm256_mul_pd(rA3, rB2));

			r0 = _mm256_add_pd(r0, _mm256_mul_pd(rA0, rB3));
			r1 = _mm256_add_pd(r1, _mm256_mul_pd(rA1, rB3));
			r2 = _mm256_add_pd(r2, _mm256_mul_pd(rA2, rB3));
			r3 = _mm256_add_pd(r3, _mm256_mul_pd(rA3, rB3));

			rA0 = _mm256_mul_pd(rA0, rMul0);
			rA1 = _mm256_mul_pd(rA1, rMul1);
			rA2 = _mm256_mul_pd(rA2, rMul2);
			rA3 = _mm256_mul_pd(rA3, rMul3);

			rA0 = _mm256_add_pd(rA0, rInc0);
			rA1 = _mm256_add_pd(rA1, rInc1);
			rA2 = _mm256_add_pd(rA2, rInc2);
			rA3 = _mm256_add_pd(rA3, rInc3);

			rB0 = _mm256_mul_pd(rB0, rMul0);
			rB1 = _mm256_mul_pd(rB1, rMul1);
			rB2 = _mm256_mul_pd(rB2, rMul2);
			rB3 = _mm256_mul_pd(rB3, rMul3);

			rB0 = _mm256_add_pd(rB0, rInc0);
			rB1 = _mm256_add_pd(rB1, rInc1);
			rB2 = _mm256_add_pd(rB2, rInc2);
			rB3 = _mm256_add_pd(rB3, rInc3);
		}
		//reset the vector
		r0 = _mm256_and_pd(r0, Mask);
		r1 = _mm256_and_pd(r1, Mask);
		r2 = _mm256_and_pd(r2, Mask);
		r3 = _mm256_and_pd(r3, Mask);

		r0 = _mm256_or_pd(r0, VONE);
		r1 = _mm256_or_pd(r1, VONE);
		r2 = _mm256_or_pd(r2, VONE);
		r3 = _mm256_or_pd(r3, VONE);
	}
	r0 = _mm256_add_pd(r0, r1);
	r2 = _mm256_add_pd(r2, r3);

	r0 = _mm256_add_pd(r0, r2);

	double out = 0.0;
	__m256d tmp_value = r0;
    double *tmp = (double *)&tmp_value;

	out += tmp[0];
	out += tmp[1];
	out += tmp[2];
	out += tmp[3];

	return out;
}

void test_dp_avx_4(int tds, size_t iterations){
	printf("Start testing double precision avx 4....\n");

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
		double ret = test_dp_avx_4_internal(iterations);
		sum[omp_get_thread_num()] = ret;
	}

	//after = rapl_get_raw_energy_counters(fd, ru);

	//end timing
	gettimeofday(&time, NULL);
	elapsed_time = (((double) time.tv_sec) + ((double) time.tv_usec)/1000000) - elapsed_time;
	//compute consumed energy
	//consumed = rapl_get_energy_diff(before, after);

	long long nops = 48*iterations*tds*4*1000;

	printf("Elapsed time for double precision avx: %.6lf\n", elapsed_time);
	printf("Number of FP operations: %lld\n", nops);
	printf("GFlops: %.6lf\n", (double)(nops/1000000000)/elapsed_time);

	/*printf("The energy information...\n");
	rapl_print_energy_diff(before, after);
	printf("Eneregy per op: %.6lf (nJ/op)\n", consumed.pkg/(((double)nops)/1000000000));
*/
	int i;
	double out = 0.0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("the final sum: %.6lf\n", out);
	printf("End testing for double precision avx.\n");

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
	test_dp_avx_4(nthread, N);

	return 0;
}
