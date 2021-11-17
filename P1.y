%{ 
   #include<stdio.h> 
   #include<stdlib.h> 
   #include<string.h>
   #include<stdbool.h>
   int yylex();
   void yyerror(char *s);
   

   typedef struct place{
      char *nombre;
      char *nombreC;
      int token;
      struct ArcoT* next;          
   }place;
   typedef struct trans{
      char *nombre;
      char *nombreC;
      struct ArcoP* next;            
   }trans;
   typedef struct ArcoP{
      int peso;
      place* P;  
      struct ArcoP* next;       
   }ArcoP;
   typedef struct ArcoT{
      int peso;
      trans* T;
      struct ArcoT* next;           
   }ArcoT;
   typedef struct Elementos{
      trans* T;
      place* P;
      struct Elementos* next;
   }Elementos;
   typedef struct Arcos{
      ArcoP* AP;
      ArcoT* AT;
      struct Arcos* next;
   }Arcos;

   Arcos arcos;
   Elementos elementos;
   //--------------------[[[COMPROBAR]]] -------------------
   bool verificarElemento(){
      if(elementos.P== NULL && elementos.T ==NULL){
         return false;         
      }else{
         return true;
      }

   }
   bool existen(char *nombreP,char *nombreT){
      int cond1=0,cond2=0;
      Elementos* puntero;
      puntero = &elementos;
      
      if(puntero->next==NULL){         
         if(puntero->P==NULL){
            printf("No existe Place\n");
         }else{
            if(puntero->P->nombre==nombreP){
               cond1=1;
            }            
         }
      }else{         
         while(puntero!=NULL){            
            if(puntero->P!=NULL){
               
               if(puntero->P->nombre[0]==nombreP[0] && puntero->P->nombre[1]==nombreP[1]){
                  
                  cond1=1;
               }
            }else if(puntero->T!=NULL){
               
               if(puntero->T->nombre[0]==nombreT[0] && puntero->T->nombre[1]==nombreT[1]){
                  
                  cond2=1;
               }
            }
            puntero = puntero->next;
         }
      }
      if(cond1==1 && cond2==1){
         
         return true;
      }else{
         
         return false;
      }      
   }
   bool existenPlace(char *nombre1, char *nombre2){
      int cond1=0,cond2=0;
      Elementos* puntero;
      puntero = &elementos;
      
      if(puntero->next==NULL){
         return false;
      }else{
         while(puntero!=NULL){            
            if(puntero->P!=NULL){
               
               if(puntero->P->nombre[1]==nombre1[1]){
                  
                  cond1=1;
               }else if(puntero->P->nombre[1]==nombre2[1]){
                  cond2=1;
               }
            }
            puntero = puntero->next;
         }
      }
      if(cond1==1 && cond2==1){
         
         return true;
      }else{
         
         return false;
      }      
   }
   Elementos* Encontrar(char *nombre){
      Elementos* puntero;
      puntero = &elementos;
      if(nombre[0]=='P'){
         while(puntero!=NULL){
            if(puntero->P!=NULL){
               if(puntero->P->nombre[1]==nombre[1]){
                  Elementos* e = puntero;
                  return e;
               }
            }
            puntero = puntero->next;
         }
      }else if(nombre[0]=='T'){
         while(puntero!=NULL){
            if(puntero->T!=NULL){
               if(puntero->T->nombre[1]==nombre[1]){
                  Elementos* e = puntero;
                  return e;
               }
            }
            puntero = puntero->next;
         }
      }
      return NULL;
   }
   // ---------------------------------------------------------
   // ----------------[[[CREAR Y ENLAZAR]]]---------------------

   void crearTrans(char *nombreC ,char *nombre){
      Elementos* puntero;
      puntero = &elementos;
      Elementos* busqueda = Encontrar(nombre);
      if(busqueda!=NULL){         
         while(puntero->next){
            puntero = puntero->next;
         }
         Elementos* e = (Elementos *)malloc(sizeof(Elementos));
         e->T=busqueda->T; 
         puntero->next = e;
      }else{
         trans* T = (trans *)malloc(sizeof(trans));
         T->nombre=nombre; 
         T->nombreC=nombreC;  
         Elementos* e = (Elementos *)malloc(sizeof(Elementos));
         e->T=T;   
         if(elementos.next==NULL){         
            elementos.next=e;
         }else{            
            while(puntero->next){
               puntero = puntero->next;
            }
            puntero->next = e;
         }
      }
   }
   
   void crearPlace(char *nombreC ,char *nombre, int token){
      Elementos* puntero;
      puntero = &elementos;
      Elementos* busqueda = Encontrar(nombre);
      if(busqueda!=NULL){
         while(puntero->next){
            puntero = puntero->next;
         }
         Elementos* e = (Elementos *)malloc(sizeof(Elementos));
         e->P=busqueda->P; 
         puntero->next = e;
      }else{
         place* P = (place *)malloc(sizeof(place));
         P->nombre=nombre;
         P->nombreC=nombreC;
         P->token=token;
         if(nombre[1]=='1'){
            if(!verificarElemento()){
               elementos.P = P;
            }else{
               Elementos* e = (Elementos *)malloc(sizeof(Elementos));
               e->P=P;
               if(elementos.next==NULL){
                  elementos.next= e;
               }else{                  
                  while(puntero->next){
                     puntero = puntero->next;
                  }
               puntero->next = e;
               }
            }
         }else{
            Elementos* e = (Elementos *)malloc(sizeof(Elementos));
            e->P=P;
            if(elementos.next==NULL){
               elementos.next= e;
            }else{               
               while(puntero->next){
                  puntero = puntero->next;
               }
               puntero->next = e;
            }
         }
      }
   }   

   void crearArcoT(int peso,char *nombreP, char *nombreT){
      // P -> T      
      if(!existen(nombreP,nombreT)){
         printf("No es posible Conectar, algun elemento no existe.\n");
      }else{     
         int cont=0;  
         Arcos* punteroA;
         punteroA = &arcos;  
         Elementos* edP = Encontrar(nombreP);
         Elementos* edT = Encontrar(nombreT);
         ArcoT* arcT = (ArcoT *)malloc(sizeof(ArcoT));
         arcT->T=edT->T;
         arcT->peso=peso;
         if(edP->P->next==NULL){            
            edP->P->next=arcT;
            /*if(punteroA->AP==NULL && punteroA->AT==NULL){
                  punteroA->AT = arcT;
            }else{
                  while(punteroA->next){
                     punteroA = punteroA->next;
                  }
                  punteroA->next->AT = arcT;
               }  */                            
         }else{
            ArcoT* puntero;
            puntero = edP->P->next;            
            while(puntero->next){               
               if(puntero->T->nombre[1]==nombreT[1]){
                  cont+=1;
               }               
               puntero = puntero->next;               
            }
            if(cont!=0 || puntero->T->nombre[1]==nombreT[1]){
               printf("Arco no creado, ya existe!\n");
            }else{
               /*if(punteroA->AP==NULL && punteroA->AT==NULL){
                  punteroA->AT = arcT;
               }else{
                  while(punteroA->next){
                     punteroA = punteroA->next;
                  }
                  punteroA->next->AT = arcT;
               }   */                           
               puntero->next = arcT;               
            }
            
         }
      }
   }
   void crearArcoP(int peso,char *nombreP, char *nombreT){
      // T -> P
      if(!existen(nombreP,nombreT)){
         printf("No es posible Conectar, algun elemento no existe.\n");
      }else{
         int cont=0;
         Arcos* punteroA;
         punteroA = &arcos;
         Elementos* edP = Encontrar(nombreP);
         Elementos* edT = Encontrar(nombreT);
         ArcoP* arcP = (ArcoP *)malloc(sizeof(ArcoP));
         arcP->P=edP->P;
         arcP->peso=peso;
         if(edT->T->next==NULL){            
            edT->T->next=arcP;
            /*if(punteroA->AP==NULL && punteroA->AT==NULL){
                  punteroA->AP = arcP;
               }else{
                  while(punteroA->next){
                     punteroA = punteroA->next;
                  }
                  punteroA->next->AP = arcP;
               }*/                              
         }else{
            ArcoP* puntero;
            puntero = edT->T->next;
            while(puntero->next){
               if(puntero->P->nombre[1]==nombreP[1]){
                  cont+=1;
               }
               puntero = puntero->next;
            }
            if(cont!=0 || puntero->P->nombre[1]==nombreP[1]){
               printf("Arco no creado, ya existe!\n");
            }else{
              /* if(punteroA->AP==NULL && punteroA->AT==NULL){
                  punteroA->AP = arcP;
               }else{
                  while(punteroA->next){
                     punteroA = punteroA->next;
                  }
                  punteroA->next->AP = arcP;
               }*/
               puntero->next= arcP;
            }
            
         }
      }
   }
   void conexionFail(char *nombre1,char *nombre2){
      printf("No puede conectar %s -> %s \n",nombre1,nombre2);
   }
// -----------------------------------------------------------
// ----------------- [[[MOSTRAR REDES]]] ---------------------

/*void mostrarCamino(char *nombre1, char *nombre2){
   if(!existenPlace(nombre1,nombre2)){
      printf("No existe camino, Place(s) inexistente(s)\n");
   }else{
      Arcos* PA;
      char *temp;
      PA = &arcos;
      Elementos* puntero;
      puntero = &elementos;

      
   }
}*/
void mostrarElementos(){
   Elementos* puntero;
   puntero = &elementos;
   while(puntero!=NULL){
      if(puntero->next!=NULL){
         if(puntero->P!=NULL){
            printf("[%s]->",puntero->P->nombre);
         }else if(puntero->T!=NULL){
            printf("[%s]->",puntero->T->nombre);
         }
         puntero = puntero->next;
      }else{
         if(puntero->P!=NULL){
            printf("[%s]",puntero->P->nombre);
         }else if(puntero->T!=NULL){
            printf("[%s]",puntero->T->nombre);
         }
         puntero = puntero->next;
      }   
      
   }
   printf("\n");
}

void mostrarEM(){
   crearPlace(NULL,"P1",1);
   crearPlace(NULL,"P2",0);
   crearPlace(NULL,"P3",0);
   crearPlace(NULL,"P4",0);
   crearTrans(NULL,"T1");
   crearTrans(NULL,"T2");
   crearTrans(NULL,"T3");
   crearTrans(NULL,"T4");
   crearTrans(NULL,"T5");
   crearArcoT(1,"P1","T1");
   crearArcoT(1,"P1","T2");
   crearArcoP(1,"P2","T1");
   crearArcoP(1,"P3","T2");
   crearArcoT(1,"P2","T3");
   crearArcoT(1,"P3","T4");
   crearArcoP(1,"P4","T3");
   crearArcoP(1,"P4","T4");
   crearArcoT(1,"P4","T5");
   crearArcoP(1,"P1","T5");

   printf("|P|->T1->P2->T3->|P|->|T|->|Inicio|\n");
   printf("|1|->T2->P3->T4->|4|  |5|  |  P1  |\n");
}
void mostrarPC(){
   crearPlace("espera","P1",1);
   crearPlace("produciendo","P2",0);
   crearPlace("buffer vacio","P3",0);
   crearPlace("buffer lleno","P4",0);
   crearPlace("consumiendo","P5",0);
   crearPlace("espera","P6",0);
   crearTrans(NULL,"T1");
   crearTrans(NULL,"T2");
   crearTrans(NULL,"T3");
   crearTrans(NULL,"T4");
   crearArcoT(1,"P1","T2");
   crearArcoT(1,"P3","T2");
   crearArcoT(1,"P5","T4");
   crearArcoT(1,"P2","T1");
   crearArcoT(1,"P4","T3");
   crearArcoT(1,"P6","T3");
   crearArcoP(1,"P1","T1");
   crearArcoP(1,"P2","T2");
   crearArcoP(1,"P4","T2");
   crearArcoP(1,"P3","T3");
   crearArcoP(1,"P5","T3");
   crearArcoP(1,"P6","T4");

   printf(" |->(P1)->||<-(P3)<-||->(P5)->|\n");
   printf(" |        ||        ||        |\n");
   printf(" |        vv        ||        v\n");
   printf("[T1]     [T2]      [T3]      [T4]\n");
   printf(" |        ||        ||        |\n");
   printf(" |--(P2)<-||->(P4)--||--(P6)<-|\n");

}
// ----------------- [[[INSTRUCCIONES]]] ---------------------
void instrucciones(){
   printf("Para utilizar el programa por consola puede digitar\n");
   printf("las siguientes instrucciones escribiendo tal cual se muestran:\n");
   printf("\n");
   printf("MOSTRAR RED E/M:\n");
   printf("    ->Crea y muestra una red de exclusion mutua.\n");
   printf("MOSTRAR RED P/C:\n");
   printf("    ->Crea y muestra una red de Productor/Consumidor.\n");
   printf("MOSTRAR ELEMENTOS:\n");
   printf("    ->Muestra los Places y Transiciones creadas manualmente.\n");
   printf("\n");
   printf("Para crear independientemente Place, Transiciones y Arcos se\n");
   printf("logra de la siguiente manera(cambiar # por numero de 1-9):\n");
   printf("\n");
   printf("PLACE: P#    {para crear place independiente}\n");
   printf("       P#(#) {dentro del parentesis se agrega un token del 1-9}\n");
   printf("       P#[nombre](#){corchete va nombre en minusculas, token en parentesis}\n");
   printf("       P#[nombre]{sin token}\n");
   printf("\n");
   printf("TRANSICIONES:   T# {para crear transicion independiente.}\n");
   printf("                T#[nombre]{crear transicion con nombre}\n");
   printf("\n");
   printf("ARCOS: ->(PLACE,TRANSICION){para crear arco conectando 2 elementos ya creados (P#,T#)}\n");
   printf("                           {ya creados (P#,T#) o (T#,P#).                            }\n");
   printf("       ->[#](P#,T#){[#] para darle un peso al arco reemplazando # por un numero 1-9}\n");
   printf("\n");
   printf("CREAR RED SIMPLE: Conectar puntos como los anteriormente nombrados sin necesidad\n");
   printf("                  De haberlos creados EJ: P1->T1->P2\n");
   printf("\n");
   printf("--------------------------------------------------------------------------------------\n");
   printf("NOTA: Los places solo pueden tener arcos hacia transiciones y viceversa. Los places y\n");
   printf("      las transiciones pueden tener mas de un arco. Si existe una conexion entre 2 \n");
   printf("      puntos el arco no se repetira. Se recomienda ejecutar el programa nuevamente\n");
   printf("      para visualizar los ejemplos de redes complejas.\n");
   printf("--------------------------------------------------------------------------------------\n");
   printf("\n");
   printf("Si deseas repetir las instrucciones escribe INSTRUCCIONES\n");
}
  

%} 

%union {
    char *strVal;
    char charVal;
    int c;
}

/* TOKENS */
%token FINLINEA
%token <c>NUM
%token <strVal>ARCO
%token <strVal>PLACE
%token <strVal>TRANS
%token <strVal>NOMBRE
%type <strVal>ARCOS
%type <strVal>PLACES
%type <strVal>TRANSS
%token PAR
%token PARC
%token COR
%token CORC
%token COMA
%token INST
%token MOSTRAR
%token ELEMENTOS
%token RED
%token EM
%token PC
%token ESPACIO
%token CAMINO
%token VISTA

/* Acciones de produccion */
%% 
   INICIO: INICIO Expr
      | Expr
   ;

   Expr: FIN
      | ARCOS Expr /*pasa a ARCOS para ver si es una red compleja*/  
      | INSTRUCCION  
      
   ;
   PLACES: PLACE COR NOMBRE CORC PAR NUM PARC {crearPlace($3,$1,$6);$$=$1;}  // P#[NOMBRE](#)
   | PLACE PAR NUM PARC {crearPlace(NULL,$1,$3);$$=$1;}/* P#(#) -> Se utiliza cuando es solo la creacion de un PLACE independiente*/
   | PLACE COR NOMBRE CORC {crearPlace($3,$1,0);$$=$1;} // P#[NOMBRE]
   | PLACE {crearPlace(NULL,$1,0);$$=$1;}/* P# -> Place independiente sin Token */
   ;
   ARCOS: PLACES {$$=$1;} // -> P
   | TRANSS {$$=$1;} // ->T
   | PLACES ARCO COR NUM CORC ARCOS {$$=$1; if($6[0]=='P'){conexionFail($1,$6);}else{crearArcoT($4,$1,$6);}} // (P) ->[#] (T)
   | TRANSS ARCO COR NUM CORC ARCOS {$$=$1; if($6[0]=='T'){conexionFail($1,$6);}else{crearArcoT($4,$6,$1);}} // (T) ->[#] (P)
   | PLACES ARCO ARCOS {$$=$1; if($3[0]=='P'){conexionFail($1,$3);}else{crearArcoT(1,$1,$3);}} // P -> T
   | TRANSS ARCO ARCOS {$$=$1; if($3[0]=='T'){conexionFail($1,$3);}else{crearArcoP(1,$3,$1);}} // T -> P   
   | ARCO COR NUM CORC PAR PLACE COMA TRANS PARC {crearArcoT($3,$6,$8);}// ->[#](P#,T#) 
   | ARCO COR NUM CORC PAR TRANS COMA PLACE PARC {crearArcoP($3,$8,$6);}// ->[#](T#,P#)
   | ARCO PAR PLACE COMA TRANS PARC {crearArcoT(1,$3,$5);}// ->(P#,T#) 
   | ARCO PAR TRANS COMA PLACE PARC {crearArcoP(1,$5,$3);}// ->(T#,P#)
   ;
   TRANSS: TRANS COR NOMBRE CORC {crearTrans($3,$1);$$=$1;}// T#[NOMBRE]
   | TRANS{crearTrans(NULL,$1);$$=$1;} // T#
   ;
   INSTRUCCION: INST {instrucciones();}// instrucciones
   | MOSTRAR ESPACIO ELEMENTOS {mostrarElementos();}// Elementos guardados 
   | MOSTRAR ESPACIO RED ESPACIO EM {mostrarEM();}// mostrar red exclusion mutua
   | MOSTRAR ESPACIO RED ESPACIO PC {mostrarPC();}// productor/consumidor
   | MOSTRAR ESPACIO VISTA // RED creada empezando por Place 1
   | MOSTRAR ESPACIO CAMINO ESPACIO PAR PLACE COMA PLACE PARC // camino de un place a otro
   ;
   FIN: FINLINEA 
   ;
%% 

void yyerror(char *s) { 
   printf("\n%s\n", s); 
}

int yywrap(){
    return 1;
}

int main(){   
   instrucciones();
   printf("Ingrese cosas: ->\n"); 
   
   
   return (yyparse());
}