#ifndef TREE_H_
#define TREE_H_
#include <wchar.h>

typedef struct tree_el {
   char* eng;
   wchar_t lan;
   struct tree_el * right, * left;
} node;

void insert(node ** tree, node * item); 
void printout(node * tree); 

char* search(node * tree,wchar_t let);

char* convert_to_eng(wchar_t* word,node* tree);
#endif
