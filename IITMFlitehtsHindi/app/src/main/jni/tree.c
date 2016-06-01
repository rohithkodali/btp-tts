#include "tree.h"
#include<stdlib.h>
#include<stdio.h>
#include<locale.h>
#include<wchar.h>
#include<string.h>


void insert(node ** tree, node * item) {
   if(!(*tree)) {
      *tree = item;
      return;
   }

   if(item->lan < (*tree)->lan)
      insert(&(*tree)->left, item);
   else if(item->lan >(*tree)->lan)
      insert(&(*tree)->right, item);
}

void printout(node * tree) {
   if(tree->left) printout(tree->left);
   printf("%d -> %s\n",tree->lan,tree->eng);
   if(tree->right) printout(tree->right);
}

char* search(node * tree,wchar_t let) {
	if(!(tree))
      		return NULL;	
	else if(let < tree->lan)
      		search(tree->left, let);
   	else if(let > tree->lan)
      		search(tree->right, let);
	else
		return tree->eng;
}

char* convert_to_eng(wchar_t* word,node* tree) {	
	//printf("%ls\n", word);
	int j = 0,i = 0,k=0;
	int len = wcslen(word);
	char start[] = "";

	int first_let,last_let;
	for(i=0;i<len;i++){
		if (word[i] != L' '){
			first_let = i;
			break;	
		}
		else
			continue;	
	}
	
	for(i=len-1;i>=0;i--){
		if (word[i] != L' '){
			last_let = i;
			break;	
		}
		else
			continue;	
	}

	char* return_str = (char *)malloc(10*sizeof(char)*(last_let-first_let+1));
	strcpy(return_str,start);
	len = wcslen(word);
	
	for(j=first_let;j<=last_let;j++){
		char* temp = search(tree,word[j]);
		if( word[j] == L' '){
			strcat(return_str,"");
		}
		else{
			if( temp != NULL){		
				int l = strlen(temp);
				if ( word[j+1] == L'्' ){
					if ( j == first_let ){
                                strcat(return_str,"");
                                }
					j++;			
				}
				if ( j == first_let ){
				strcat(return_str,"");			
				}
				strcat(return_str,"*");
				strcat(return_str,temp);
				//strcat(return_str,"*");
				if ( ((word[j] >=2325 && word[j]<=2361) || (word[j] >=2392 && word[j]<=2399)) && (word[j+1] != L'्' && (word[j+1]<2366 || word[j+1]>2380))){
					strcat(return_str,"*a");			
				}
				
				if( j == last_let )
					strcat(return_str,""); 	
			}
		}
	}
	if (return_str[0] == '*') return_str++;
	if(strstr(return_str, "**") != NULL)return_str =utf8_replace_all("**","*",return_str);
	//strcat(return_str,"))\n");
	return return_str;
}

/*
void main() {
   node * curr, * root;
   setlocale(LC_ALL, "");

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
		//printf("%lc->%s\n",(wchar_t)alpha,string);
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
   //printout(root);


   wchar_t word[100] = L"अं गज्";
   printf("%s\n",convert_to_eng(word,root));	
}*/
