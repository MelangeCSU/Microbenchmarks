CFLAGS=-O3 -lm -fopenmp -mavx
LIBRARIES=-lm
CC=gcc
OBJS =  
all: dp_fma_reg_4 sp_fma_reg_4

debug: CFLAGS =-DDEBUG -g -Wall -Wextra -std=c99
debug: all
		
dp_fma_reg_4: dp_fma_reg_4.c
	$(CC) dp_fma_reg_4.c -o dp_fma_reg_4 $(OBJS) $(CFLAGS) $(LIBRARIES)

sp_fma_reg_4: sp_fma_reg_4.c
	$(CC) sp_fma_reg_4.c -o sp_fma_reg_4 $(OBJS) $(CFLAGS) $(LIBRARIES)


clean:
	rm -f *.o dp_fma_reg_4 sp_fma_reg_4
