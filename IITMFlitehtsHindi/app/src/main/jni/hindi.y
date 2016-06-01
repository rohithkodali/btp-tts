%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h>
#include <wchar.h>
#include "utf8.c"
#include "tree.h"
#include "utf8.h"

// global unicode limit

//

void yyerror(const char * str){
	fprintf(stderr,"Error: %s\n",str);
}

int yywrap(){
	return 1;
}

wchar_t* append_char(wchar_t* string,wchar_t ch){
    int len = wcslen(string);
    wchar_t* ret = (wchar_t*)( malloc(sizeof(wchar_t)*len+sizeof(ch)+1));
    int i = 0;
    for(i=0;i<len;i++)
        ret[i] = string[i];
    ret[i] = ch;
    ret[i+1] = '\0';
    return ret;
}

void print_syllables(wchar_t* string){
    int i = 0;
    while( string[i] != '\0' ){
        if ( string[i] == L' ')
            printf("\n");
        else
            printf("%lc",string[i]);
        i++;
    }
}


char * normalizeInput(char * input)
{
	char * output,output1;
	output=input;
    //strstr(new_string, needle) != NULL
    //printf("Str :%s\n",strstr(output, "ऩ") );
    if(strstr(output, "ऩ") != NULL)output =utf8_replace_all("ऩ","ऩ",output);
	if(strstr(output, "ऱ") != NULL)output =utf8_replace_all("ऱ","ऱ",output);
	if(strstr(output, "क़") != NULL)output =utf8_replace_all("क़","क़",output);
	if(strstr(output, "ख़") != NULL)output =utf8_replace_all("ख़","ख़",output);
	if(strstr(output, "ग़") != NULL)output =utf8_replace_all("ग़","ग़",output);
	if(strstr(output, "ज़") != NULL)output =utf8_replace_all("ज़","ज़",output);
	if(strstr(output, "ड़") != NULL)output =utf8_replace_all("ड़","ड़",output);
	if(strstr(output, "ढ़") != NULL)output =utf8_replace_all("ढ़","ढ़",output);
	if(strstr(output, "फ़") != NULL)output =utf8_replace_all("फ़","फ़",output);
	if(strstr(output, "य़") != NULL)output =utf8_replace_all("य़","य़",output);
	if(strstr(output, "ऴ") != NULL)output =utf8_replace_all("ऴ","ऴ",output);
	return	output;
}

node* root = NULL;

main(int argc,char** argv){
        setlocale(LC_ALL, "");
	node * curr;
	//printf("%s\t",argv[1]);
	root = NULL;
	wint_t c;
	FILE* file = fopen("common","r");
	
	char string[5];
	wchar_t alpha;
	int i = 0;
	while( (c = fgetwc(file)) != WEOF){
	     if((int)c >= 97 && (int)c <= 122){
	     	string[i] = (char)c;
	     	i = i + 1;
	     }	
	     else if( c == L'\n'){
	     	string[i] = '\0';
	   		curr = (node *)malloc(sizeof(node));
	   		curr->left = curr->right = NULL;
	   		curr->lan = alpha;
	     	curr->eng = (char*)malloc(sizeof(char)*i);
	     	strcpy(curr->eng,string);
	   		insert(&root, curr);
	     	i = 0;
	     }
	     else if(c == L'\t')
	     	continue;
	     else
	     	alpha = c;
	}
	fclose(file);
	//split to words -clean the file
	FILE* output;
	output = fopen("wordpronunciation","w");
	//fprintf(output,"%s","(set! wordstruct '(");
	fclose(output);
	char * str;
	str = argv[1];
    //printf("%s\n", str);
	//utf8_validate(str);
	char tempWord[100],temp2[100];
	char * pch;
	pch = strtok(str," _");
	while (pch != NULL)
	{	
		strcpy(tempWord,pch);
        //printf("\ntempWord:%s\n",pch );
		char * tempWord1 = normalizeInput(tempWord);
        //printf("\ntempWord1:%s\n",tempWord1 );
		yy_scan_string(tempWord1);
        //printf("\n%s\n",tempWord1);
		yyparse();
		pch = strtok(0," _");
	}

	output = fopen("wordpronunciation","a+");
	//fprintf(output,"%s","))\n");
        fclose(output); 
}
%}

%union {
	char* strval;
}

%type <strval> words syltoken
%token <strval> space fullvowel kaki conjsyll2 conjsyll1 nukchan yarule consonant vowel halant matra

%%

sentence :  words {
            wchar_t* str;
            wchar_t* str1;
	    wchar_t* string;
            wchar_t* new_string;
            wchar_t* ptr;
            setlocale(LC_ALL, "");
            //printf("fvrvrgfv%s\n", $1);
            str1 = (wchar_t*)(malloc(sizeof(wchar_t)*strlen($1)));
            mbstowcs(str1,$1,strlen($1)+1);
            int len = wcslen(str1);
            
	    //printf("\nstring is : %ls\n",str1);
	    str = (wchar_t*)(malloc(sizeof(wchar_t)*wcslen(str1)+1));
	    int j;
	    int i=0;
	    for(j=0;j<len;j++){
            
    		if( (str1[j] == L'h') && (((int)str1[j-1] >= 2325 && (int)str1[j-1] <= 2361) || ((int)str1[j-1] >= 2392 && (int)str1[j-1] <= 2399 )) && ( (int)str1[j-2] == 2381 ) &&  (((int)str1[j-3] >= 2325 && (int)str1[j-3] <= 2361) || ((int)str1[j-3] >= 2392 && (int)str1[j-3] <= 2399 )) && ( j+1 != len) ){
    			continue;					
    		}
    		else{
    			if ( (str1[j] == L'h') && (((int)str1[j-1] >= 2325 && (int)str1[j-1] <= 2361) || ((int)str1[j-1] >= 2392 && (int)str1[j-1] <= 2399 )) && ( (int)str1[j-2] == 2381 ) &&  (((int)str1[j-3] >= 2325 && (int)str1[j-3] <= 2361) || ((int)str1[j-3] >= 2392 && (int)str1[j-3] <= 2399 )) && ( j+1 == len) ){
    				if (((int)str1[j-1] > 2350 && (int)str1[j-1] < 2358))
    					continue;
    				else{
    					str[i] = str1[j];
    					i++;
    				}
    			}
    			else if ( (str1[j] == L'h') && ( (int) str1[j-1] == 2351 || (int) str1[j-1] == 2399 ) && ((int)str1[j-2] > 2366 && (int)str1[j-2] < 2373)){
    				continue;			
    			}
    			else if ( (str1[j] == L'h') && ((int)str1[j+2] == 2381) && (((int)str1[j-1] >= 2325 && (int)str1[j-1] <= 2361) || ((int)str1[j-1] >= 2392 && (int)str1[j-1] <= 2399 ) ) && (((int)str1[j+3] >= 2325 && (int)str1[j+3] <= 2361) || ((int)str1[j-1] >= 2392 && (int)str1[j-1] >= 2399)) ) 					continue;
    			else{
    				str[i] = str1[j];
    				i++;
    			}
    		}
            //printf(" %d \t %ls\n", (int)str1[j],str);
	    }
	    str[i] = '\0';

        //printf("%ls\n",str);
            for(j=len-1;j>=0;j--){
                if ( (int)str[j] == L'h' ){
                    if ( (j != len - 1) && ((int)str[j+2] == L'h') ){
                        str[j] = L' ';
                    }
                }
            }
	    
            string = (wchar_t*)(malloc(sizeof(wchar_t)*wcslen(str)));
            new_string = (wchar_t*)malloc(2*sizeof(wchar_t)*wcslen(str)); 
            len = wcslen(str);
            for(j=0;j<len;j++){
		if (str[j] == L'h')
			str[j] = L'्';	    	
	    }

            j = 0;
            for(i=0;i<len;i++){
                if ( (str[i] != L' ') ){
                    string[j] = str[i];
                    j++;
                }
                else
                    continue;
            }
            string[j] = '\0';

            new_string = L"";
            
            for(i=0;i<wcslen(string);i++){
                int unicode_value = (int)string[i];
                int temp_len = wcslen(new_string);

                //printf(" %ls -> %d ;\n",new_string, (int)string[i]);
            
                if (unicode_value >= 2308 && unicode_value <= 2324){
                    new_string = append_char(new_string,string[i]);
                    new_string = append_char(new_string,L' ');
                }
            
                else if( (unicode_value > 2324 && unicode_value <= 2364) || ( unicode_value >= 2392 && unicode_value < 2490)){
                    if( (int)string[i+1] == 2364 && (int)string[i+2] == 2381 ){
                        if( new_string[temp_len-1] == L' ' )
                            new_string[temp_len-1] = string[i];
                    }
                    else if ( (int)string[i+1] >= 2364 && (int)string[i+1] < 2381 ){
                         new_string = append_char(new_string,string[i]);
                    }
                    else if ( ((int)string[i+1]) == 2381 ){
                        if( new_string[temp_len-1] == L' ' )
                            new_string[temp_len-1] = string[i];
			else{
				new_string = append_char(new_string,string[i]);
			}
                    }
                    else{
                        new_string = append_char(new_string,string[i]);
                        new_string = append_char(new_string,L' ');
                    }
                }
            
                else if( unicode_value >= 2364 && unicode_value <= 2381 ){
                    if( i == 1 && unicode_value == 2381){
                        new_string = append_char(new_string,string[i]);
                    }
                    else{
                        if ( !( ( (int)string[i-1] > 2324 && (int)string[i-1] <= 2364) || ( (int)string[i-1] >= 2392 && (int)string[i-1] < 2490))){
                         if( new_string[temp_len-1] == L' ' )
                            new_string[temp_len-1] = string[i];   
                        }
                        else{
                            new_string = append_char(new_string,string[i]);
                            new_string = append_char(new_string,L' ');
                        }
                    }
                }
            
                else if ( unicode_value > 2305 || unicode_value <= 2309 ){
                    if( new_string[temp_len-1] == L' ' ){                            
                            new_string[temp_len-1] = string[i];
			    new_string = append_char(new_string,L' ');
                    }
			else{
				new_string = append_char(new_string,string[i]);
				new_string = append_char(new_string,L' ');
			}
                }
            }
		FILE* output;
		output = fopen("wordpronunciation","a+");
	   	fprintf(output,"%s",convert_to_eng(new_string,root));
		fclose(output);
	   
}

		 ;
		 
words : syltoken {  			int length = strlen($1);
					int j = 0;
					if ( $1[length -1] == 'h'){
						char str[length];
						for(j=0;j<length-1;j++)
							str[j]=$1[j];
						str[j]='\0';
						strcpy($1,str);					
					}
					$$ = $1; }
      | words syltoken { char* str = malloc (strlen($1)+strlen($2)+1) ; sprintf( str,"%s%s",$1,$2);$$=str;}
	  ;

syltoken : fullvowel { $$ = $1; }
	 | kaki { $$ = $1; }
	 | conjsyll2 { $$ = $1; }
	 | conjsyll1 { $$ = $1; }
	 | nukchan { $$ = $1; }
	 | yarule { $$ = $1; }
	 | consonant { char* str = malloc(strlen($1)+strlen("्")+1); sprintf( str,"%sh",$1 );$$=str; } 
	 | vowel { $$ = $1; }
	 | halant { $$ = $1; }
	 | matra { $$ = $1; }
	 ;
