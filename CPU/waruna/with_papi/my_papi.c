#include <stdio.h>
#include <stdlib.h>
#include <papi.h>
#include "my_papi.h"

#define REPS 3
//#define NUM_EVENTS 4


void my_papi_init();
void my_papi_finalize();
void my_papi_start(int *events, int NUM_EVENTS);
void my_papi_stop(int *events, int NUM_EVENTS);
void readCounters(int *events, int NUM_EVENTS, void *(*kernel)(void *));

long long  *values;

int *events;
int *events2;
int *events3;
int *events4;
int *events5;

    
/*		#define size 300
		const int m=300,n=300,p=300;
    double A[size*size];
    double B[size*size];
    double C[size*size];
void *matmul(void *nothing)
{
    int i, j, k;
    for (i = 0; i < m; ++i)
        for (j = 0; j < p; ++j) {
            double sum = 0;
            for (k = 0; k < n; ++k)
                sum += A[i*n + k] * B[k*p + j];
            C[i*p + j] = sum;
        }

	return NULL;
}

int main(int argc, char ** argv)
{

	my_papi_profile(matmul);

	return 0;
}
*/ 

void my_papi_init()
{
	events = (int *)malloc(sizeof(int)*5);
	events[0]=PAPI_L2_DCM;
	events[1]=PAPI_L1_DCM;
	events[2]=PAPI_L1_ICM;
	events[3]=PAPI_L2_ICM;
	events[4]=PAPI_TOT_INS;
	
	events2 = (int *)malloc(sizeof(int)*3);
	events2[0]=PAPI_L1_LDM;
	events2[1]=PAPI_L1_STM;
	events2[2]=PAPI_TLB_DM;
	
	events3 = (int *)malloc(sizeof(int)*3);
	events3[0]=PAPI_TLB_IM;
	events3[1]=PAPI_STL_ICY;
	events3[2]=PAPI_L2_DCH;
	
	events4 = (int *)malloc(sizeof(int)*3);
	events4[0]=PAPI_FP_INS;
	events4[1]=PAPI_L2_DCA;
	events4[2]=PAPI_FP_OPS;
	
	events5 = (int *)malloc(sizeof(int)*1);
	events5[0]=PAPI_L3_DCA;
}


void my_papi_start(int *events, int NUM_EVENTS)
{
	values = (long long *)malloc(sizeof(long long)*NUM_EVENTS);
	int ret;
	
	/* Start counting events */
	if ((ret = PAPI_start_counters(events, NUM_EVENTS)) != PAPI_OK) {
		 fprintf(stderr, "PAPI failed to start counters: %s\n", PAPI_strerror(ret));
		 // fprintf(stderr, "PAPI_start_counters - FAILED\n");
			exit(1);
	}
}

void my_papi_stop(int *events, int NUM_EVENTS)
{
	int j;
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

	if (values != NULL) {
		free(values);
	}
	
}

void my_papi_finalize()
{
	if (events != NULL) {
		free(events);
	}
	if (events2 != NULL) {
		free(events2);
	}
	if (events3 != NULL) {
		free(events3);
	}
	if (events4 != NULL) {
		free(events4);
	}
	if (events5 != NULL) {
		free(events5);
	}
}

void my_papi_profile(void *(*kernel)(void *))
{
	my_papi_init();
	readCounters(events, 5, kernel);
	readCounters(events2, 3, kernel);
	readCounters(events3, 3, kernel);
	readCounters(events4, 3, kernel);
	readCounters(events5, 1, kernel);
	my_papi_finalize();
}


void readCounters(int *events, int NUM_EVENTS, void *(*kernel)(void *)) 
{
    //long long *values = (long long *)malloc(sizeof(long long)*NUM_EVENTS);
		int i;
		//int ret,i,j;

	for (i=0; i<REPS; i++)
	{
  	my_papi_start(events, NUM_EVENTS);

		kernel(NULL);

		my_papi_stop(events, NUM_EVENTS);
	}
}

