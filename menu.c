#include <stdio.h>
#include <stdlib.h>

int main(void)
{
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
