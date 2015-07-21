
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/time.h>
#include "papi.h"

#define MX 1024
#define NITER 20
#define MEGA 1000000
#define TOT_FLOPS (2*MX*MX*NITER)

#define NUM_COUNTERS 1

double *ad[MX];

/* Get actual CPU time in seconds */
float gettime() 
{
	return((float)PAPI_get_virt_usec()/1000000.0f);
}

int main () 
{
	float t0, t1;
	int iter, i, j;
	int events[NUM_COUNTERS] = {PAPI_LD_INS}, ret;
	//int events[NUM_COUNTERS] = {PAPI_LD_INS, PAPI_L2_DCM}, ret;
	//int events[NUM_COUNTERS] = {PAPI_L1_DCM, PAPI_LD_INS, PAPI_L2_DCM}, ret;
	//int events[NUM_COUNTERS] = {PAPI_L1_DCM, PAPI_FP_OPS, PAPI_LD_INS, PAPI_SR_INS }, ret;
	long_long values[NUM_COUNTERS];

	if (PAPI_num_counters() < NUM_COUNTERS) {
		 fprintf(stderr, "No hardware counters here, or PAPI not supported.\n");
		 exit(1);
	}

	for (i = 0; i < MX; i++) {
			if ((ad[i] = malloc(sizeof(double)*MX)) == NULL) {
					fprintf(stderr,"malloc failed\n");
					exit(1);
			}
	}
	for (j = 0; j < MX; j++) { 
			for (i = 0; i < MX; i++) {
					ad[i][j] = 1.0/3.0; /* Initialize the data */
			}
	}
	t0 = gettime();
	if ((ret = PAPI_start_counters(events, NUM_COUNTERS)) != PAPI_OK) {
		 fprintf(stderr, "PAPI failed to start counters: %s\n", PAPI_strerror(ret));
		 exit(1);
	}
	for (iter = 0; iter < NITER; iter++) {
			for (j = 0; j < MX; j++) {
					for (i = 0; i < MX; i++) {
							ad[i][j] += ad[i][j] * 3.0;
					}
			}
	}
	if ((ret = PAPI_read_counters(values, NUM_COUNTERS)) != PAPI_OK) {
		fprintf(stderr, "PAPI failed to read counters: %s\n", PAPI_strerror(ret));
		exit(1);
	}
	t1 = gettime();

	printf("L1 cache misses = %.0f\n",(float)values[0]);
//	printf("Loads = %.0f\n",(float)values[1]);
//	printf("Stores = %.0f\n",(float)values[2]);
	printf("Time: %.2f\n", (t1-t0));
	//printf("MFlop/s = %.2f\n", (float)(TOT_FLOPS/MEGA)/(t1-t0));
	//printf("L1 data cache miss rate %.2f\n", 1.0f - ((double)values[0] / ((double)values[1] + (double)values[2])));

	return 0;
}

