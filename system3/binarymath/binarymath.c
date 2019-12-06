#include <stdlib.h>
#include <string.h>
#include "binarymath.h"
#include <stdio.h>
/**
 * Increment a BINARY_SIZE binary number expressed as a 
 * character string.
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *inc(const char *number)
{
  char *inc_num = (char*)calloc(strlen(number)+1, sizeof(char));
  strncpy(inc_num, number, strlen(number));
  int bit = strlen(number) -1;
  while(bit >= 0) //Go through number from right to left
  {
    if(inc_num[bit] == '0')
    {
      inc_num[bit] = '1';
      break;
    }
    else if(inc_num[bit] == '1')
    {
      inc_num[bit] = '0';
    }
  bit--;
  }
  return inc_num;
}

/**
 * Negate a BINARY_SIZE binary number expressed as a character string
 * @param number The number we are passed
 * @returns Negated version of the number
 */
char *negate(const char *number)
{
  //To negate, make the two's complement
  char *neg_num = (char*)calloc(strlen(number)+1, sizeof(char)); 
  strncpy(neg_num, number, strlen(number));
  //Flip all bits in number
  int bit = strlen(number)-1;
  while (bit >= 0)
  {
    if(number[bit] == '0')
    {
      neg_num[bit]='1';
    }
    else if(number[bit] == '1')
    {
      neg_num[bit]='0';
    }
    bit--;
  }
  //Call on inc function to add one
  char *inc_num = inc(neg_num);
  free(neg_num);
  return inc_num;
}

/**
 * Add two BINARY_SIZE binary numbers expressed as
 * a character string. 
 * @param a First number to add
 * @param b Second number to add
 * @return a + b
 */
char *add(const char *a, const char *b)
{
  int bit = strlen(a)-1;
  char *sum = (char*)calloc(strlen(a)+1, sizeof(char));
  strncpy(sum,a, strlen(a)); 
  //Initialize carry to 0
  char c= '0';
  while (bit >= 0)
  {
  //Determine the sum based on the two inputs and carry
    if(a[bit]=='0' && b[bit]=='0')
    {
      if(c=='1')
      {
        sum[bit]='1';
        c='0';
      }
    }
    else if((a[bit]=='0' && b[bit]=='1')||(a[bit]=='1' && b[bit]=='0'))
    {
      if(c=='1')
      {
        sum[bit]='0';
      }  
      else
      {
        sum[bit] = '1';
      }
    }  
    else if((a[bit]=='1' && b[bit]=='1'))
    {
      if(c=='0')
      {
        sum[bit]='0';
        c='1';
      }
      else
      {
        sum[bit]='1';
      }
    } 
    bit--;
  }  
  return sum;
}

/**
 * Subtract two BINARY_SIZE binary numbers expressed as
 * a character string.
 * @param a First number
 * @param b Second number 
 * @return a - b
 */
char *sub(const char *a, const char *b)
{
  //negate b then add a and -b
  char *neg_b = negate(b);
  char *sub = add(a, neg_b);
  free(neg_b);
  return sub;  
}
