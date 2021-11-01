%{ 
   #include<stdio.h> 
   #include<string.h>
   int yylex();
   void yyerror(char *s);

   int CordenadaX = 0;
   int CordenadaY = 0;
   
   void CalcularCoordenadas(char *s){
        int opc = 0, num1 = 0, num2 = 0;
    do{
        system("cls");
        printf("Menu de opciones");
        printf("1. Ingrese los valores\n");\*cambiar para lo que necesito*\
        printf("2. Ingreso de suma\n");
        printf("3. Ingreso de resta\n");
        printf("4. Salir\n\n");
        printf("Opcion a escoger: ");
        scanf("%d", &opc);
        switch(opc){
            case 1:
                system("cls");
                printf("Ingrese el primer valor: ");
                scanf("%d",&num1);
                printf("Ingrese el segundo valor");
                scanf("%d",&num2);
                break;
            case 2:
                system("cls");
                printf("La suma es %d + %d es: %d", num1, num2, num1+num2);
                getch();
                break;
            case 3:
                system("cls");
                printf("La resta de %d - %d es: %d", num1, num2, num1-num2);
                getch();
                break;
            case 4:
                break;
            default:
                system("cls");
                printf("La opcion que ingreso es incorrecta");
                getch();
                break;
        }
    }while(opc != 4);
    return 0;
   }   
   void coordenadas(){
      printf("\nCoordenadas: (%d,%d)\n", CordenadaX,CordenadaY);
      CordenadaX = 0;
      CordenadaY = 0;
   }
%} 

%union {
    char *strVal;
    char charVal;
}

/* TOKENS */
%token FINLINEA
%token <strVal>PALABRA
%token <strVal>EVALUAR

/* Acciones de produccion */
%% 
   INICIO: INICIO Expr
      | Expr
   ;

   Expr: FIN
      | Expr PALABRA {CalcularCoordenadas($2);}
      | PALABRA {CalcularCoordenadas($1);}
   ;

   FIN: FINLINEA {coordenadas();}
   ;
%% 

void yyerror(char *s) { 
   printf("\n%s\n", s); 
}

int yywrap(){
    return 1;
}

int main(){
    return (yyparse());
}