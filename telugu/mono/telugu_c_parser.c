// TELUGU parser
// J Vinay Babu - cs12b012

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <wchar.h>
#include <locale.h>
void remove_trail_space(char* str){
    int len = strlen(str);
    if(str[len-1]==' ' ) str[len-1] = '\0';
    return ;
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
char* dec2hex( int n){
    char* out = (char*)malloc(sizeof(char)*100);
    sprintf(out,"%X",n);
    return out;
}
char* syllabify(wchar_t telugu_word[]){
    char* syllabified_word;
    int i,curr_index=0;
    int length = wcslen(telugu_word);
    syllabified_word = (char*)malloc(sizeof(char)*200);
    syllabified_word[0] = '\0';
    for(i=0;i<length;i++){
        int curr_val = telugu_word[i];
        // vowel check
        if(curr_val > hex2dec("C04") && curr_val < hex2dec("C15")){
            strcat(syllabified_word,dec2hex(curr_val));
            strcat(syllabified_word," "); 
        }
        // consonant check
        else if(curr_val > hex2dec("C14") && curr_val < hex2dec("C3A")){
            // virama check
            if(telugu_word[i+1]== hex2dec("C4D")){
                remove_trail_space(syllabified_word);
                strcat(syllabified_word,dec2hex(curr_val));
            }
            else if( (telugu_word[i+1]>=hex2dec("C3E")) && (telugu_word[i+1]<hex2dec("C4E")) ){
                strcat(syllabified_word,dec2hex(curr_val));
             
            }
            else{
                 strcat(syllabified_word,dec2hex(curr_val));
                 strcat(syllabified_word," "); 
            }
        }
        else if(curr_val >= hex2dec("C3E") && curr_val < hex2dec("C55")){
        
            if(i==1&& curr_val == hex2dec("C4D") || telugu_word[i+1]== hex2dec("C4D") ){
                strcat(syllabified_word,dec2hex(curr_val));
            }
            else {
                if(!(telugu_word[i-1]> hex2dec("C14") || telugu_word[i-1] < hex2dec("C3A"))){
                    remove_trail_space(syllabified_word);
                    strcat(syllabified_word,dec2hex(curr_val));
                }
                else{
                    strcat(syllabified_word,dec2hex(curr_val));
                    strcat(syllabified_word," "); 
                }
            }
        
        }
        else if(curr_val > hex2dec("C00") || curr_val < hex2dec("C04")){
                remove_trail_space(syllabified_word);        
                strcat(syllabified_word,dec2hex(curr_val));
                strcat(syllabified_word," ");                 
        }
    }
    return syllabified_word;
}

static int utf82unicode_tel(short int z, short int y,short int x){
    int unicode=0;
	unicode = (z-224)*4096 + (y-128)*64 + (x-128);
	return unicode;
}



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
/************************ MAIN ******************************************/
int main(){
    wchar_t telugu_word[100];
    int i,len;
    setlocale(LC_ALL, "");
    wscanf(L"%ls",telugu_word);
    len = wcslen(telugu_word);
    wprintf(L"you entered: %ls   of length %d\n",telugu_word,len);
    wprintf(L"%s\n",syllabify(telugu_word));
    
    
 
    return 0;
}
