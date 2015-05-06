#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "timer.h"
#include <limits.h>

//#define N 999999999
#define N 500999999
#define M 10
#define REG 4
#define    max(x,y)   ((x)>(y) ? (x) : (y))

int main(int argc, char **argv) {
	unsigned int i, j;
	float time;
	register unsigned int reg1[REG];
	register unsigned int reg2[REG];
	register unsigned int b, c, d, e;
	reg1[0] = 11;
	reg1[1] = 3;
	reg1[2] = 6;
	reg1[3] = 10;

	reg2[0] = 81;
	reg2[1] = 100;
	reg2[2] = 99;
	reg2[3] = 1;

	initialize_timer();
	start_timer();

	for (j = 0; j < M; j++) {
#pragma omp parallel for reduction(+:b,c,d,e)
		for (i = 0; i < N; i++) {
			c = max(c + reg1[1], reg2[1]);
			b = max(b + reg1[0], reg2[0]);
			d = max(d + reg1[2], reg2[2]);
			e = max(e + reg1[3], reg2[3]);
		}
	}

	stop_timer();
	time = elapsed_time();
	printf("Time = %f sec, Ops = %f GOps\n", time,
			((float) ((float) N * (float) 8) / (time * 1000000000)) * M);
	printf("%d %d %d %d\n", b, c, d, e);
	return 0;
}
