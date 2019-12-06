#include "decoder.h"
#include <string.h>
/**
 * Decode an encoded string into a character stream.
 * @param encoded The input string we are decoding
 * @param decoded The output string we produce
 * @param maxLen The maximum size for decoded
 */
void decoder(const char *encoded, char *decoded, int maxLen)
{
  int bit = 0;

  /*Make decoded a list of 0s length based on maxLen */
  for(int i=0; i<maxLen; i++)
  {
    decoded[i] = 0;
  }
  /*While not past maxLen and still chars in *encoded to decode */
  while(bit/8 < maxLen && *encoded)
  {
    /*Compare each char in *encoded to its corresponding bit value*/
    switch(*encoded)
    {
      /*for each case, bit acts as the location in decoded to add a 1*/
      case 'r':
        /*Increment bit if 0*/
        bit += 3;
        break;

      case 'l':
        bit += 2;
        /*math to determine where in which byte to place the 1*/
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;
    
      case 'w':
        bit += 1;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit += 2;
        break; 

      case '0':
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;

      case 'i':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit += 3;
        break;

      case 'o':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit += 2;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;

      case '%':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit += 2;
        break;

      case '*':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;

      case 'B':
        bit += 2;
        break;

      case '=':
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;

      case 'h':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit += 2;
        break;

      case 'Y':
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        decoded[bit/8] |= 1 << (7-(bit%8));
        bit++;
        break;
    }
    /*Move to the next char in *encoded*/
    encoded++;    
  }
}
