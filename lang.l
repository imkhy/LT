%{
#include<stdlib.h>
#include "lang.tab.h"
void yyerror(char *);
%}


%%
[0-9]+ { yylval.intValue=atoi(yytext);
		 return INTEGER;
		}

[0-9]+\.[0-9]+ { yylval.floatValue=atof(yytext);
		 return FLOAT;
		}

[a-z]   {
           yylval.val = *yytext - 'a';
           return ID;
        }
		
start|end|convert|into|show|result|inch|feet|km|am|mm|cm|nm|yard|omile|","|"=" {return *yytext;}

[\b\n] return *yytext;

[\t];
.yyerror ("invalid character");
%%

int yywrap(void){
	return 1;
}