%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
extern int yylineno;
void yyerror(char *s)
{
    fprintf(stderr,"%d \t %s",yylineno,s);
    exit(0);
}
%}

%union
{
   char *str;
   char *id;
   int num;
}

%token<id> ID
%token<str> STRING
%token<num> NUM
%token INT MAIN PRINTF LPAREN RPAREN LF RF ADD ASSIGN COMMA SEMI
%start program
%%
program:INT MAIN LPAREN RPAREN LF stmt_lists RF
        {
            printf(".data\n");
            printf(" .LC0: .String \"Sum %%d\" \n");
            printf(".text\n");
            printf(".globl main\n");
            printf("main: \n");
        }
        ;
stmt_lists:stmt
           | stmt_lists stmt
           ;
stmt:INT ID ASSIGN NUM SEMI {printf("movl $%d, %s\n",$4,$2);}
    |ID ASSIGN ID ADD ID SEMI
     {
        printf("movl %s,%%eax\n",$3);
        printf("addl %s,%%eax\n",$5);
        printf("movl %%eax, %s\n",$1);
     }
    |
    PRINTF LPAREN STRING COMMA ID RPAREN SEMI
    {
       printf("movl %s,%%edi\n",$5);
       printf("movl $LC0,%%rsi\n");
       printf("call printf\n");
    }
    ;
%%

int main()
{
   printf("assembly code is :\n");
   yyparse();
   printf("executed!!");
   return 0;
}
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
