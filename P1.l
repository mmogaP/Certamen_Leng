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
LETRA [a-z]
NOMBRE {LETRA}+
ARCO {GUION}+{PUNTERO}
NUM [1-9]
PLACE {P}+{NUM}
TRANS {T}+{NUM}

/* Rule Section */
%% 
{NUM}	{ yylval.c = atoi(yytext); return NUM; }
{NOMBRE} {yylval.strVal= strdup (yytext); return NOMBRE; }
{ARCO} {yylval.strVal= strdup (yytext); return ARCO; }
{PLACE} {yylval.strVal= strdup (yytext); return PLACE; }
{TRANS} {yylval.strVal= strdup (yytext); return TRANS; }
"("             {return PAR;}
")"             {return PARC;}
"["             {return COR;}
"]"             {return CORC;}
","             {return COMA;}
"INSTRUCCIONES" {return INST;}
"MOSTRAR"       {return MOSTRAR;}
"ELEMENTOS"     {return ELEMENTOS;}
"RED"           {return RED;}
"E/M"           {return EM;}
"P/C"           {return PC;}
" "             {return ESPACIO;}
"CAMINO"        {return CAMINO;}
"VISTA"         {return VISTA;}         
\n  {return FINLINEA;}
[[:blank:]] ;
.                     yyerror("Unknown character");

%%