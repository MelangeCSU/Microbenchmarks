CC := gcc

EXES := cpu_max_plus tsse4 tave2 tsse4p

SSEFLAGS := -msse4.2
OMPFLAGS := -fopenmp

cpu_max_plus:	cpu_max_plus.c timer.o
	$(CC) -O3 -o $@ $< timer.o

cpu_max_plus_debug:	cpu_max_plus.c timer.o
	$(CC) -O3 -g -o $@ $< timer.o

%.o: %.c %.h
	$(CC) -O3 -c $< -o $@

%.s: %.c
	$(CC) -O3 -S $< > $@ $(SSEFLAGS)
	#$(CC) -O3 -S -masm=intel $< > $@ $(SSEFLAGS)
	#make clean
	#make cpu_max_plus_debug
	#objdump -S -l $<_debug > $@
	#make clean

tsse4: testSSE4.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o

tsse4p: testSSE4.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o

tave2: testAVE2.c
	$(CC) -O3 -o $@ $< $(SSEFLAGS)

clean:
	rm -f *.o $(EXES)
