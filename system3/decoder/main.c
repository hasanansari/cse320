#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Actual nodes in the linked list
typedef struct LinkedListNode
{
  char *name;
  struct LinkedListNode *next;
} LinkedListNode;

//A structure to represent the linked list
typedef struct
{
  LinkedListNode *head;
  LinkedListNode *tail;
} LinkedList;

/**
 * Initialize a linked list to empty
 * @param list Pointer to the linked list struct
 */
void initialize_list(LinkedList *list)
{
  list->head = NULL;
  list->tail = NULL;
}

/**
 * Append a name onto the end of the list.
 * @param list Pointer to the linked list struct
 * @param name Name to add to the list
 */
void append_list(LinkedList *list, const char *name)
{
  //Allocate a linked list node
  LinkedListNode *node = (LinkedListNode *)calloc(1, sizeof(LinkedListNode));
  node->next = NULL;

  //Copy the name into the list
  node->name = (char *)calloc(strlen(name) +1, sizeof(char));
  strncpy(node->name, name, strlen(name));

  if (list->head == NULL)
  {
    //List is empty, make this the head and tail of the list
    list->head = node;
    list->tail = node;
  }
  else
  {
    //Link onto the tail of the list
    node->next = list->head;
    list->head = node;
  }
}  

/**
 * Free the memory allocated for our list
 * @param list Pointer to linked list object
 */
void free_list(LinkedList *list)
{
  LinkedListNode *node;

  for (node = list->head; node != NULL; )
  {
    LinkedListNode *next = node->next;

    free(node->name);
    free(node);

    node = next;
  }

  list->head = NULL;
  list->tail = NULL;
}

/**
 * Increment a binary nmber expressed as a character string.
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *inc(const char *number)
{
  char *inc_num = (char*)calloc(strlen(number)+1, sizeof(char));
  strncpy(inc_num, number, strlen(number));
  int bit = strlen(number) -1;
  //Go through number from right to left
  while(bit >=0) 
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
 * Negate a binary number expressed as a character string
 * @param number The number we are passed
 * @returns Negated version of the number
 */
char *negate(const char *number)
{
  //To negate, make the two's complement
  char *neg_num = (char *)calloc(strlen(number)+1, sizeof(char));
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
 * Add two binary numbers expressed as a character string.
 * @param a First number to add
 * @param b Second number to add
 * @return a + b
 */
char *add(const char *a, const char *b)
{
  int bit = strlen(a)-1;
  char *sum = (char*)calloc(strlen(a)+1, sizeof(char));
  strncpy(sum, a, strlen(a));
  //Initialize carry to 0
  char c = '0';
  while (bit>= 0)
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
    else if ((a[bit]=='0' && b[bit]=='1')||(a[bit]=='1' && b[bit]=='0'))
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
 * Subtract two binary numbers expressed as a character string.
 * @param a First number
 * @param b Second number
 * @return a - b
 */
char *sub(const char *a, const char *b)
{
  //negate b then add a and -b
  char *neg_b = negate(b);
  char *sub = add(a, neg_b);
  return sub;
}

/**
 * Calculate the xor of two binary numbers expressed as a character string.
 * @param a First number
 * @param b Second number
 * @return a xor b
 */
char *xor(const char *a, const char *b)
{
  int bit = strlen(a)-1;
  char *xor = (char*)calloc(strlen(a)+1, sizeof(char));
  strncpy(xor, a, strlen(a));
  //Compare the two inputs
  while(bit>=0)
  {
    //Determine the xor of a and b
    if((a[bit]=='0' && b[bit]=='0')||(a[bit]=='1' && b[bit]=='1'))
    {
      xor[bit]='0';
    }
    else if ((a[bit]=='0'&&b[bit]=='1')||(a[bit]=='1' && b[bit]=='0'))
    {
      xor[bit]='1';
    }
  bit--;
  }
  return xor;
}

int main(int argc, char *argv[])
{
  if (argc < 2)
  {
    printf("Usage: rpn file\n");
    return 1;
  }

  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL)
  {
    printf("Unable to open input file\n");
    return 1;
  }

  LinkedList list;
  LinkedListNode *node;

  //
  // Initialize the list
  //
  initialize_list(&list);
  char line[1001];
  //read the lines of the file
  while(fgets(line, sizeof(line), fp) != NULL)
  {
    //Remove the newline
    size_t len = strlen(line);
    if (line[len-1] == '\n')
    {
      line[len-1] = '\0';
    }
    
    //Push- pushes number to top of stack
    if(line[0] == 'P')
    {
      char *num = (char*)calloc(strlen(line), sizeof(char));
      strncpy(num, line+1, strlen(line)-1);
      append_list(&list, num);
    }
    //Add- compute the sum of the value of the line and the stack top
    //Push that onto the stack
    else if(line[0] == 'A')
    {
      char *num = (char*)calloc(strlen(line), sizeof(char));
      strncpy(num, line+1, strlen(line)-1);
      char *sum = add(num, list.head->name);
      append_list(&list, sum);
    }
    //Sub- compute the difference of the value of the line and
    //the stack top. Push that onto the stack
    else if(line[0] == 'S')
    {
      char *num = (char*)calloc(strlen(line), sizeof(char));
      strncpy(num, line+1, strlen(line)-1);
      char *neg_line = negate(list.head->name);
      char *sub = add(num, neg_line);
      append_list(&list, sub);
    }
    //XOR- compute the xor of the value of the line and the
    //stack top. Push that onto the stack
    else if(line[0] == 'X')
    {
      char *num = (char*)calloc(strlen(line), sizeof(char));
      strncpy(num, line+1, strlen(line)-1);
      char *r = xor(num, list.head->name);
      append_list(&list, r);
    }  
  }

  //
  // Iteratae through the list
  // displaying each name
  //
  for (node = list.head; node != NULL; node = node->next)
  {
    for(int i=0; i < strlen(node->name); i++)
    {
      if (node->name[i] == '0')
      {
        printf("%c", ' ');
      }
      else if (node->name[i] == '1')
      {
        printf("%c", 'X');
      }
    }
    printf("\n");
  }

  //
  // Free the memory allocated to the list
  //
  free_list(&list);
  fclose(fp);
  return 0;
}

