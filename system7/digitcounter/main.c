/**
 * @file main.c
 * Simple program to test and demonstrate and test digitcounter
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <lib320.h>

unsigned int digitcounter(unsigned int value);

void test(unsigned int value);

int main(int argc, char **argv)
{
	test(5);
	test(22);
	test(108);
	
	return 0;
}

void test(unsigned int value) 
{
	printf("digitcounter(%u) = %u\n", value, digitcounter(value));
}
