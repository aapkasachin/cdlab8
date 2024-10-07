%{
#include "y.tab.h"
#include "stdlib.h"
#include "string.h"
%}

digit [0-9]
id [_a-zA-Z][_a-zA-Z0-9]*
String \"[^"]*\"
ws [ \t\n]

%%
"int" {return INT;}
"main" {return MAIN;}
"printf" {return PRINTF;}
{digit}+ {yylval.num=atoi(yytext);return NUM;}
{id}  {yylval.id=strdup(yytext);return ID;}
{String} {yylval.str=strdup(yytext);return STRING;}
"(" {return LPAREN;}
")" {return RPAREN;}
"{" {return LF;}
"}" {return RF;}
"+" {return ADD;}
"=" {return ASSIGN;}
";" {return SEMI;}
"," {return COMMA;}
{ws} { }
. { }
%%

int yywrap()
{
  return 0;
}
