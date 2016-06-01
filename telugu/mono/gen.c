/***************************************
    Telugu parser ggwp by vinay
****************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static short int with_halant[100];
static short int syllables[10][10];
static short int phones[20][20];
static short int syllabified_word[100];
static short int phonified_word[100];
static short int unicode_string[100];
static char syll_list[10][100];
static char phone_list[20][100];
static short int tokenized_array[100];
static char syllphone_finarray[100][100];
static short int syll_length[10];
static short int phone_length[10];
static int num_unicode=0;
static char temp_map[10][10];
static char phoneset_map[10][10];
typedef struct _node{
  int value;
  char *text;
}node;
#define HASHSIZE 100
static node* hashtab[HASHSIZE];

int power(int a,int b){
    //returns a power b
    int i;
    int ans=1;
    for (i = 0; i < b; i += 1)
    {
        ans = ans*a;
    }
    return ans;
}
int hex2dec( char in[]){
    char* out = (char*)malloc(strlen(in)*2);
    int ans=0,flag=1,i;
    int len = strlen(in);
    for (i = 0; i < len; i ++)
    {
        char c = in[i];
        if(c>='0' && c<= '9'){
            ans+= (c-'0')*power(16,len-i-1);
        }else{
            ans+= (10+c-'A')*power(16,len-i-1);
        }
    }
    
    return ans;
}
static int syllabify(short int *telugu_word, int num_unicode){
	int k=-1;
	int i=0;
    for(i=0;i<num_unicode;i++){
        short int curr_val = telugu_word[i];
        // vowel check
        if(curr_val > hex2dec("C04") && curr_val < hex2dec("C15")){
             
            syllabified_word[++k] = telugu_word[i];
            syllabified_word[++k] = 0;
        }
        // consonant check
        else if(curr_val > hex2dec("C14") && curr_val < hex2dec("C3A")){
            // virama check
            if(telugu_word[i+1]== hex2dec("C4D")){
                syllabified_word[k] = telugu_word[i];
            }
            else if( (telugu_word[i+1]>=hex2dec("C3E")) && (telugu_word[i+1]<hex2dec("C4E")) ){
                syllabified_word[++k] = telugu_word[i];
             
            }
            else{
                syllabified_word[++k] = telugu_word[i];
                syllabified_word[++k] = 0; 
            }
        }
        else if(curr_val >= hex2dec("C3E") && curr_val < hex2dec("C55")){
        
            if(i==1&& curr_val == hex2dec("C4D") || telugu_word[i+1]== hex2dec("C4D") ){
                syllabified_word[++k] = telugu_word[i];
            }
            else {
                if(!(telugu_word[i-1]> hex2dec("C14") || telugu_word[i-1] < hex2dec("C3A"))){
                    syllabified_word[k] = telugu_word[i];
                }
                else{
                    syllabified_word[++k] = telugu_word[i];
                    syllabified_word[++k] = 0;                  
                }
            }
        
        }
        else if(curr_val > hex2dec("C00") || curr_val < hex2dec("C04")){
                syllabified_word[k] = telugu_word[i];
                syllabified_word[++k] = 0;                  
        }
    }
	num_unicode=k;
	return num_unicode;
}
void printArray(short int* arr, int size){
    int i;
    for(i=0;i<size;i++){
        printf("%hd\n",arr[i]);
    }
}
int createHash(){
    static const char filename[] = "unique.txt";    // change it later
    FILE* fp = fopen(filename,"r");
    char buffer[100];
    int n,v=0,i;
    char temp[100];
    char* first_half,*second_half;
    for(i=0;i<HASHSIZE;i++){
        hashtab[i] = NULL;
    }
    
    while( fgets(buffer,sizeof(buffer),fp)!=NULL){
        int len = strlen(buffer);
        static const char filename[] = "unique.txt";
        buffer[len-1] = '\0';
        strcpy(temp, buffer);
        first_half = strtok(temp," ");
        n = atoi(first_half);
        second_half = strtok(NULL, " ");
        node* t = (node*)malloc(sizeof(node));
        t->value = n;
        t->text = strdup(second_half);
        hashtab[v++] = t;
    }
    return v;
}
void printHashTable(){
    int i;
    for(i=0;i<HASHSIZE;i++){
        node *n = hashtab[i];
        if(n==NULL){}
        else{
            printf("%d %s\n",n->value,n->text);            
        }
    }
}
char* get(int n){
    int i;
    for(i=0;i<HASHSIZE;i++){
        node* t = hashtab[i];
        if(t->value == n)
            return t->text;
    }
    return NULL;
}
void cleanup(){
    int i;
    for(i=0;i<HASHSIZE;i++){
        node*t = hashtab[i];
        if(t!=NULL){
            free(t->text);
            free(t);
        }
    }
}
static int phonify_hin(int syll_length, short int to_phonify[], int jh){
    int i ;
    short int curr,next;
    for(i=0; i<syll_length; i++){
         curr = to_phonify[i];
         next = to_phonify[i+1];
         
		 char *tttt=get(curr); // refer hash table
		 /*
		 printf("%s\n",tttt);
		 printf("curr=%d, next=%d jh=%d \n",curr,next,jh);
         */
         // current is virama/mei ignored
         if(curr == 3149){
         
         }
         else {
            //if current is consonant
            if(curr>= 3093 && curr<= 3129 ){
                //add exception later
                //next is either matra or mei just output as it is
                if((next==3149) || (next >=3124  && next <= 3148) ){
                    strcpy(syllphone_finarray[jh],tttt);
				    jh++;
                }else {
                // next must be vowel or consonant
                    strcpy(syllphone_finarray[jh],tttt);
				    jh++;   
				    strcpy(syllphone_finarray[jh],"a");
				    jh++;              
                }
                
            }else{
            // current is vowel or matra output as it is 
                strcpy(syllphone_finarray[jh],tttt);
			    jh++;
            }
         }
         
    }
    return jh;
}
/**************************** MAIN *******************************/
int main(){
    short int tel[] = {3125,3135,3112,3119,3149}; //vinay in telugu
    int size = sizeof(tel)/sizeof(short int);
    
    int i,count_phones;
    int no_of_sylls = 0 ;
    int m=0,n,jh;
    // init 
    for(i=0;i<size;i++){
        unicode_string[i] = tel[i];
    }
    //printArray(unicode_string,size);
    num_unicode = syllabify(unicode_string,size);
    //printArray(syllabified_word,size);
    printf("num_unicode= %d\n",num_unicode);
    
	for (m = 0; m < num_unicode ; m++)
	{ 
		syllables[no_of_sylls][syll_length[no_of_sylls]]= syllabified_word[m];
		syll_length[no_of_sylls]++;
		if (syllabified_word[m+1] == 0)
		{	m++;
			no_of_sylls++;
		}
	}
	n = createHash();
	//printf("No of elements= %d\n",n);
	//printHashTable();
	
	printf("no_of_sylls: %d\n",no_of_sylls);
	jh = 0;
	for ( m = 0; m < no_of_sylls; m++)
	{
		count_phones=phonify_hin(syll_length[m], syllables[m], jh);
		jh = count_phones;
	}
	printf("jh: %d\n",jh);
	for( i=0; i<jh; i++){
	    printf("%s\n",syllphone_finarray[i]);
	}
	
	
    
    cleanup();
}
