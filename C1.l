%{ 
  #include<stdio.h> 
  #include "C1.tab.h" 
  void yyerror(char *);
%} 

%option noyywrap

/* Rule Section */
%% 

\n  {return FINLINEA;}
[[:blank:]] ;
.                     yyerror("Unknown character");

%%