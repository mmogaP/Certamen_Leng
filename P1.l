%{ 
  #include<stdio.h> 
  #include "P1.tab.h" 
  void yyerror(char *);
%}

%option noyywrap

GUION [-]
PUNTERO [>]
P [P]
T [T]
ARCO {GUION}+{PUNTERO}
NUM [0-9]
PLACE {P}+{NUM}
TRANS {T}+{NUM}

/* Rule Section */
%% 
{NUM}	{ yylval.c = atoi(yytext); return NUM; }
{ARCO} {yylval.strVal= strdup (yytext); return ARCO; }
{PLACE} {yylval.strVal= strdup (yytext); return PLACE; }
{TRANS} {yylval.strVal= strdup (yytext); return TRANS; }
"("       {return PAR;}
")"       {return PARC;}
"["       {return COR;}
"]"       {return CORC;}
","       {return COMA;}            
\n  {return FINLINEA;}
[[:blank:]] ;
.                     yyerror("Unknown character");

%%