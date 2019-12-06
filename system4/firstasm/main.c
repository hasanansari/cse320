#include <stdio.h>

int first(int);
int second(int, int);
int main() 
{
	int value = 27;
	int result = first(value);
	printf("first(%d) = %d\n", value, result);
	return 0;
}
