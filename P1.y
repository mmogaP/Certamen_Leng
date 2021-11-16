%{ 
   #include<stdio.h> 
   #include<stdlib.h> 
   #include<string.h>
   #include<stdbool.h>
   int yylex();
   void yyerror(char *s);
   

   typedef struct place{
      char *nombre;
      int token;
      struct ArcoT* next;          
   }place;
   typedef struct trans{
      char *nombre;
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

   
   Elementos elementos;
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

   void crearTrans(char *nombre){
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
   
   void crearPlace(char *nombre, int token){
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
         Elementos* edP = Encontrar(nombreP);
         Elementos* edT = Encontrar(nombreT);
         ArcoT* arcT = (ArcoT *)malloc(sizeof(ArcoT));
         arcT->T=edT->T;
         arcT->peso=peso;
         if(edP->P->next==NULL){            
            edP->P->next=arcT;
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
         Elementos* edP = Encontrar(nombreP);
         Elementos* edT = Encontrar(nombreT);
         ArcoP* arcP = (ArcoP *)malloc(sizeof(ArcoP));
         arcP->P=edP->P;
         arcP->peso=peso;
         if(edT->T->next==NULL){            
            edT->T->next=arcP;
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
               puntero->next= arcP;
            }
            
         }
      }
   }
   void conexionFail(char *nombre1,char *nombre2){
      printf("No puede conectar %s -> %s \n",nombre1,nombre2);
   }



   void ejemplo(){
      /*Elementos* puntero;
      puntero = &elementos;
      while(puntero!=NULL){
         if(puntero->P!=NULL){
            printf("[%s]->",puntero->P->nombre);
         }else if(puntero->T!=NULL){
            printf("[%s]->",puntero->T->nombre);
         }
         puntero = puntero->next;
      } */printf("\n");
       
      /*trans T={"T1"};
      
      ArcoT A={0,&T};
      
      place P = {"P1",0, &A};
      elementos.P = &P;*/
      /*crearPlace("P2", 0);
      crearTrans("T1");
      crearPlace("P1", 0);
      
      
      crearPlace("P1", 0);
      if(existen("P1","T1")){
         printf("Existe!!!\n");
      }
      crearTrans("T1");
      
     printf("%p\n",elementos.P);
     printf("%s\n",elementos.next->P->nombre);
     printf("%s\n",elementos.next->next->T->nombre);
     printf("%p\n",elementos.next->next->next->P);*/

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
%type <strVal>ARCOS
%type <strVal>PLACES
%type <strVal>TRANSS
%token PAR
%token PARC
%token COR
%token CORC
%token COMA

/* Acciones de produccion */
%% 
   INICIO: INICIO Expr
      | Expr
   ;

   Expr: FIN
      | ARCOS Expr /*pasa a ARCOS para ver si es una red compleja*/    
      
   ;
   PLACES: PAR PLACE COR NUM CORC PARC {crearPlace($2,$4);$$=$2;}// (P#[#])
   | PAR PLACE PARC {crearPlace($2,0);$$=$2;}// (P#)   
   | PLACE PAR NUM PARC {crearPlace($1,$3);$$=$1;}/* P#(#) -> Se utiliza cuando es solo la creacion de un PLACE independiente*/
   | PLACE {crearPlace($1,0);$$=$1;}/* P# -> Place independiente sin Token */
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
   TRANSS: PAR TRANS PARC {crearTrans($2);$$=$2;}// (T#)
   | TRANS{crearTrans($1);$$=$1;} // T#
   ;
   
   FIN: FINLINEA {ejemplo();}
   ;
%% 

void yyerror(char *s) { 
   printf("\n%s\n", s); 
}

int yywrap(){
    return 1;
}

int main(){   
   printf("Ingrese cosas: ->\n"); 
   
   
   //sprintf(n, "%d",1);
   //strcpy(letras,n);
    
   //printf("%d\n",verificarElemento());
   //ejemplo();
   //printf("%d\n",verificarElemento());
   return (yyparse());
}