#include <stdio.h>    
#include <stdlib.h>  

extern int calc_func(long long *x, int numOfRounds);

int compare (long long * x, long long * y){
	if (*x == *y)
		return 1;
	else
		return 0;
}

int main(int argc, char** argv){
  
	long long x;
	int numOfRounds;
	scanf("%Lx", &x);
	scanf("%d", &numOfRounds);
	calc_func(&x, numOfRounds);
	return 0;
}