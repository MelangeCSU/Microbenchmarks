#include <stdio.h>
#include <stdlib.h>
#include <papi.h>

#define REPS 5
//#define NUM_EVENTS 4

void readCounters(int *events, int NUM_EVENTS);
void readCounter(int *event);

void matmul(const double *A, const double *B,
        double *C, int m, int n, int p)
{
    int i, j, k;
    for (i = 0; i < m; ++i)
        for (j = 0; j < p; ++j) {
            double sum = 0;
            for (k = 0; k < n; ++k)
                sum += A[i*n + k] * B[k*p + j];
            C[i*p + j] = sum;
        }
}

int main(int argc, char ** argv)
{

    //int event[NUM_EVENTS] = {PAPI_TOT_INS, PAPI_TOT_INS, PAPI_L2_DCM, PAPI_L1_DCM};
    //int event[NUM_EVENTS] = {PAPI_TOT_INS, PAPI_L1_DCM, PAPI_L2_DCM, PAPI_TOT_INS};
    int *events = (int *)malloc(sizeof(int)*5);
		events[0]=PAPI_L2_DCM;
		events[1]=PAPI_L1_DCM;
		events[2]=PAPI_L1_ICM;
		events[3]=PAPI_L2_ICM;
		events[4]=PAPI_TOT_INS;
    //int events[NUM_EVENTS] = {PAPI_L2_DCM, PAPI_L1_DCM, PAPI_L1_ICM, PAPI_L2_ICM};
    //int event1[1] = {PAPI_LD_INS};
    //int event2[1] = {PAPI_SR_INS};
    int *events2 = (int *)malloc(sizeof(int)*3);
    events2[0]=PAPI_L1_LDM;
		events2[1]=PAPI_L1_STM;
		events2[2]=PAPI_TLB_DM;
		int *events3 = (int *)malloc(sizeof(int)*3);
		events3[0]=PAPI_TLB_IM;
		events3[1]=PAPI_STL_ICY;
		events3[2]=PAPI_L2_DCH;
		int *events4 = (int *)malloc(sizeof(int)*3);
		events4[0]=PAPI_FP_INS;
		events4[1]=PAPI_L2_DCA;
		events4[2]=PAPI_FP_OPS;
		int *events5 = (int *)malloc(sizeof(int)*1);
		events5[0]=PAPI_L3_DCA;
    //int events2[2] = {PAPI_L1_LDM,PAPI_L1_STM};
//  int event[NUM_EVENTS] = {PAPI_TOT_INS, PAPI_TOT_CYC, PAPI_L2_DCM, PAPI_L1_DCM };
    //int event[NUM_EVENTS] = {PAPI_TOT_INS, PAPI_TOT_CYC, PAPI_BR_MSP, PAPI_L1_DCM };
    
		readCounters(events, 5);
    readCounters(events2, 3);
    readCounters(events3, 3);
    readCounters(events4, 3);
    readCounters(events5, 1);


    return 0;
}

void readCounters(int *events, int NUM_EVENTS) 
{
    long long *values = (long long *)malloc(sizeof(long long)*NUM_EVENTS);
    //long long values[NUM_EVENTS];
    const int size = 300;
    double a[size][size];
    double b[size][size];
    double c[size][size];
		int ret,i,j;

	for (i=0; i<REPS; i++)
	{
    /* Start counting events */
    if ((ret = PAPI_start_counters(events, NUM_EVENTS)) != PAPI_OK) {
			 fprintf(stderr, "PAPI failed to start counters: %s\n", PAPI_strerror(ret));
       // fprintf(stderr, "PAPI_start_counters - FAILED\n");
        exit(1);
    }

    matmul((double *)a, (double *)b, (double *)c, size, size, size);

    /* Read the counters */
    if (PAPI_read_counters(values, NUM_EVENTS) != PAPI_OK) {
        fprintf(stderr, "PAPI_read_counters - FAILED\n");
        exit(1);
    }

	for (j=0; j<NUM_EVENTS; j++) 
	{
    printf("[%d]: %lld\n", events[j], values[j]);
	}
    /* Stop counting events */
    if (PAPI_stop_counters(values, NUM_EVENTS) != PAPI_OK) {
        fprintf(stderr, "PAPI_stoped_counters - FAILED\n");
        exit(1);
    }
	}
	
}

void readCounter(int *event) 
{
    long long value[1];
    const int size = 300;
    double a[size][size];
    double b[size][size];
    double c[size][size];
		int ret,i;

	for (i=0; i<REPS; i++)
	{
    /* Start counting events */
    if ((ret = PAPI_start_counters(event, 1)) != PAPI_OK) {
			 fprintf(stderr, "PAPI failed to start counters: %s\n", PAPI_strerror(ret));
       // fprintf(stderr, "PAPI_start_counters - FAILED\n");
        exit(1);
    }

    matmul((double *)a, (double *)b, (double *)c, size, size, size);

    /* Read the counters */
    if (PAPI_read_counters(value, 1) != PAPI_OK) {
        fprintf(stderr, "PAPI_read_counters - FAILED\n");
        exit(1);
    }

    printf("[%d]: %lld\n", event[0], value[0]);

    /* Stop counting events */
    if (PAPI_stop_counters(value, 1) != PAPI_OK) {
        fprintf(stderr, "PAPI_stoped_counters - FAILED\n");
        exit(1);
    }
	}

}
