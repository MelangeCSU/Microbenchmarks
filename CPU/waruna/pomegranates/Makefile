CC := gcc

EXES := cpu_max_plus tsse4 tave2 tsse4p tsse4l1 tsse4l1p tsse4l12 tsse4l12p

SSEFLAGS := -msse4.2
AVXFLAGS := -mavx
OMPFLAGS := -fopenmp
VEC_REPORT := -ftree-vectorizer-verbose=6
OTHER_FLAGS := -Wall

cpu_max_plus:	cpu_max_plus.c timer.o
	$(CC) -O3 -o $@ $< timer.o $(OTHER_FLAGS)

cpu_max_plus_debug:	cpu_max_plus.c timer.o
	$(CC) -O3 -g -o $@ $< timer.o $(OTHER_FLAGS)

%.o: %.c %.h
	$(CC) -O3 -c $< -o $@ $(OTHER_FLAGS)

%.s: %.c
	$(CC) -O3 -S $< > $@ $(SSEFLAGS)
	#$(CC) -O3 -S $< > $@ $(SSEFLAGS) $(OMPFLAGS)
	#$(CC) -O3 -S -masm=intel $< > $@ $(SSEFLAGS)
	#make clean
	#make cpu_max_plus_debug
	#objdump -S -l $<_debug > $@
	#make clean

tsse4: testSSE4.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4p: testSSE4.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

tsse4l1: testSSE4L1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4l1p: testSSE4L1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

tsse4l11: testSSE4L1.1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4l11p: testSSE4L1.1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

tsse4l12: testSSE4L1.2.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4l12p: testSSE4L1.2.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o -DOMP $(OTHER_FLAGS)

tsse4l13: testSSE4L1.3.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4l13p: testSSE4L1.3.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o -DOMP $(OTHER_FLAGS)

tsse4l131: testSSE4L1.3.1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tsse4l131p: testSSE4L1.3.1.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o -DOMP $(OTHER_FLAGS)


tsse401p: testSSE401.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

tsse402p: testSSE402.c timer.o
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

ssse4: simpleSSE4.c
	$(CC) -O3 -o $@ $< $(SSEFLAGS)  $(OTHER_FLAGS)

ssse4p: simpleSSE4.c
	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) $(OTHER_FLAGS)

tave: testAVE.c timer.o
	$(CC) -O3 -o $@ $< $(AVXFLAGS) $(SSEFLAGS) timer.o $(OTHER_FLAGS)

tavep: testAVE.c timer.o
	$(CC) -O3 -o $@ $< $(AVXFLAGS) $(SSEFLAGS) $(OMPFLAGS) timer.o $(OTHER_FLAGS)

tave2: testAVE2.c
	$(CC) -O3 -o $@ $< $(AVXFLAGS) $(OTHER_FLAGS)

#tsse4l11: testSSE4L11.c timer.o
#	$(CC) -O3 -o $@ $< $(SSEFLAGS) timer.o $(OTHER_FLAGS)
#
#tsse4l11p: testSSE4L11.c timer.o
#	$(CC) -O3 -o $@ $< $(SSEFLAGS) $(OMPFLAGS) timer.o

clean:
	rm -f *.o $(EXES)
