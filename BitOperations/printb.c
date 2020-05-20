#include <stdio.h>

/* @TODO write this in assembly */
void printb(long long n)
{
  long long s,c;
  const int num_bits = 63;

  for (c = num_bits; c >= 0; c--) {
    s = n >> c;
    /* space after every bit */
    if ((c+1) % 8 == 0) printf(" ");
    if (s & 1)
      printf("1");
    else
      printf("0");
  }
  printf("\n");
}
