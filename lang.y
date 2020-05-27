%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int yylex(void);
void yyerror(char *);
extern FILE *yyin;
float sys[26];
int bef[9]={0,0,0,0,0,0,0,0,0};
int ru[9]={0,0,0,0,0,0,0,0,0};
float ans=0;
int i;
int ruid=-1;
int befid=-1;
%}
%union
{
    int intValue;
    float floatValue;
    char val;
}
%token <intValue> INTEGER
%token <floatValue> FLOAT
%token <val> ID

%%

program:start

start:'start' '\n' statement 'end'

statement: assignment '\n' expression '\n' display
		|statement assignment '\n' expression '\n' display
		   
assignment: givenunit ID '=' INTEGER{sys[$2]=$4;}
			|givenunit ID '=' FLOAT{sys[$2]=$4;}
			;
		  
givenunit : 'inch' {bef[0]=1;}
		|'feet'{bef[1]=1;}
		|'km'{bef[2]=1;}
		|'am'{bef[3]=1;}
		|'mm'{bef[4]=1;}
		|'cm'{bef[5]=1;}
		|'nm'{bef[6]=1;}
		|'yard'{bef[7]=1;}
		|'omile'{bef[8]=1;}

expression: 'convert' ID 'into' requnit {ans=sys[$2];
for(i=0;i<9;i++)
{
	if(bef[i]!=0)
	{	befid=i;
		break;

	}
}
for(i=0;i<9;i++)
{
	if(ru[i]!=0)
	{	ruid=i;
		break; 
	}
} 
if((befid==0) && (ruid==1))
{
	ans=(ans/12);	
}
else if((befid==1) && (ruid==0))
{
	ans=(ans*12);	
}
else if((befid==2) && (ruid==3))
{
	ans=(ans*1000);	
}
else if((befid==3) && (ruid==2))
{
	ans=(ans/1000);	
}
else if((befid==5) && (ruid==4))
{
	ans=(ans*10);	
}
else if((befid==4) && (ruid==5))
{
	ans=(ans/10);	
}
else if((befid==7) && (ruid==8))
{
	ans=(ans/1760);	
}
else if((befid==8) && (ruid==7))
{
	ans=(ans*1760);	
}
}
;

requnit : 'inch' {ru[0]=1;}
		|'feet' {ru[1]=1;}
		|'km' {ru[2]=1;}
		|'am' {ru[3]=1;}
		|'mm' {ru[4]=1;}
		|'cm' {ru[5]=1;}
		|'nm' {ru[6]=1;}
		|'yard' {ru[7]=1;}
		|'omile' {ru[8]=1;}


display: 'show' 'result' '\n' {printf("%f\n",ans);}
		;
	  
%%


void yyerror(char *s){
	fprintf(stderr,"%s\n",s);
}

int main(int argc,char **argv){
if(argc >1)
{
	yyin=fopen(argv[1],"r");
}
else{
	printf("Enter file name");
	return 1;
}
yyparse();
return 0;
}