/**
 * Main program for testing the decoder
 */
#include <stdio.h>
#include "decoder.h"

/*
 * Main
 */
int main()
{
  const char
    *encoded="wiB=ihhYh=loBlhB=0hBB*lihBrYYBooYoYwhYh=rhrBY=r=il=o%=ii=YB%wBB0hYohioohlh%riBB*lhYwB0r==hhY0l=lrB=hB=0=YB%wrir0=r=h=w=0rwBrYhhlh*h%*iohrhrBYoY0=BhY=hB%%Bwrlhwlol0lw=Brr=hiBhh=%hoh*lihlhwoYBi=rrY%w%YY=YwoYlrhrB%hY00h=hh=0BYlhwhwYhBhBB=BrihrB%=iYl==Y=%=BBB*llhwh%YwYrwYw==o%0ww%Yi%=YBir00==hhw%*lYwh*wBYBho%=ihBr%Bw*llhwh=BBlil=oi0=ilrrrY=BBhh0%wY=*=%olBBlhilil0oh=hwh=0iwBriBh=io0B0=hB==Ywo%=hYBhihrBYoY=hiBYBo=oYBwBB0oB0wB=h=wwrlhrohB%Y=l0BilBr0ii%=wYr=0B00=r=iho%0lBr=oBlol0=hhw%B=BBloBBYl=BhrB*=Y=hihY=hB%YBlBrBB%ilw=hiB%B==%YB%==BiBlhriiBB%0B%rohB%%wihBB0=hB%ioo0=hwh=BBB%%hYw=0=%0lw=Bl";

  char decoded[1000];

  decoder(encoded, decoded, sizeof(decoded));
  printf("%s\n", decoded);

  return 0;
}

