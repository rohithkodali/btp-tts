LEX= flex
YACC= bison -d

CC = gcc
FLAGS= -g -lfl -O3 -Wall

all: hindi 

hindi.tab.c hindi.tab.h: hindi.y
	$(YACC) hindi.y
	
hinlex.yy.c: hindi.l hindi.tab.h
	$(LEX) -o $@ hindi.l

hindi: hinlex.yy.c hindi.tab.c hindi.tab.h tree.c
	$(CC) $? $(FLAGS) -o $@-parser   

clean: 
	rm *.tab.* *lex.yy.c *-parser 
