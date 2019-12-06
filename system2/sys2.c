/**
  * My first C program
  * @author Gabby Kelsch Bledsoe
  */

#include <stdio.h>

double square(double x);
int factorial(int n);

/**
  * Main entry point
  */

int main()
{
  int wins = 11;
  int losses = 2;
  double radius = 7.88;
  double height = 12.231;
  printf("My first C program\n");
  printf("The cylinder has a radius of %5.2f and a height of %8.1f\n", radius,
      height);
  printf("Faber College had an %2d-%1d season in 2010!\n",wins, losses);
  printf("The factorial of 4 is %d\n", factorial(4));
  printf("The square of 22 is %f\n", square(22));
  return 0;
}

/**
  * Compute the factorial of a number
  */

int factorial(int n)
{
  int f = 1;
  int i;
  for(i=1; i<=n; i++)
  {
    f *= i;
  }
  return f;
}

/**
  * Compute the square of a number
  */
double square(double x)
{
  return x*x;
}
