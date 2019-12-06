#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <time.h>

void trim_newline(char *);
void generate_letter(int cnt);

/**
 * main()
 * Program main entry point
 */
int main(int argc, char **argv)
{
	srand(time(NULL));
	
	char yourname[50];
	char recipient[50];
	
	printf("Your name: ");
	fgets(yourname, sizeof(yourname), stdin);
	trim_newline(yourname);
	
	printf("Recipient name: ");
	fgets(recipient, sizeof(recipient), stdin);
	trim_newline(recipient);
	
	printf("\nDear %s,\n\n", recipient);
	
	generate_letter(10);
	
	printf("\n\nLove,\n%s\n\n", yourname);
	
	return 0;
}

/**
 * Remove any trailing newline character
 */
void trim_newline(char *str)
{
	size_t len = strlen(str);
	if(len == 0) 
	{
		return;
	}
	
	if(str[len-1] == '\n')
	{
		str[len-1] = '\0';
	}
}

void generate_letter(int cnt) 
{
	const char *lines[] = {
		"I love you with all my heart.",
		"If I don't see you again soon I'm a gonna die!",
		"Just as Darth Vader, an evil Sith Lord, could not leave his son to die, nor shall I ever leave you.",
		"I love you more than Sparty.",
		"When you are away, my toes ache.",
		"I would rob a convenience store for you.",
		"Every minute you are away seems like 17.53 hours.",
		"You are the hamster to my wheel.",
		"You are the Style to my Gangnum.",
		"When I smell flowers, I think of you, but only if the flowers smell really good.",
		"Every day we are apart an angel loses a wing.",
		"I love you more than Tony loved Elvira.",
		"Would you kiss me if I wear the hat?",
		"Where've you been? It's 10:00, honey, I'm starving!",
		"I like you better than better.",
		"When I look at you the ice melts in my drink.",
		"Our love will last longer than a cell phone contract.",
		"You are the cheese on my pepperoni pizza.",
		"Roses are red, violets are blue, Sparty is awesome, and so are you.",
		"When I saw you had ears, I knew you would be mine.",
		"If I was in one of those movies, I would saw off a foot for you.",
		"Love means never having to say that love means never having to say you're sorry.",
		"I love you so much it's creepy sometimes.",
		"I dream every day of your beautiful <insert color here> eyes.",
		"I will stand by you even when you smell really bad.",
		"I am the minion to your villianry.",
		"Together we are like Luke and Leia, before they found out they are brother and sister and it got creepy.",
		"You make me sing like a caged bird.",
		"You are my Neo in the matrix of life.",
		"We are like Norman and Marion, except for the ones in Psycho.",
		"You had me at hello.",
		"I would go to sea and fight Jaws with some really annoying people if you asked me to.",
		"You are my monolyth.",
		"You'll always be a T1000 model to my lowly T800.",
		"I would chop off the black knights arm just for you.",
		"Our love will survive, even after I've been turned into a newt.",
		"My broken heart is only a flesh wound.",
		"I would walk the desert while the Lawrence of Arabia soundtrack loudly plays if you asked.",
		"Let us grow old together as prisoners on Devil's island until we can escape on bags of coconuts.",
		"Let me be the Muriel to your Macon, but can we please leave Sarah out of this?",
		"My face in thine eye, thine in mine appears, and true plain hearts do in three faces rest.",
		"You have a face like Vulnavia, at least before the acid messed it up.",
		"Is this real life?",
		"I wish you were a Cylon so there could be even more copies of you out there.",
		"I will make you an offer you can't refuse."
	};
	char temp[200];
	temp[199] = '\0';
	
	int i;
	int numLines = sizeof(lines) / sizeof(const char *);
	int lineLength = 0;
	
	int *indices = calloc(numLines, sizeof(int));
	for(i=0; i<numLines;  i++) 
	{
		indices[i] = i;
	}
	
	/*
	 * Randomize
	 */
	for(i=0; i<numLines-1; i++) 
	{
		int swap = i + (rand() % (numLines - i - 1)) + 1;
		int t = indices[i];
		indices[i] = indices[swap];
		indices[swap] = t;
	}
	
	for(i=0; i<cnt;  i++)
	{
		strncpy(temp, lines[indices[i]], sizeof(temp)-1);
		char *word = strtok(temp, " ");
		while(word != NULL)
		{
			printf("%s ", word);
			lineLength += strlen(word) + 1;
			if(lineLength > 60)
			{
				printf("\n");
				lineLength = 0;
			}
			
			word = strtok(NULL, " ");
		}
		
	}
	
	
	
	free(indices);
}

