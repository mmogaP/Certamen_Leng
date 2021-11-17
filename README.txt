-> El git donde se encuentra el certamen 1:

https://github.com/mmogaP/Certamen_Leng.git

-> Ejecución / Compilación:

Para la ejecución se debe hacer uso del archivo Makefile, el cual contiene todos los comandos necesarios para la compilación del programa.

En la consola o terminal, solo debera inicializar el comando make y el programa sera compilado,posteriormente debe ingresar el comando ./certamen.exe y podra ingresar la gramatica.

En  caso  de  no  tener  make  instalado  debera  instalarlo  en  base  al  sistema  operativo  que  este usando, para Linux es sudo apt-get install make


-> Apartado de instrucciones:

Para utilizar el programa por consola puede digitar las siguientes instrucciones escribiendo tal cual se muestran:

MOSTRAR RED E/M: Crea y muestra una red de exclusión mutua.
MOSTRAR RED P/C: Crea y muestra una red de Productor/Consumidor.
MOSTRAR ELEMENTOS: Muestra los Places y Transiciones creadas manualmente.

Para crear independientemente Place, Transiciones y Arcos se logra de la siguiente manera(cambiar /# por numero de 1-9):

PLACE: P/#    {para crear place independiente}
   P/#(/#) {dentro del parentesis se agrega un token del 1-9}
    P/#[nombre](/#){corchete va nombre en minúsculas, token en paréntesis}
    P/#[nombre]{sin token}

TRANSICIONES:   T/# {para crear transición independiente.}
   T/#[nombre]{crear transición con nombre}

ARCOS: (PLACE,TRANSICION){para crear arco conectando 2 elementos ya creados (P/#,T/#)}
    ya creados (P/#,T/#) o (T/#,P/#).                            }
    ->[/#](P/#,T/#){[/#] para darle un peso al arco reemplazando /# por un número 1-9}

CREAR RED SIMPLE: Conectar puntos como los anteriormente nombrados sin necesidad
    De haberlos creados EJ: P1->T1->P2

NOTA: Los places sólo pueden tener arcos hacia transiciones y viceversa. Los places y
   Las transiciones pueden tener más de un arco. Si existe una conexión entre 2 
   puntos el arco no se repetirá. Se recomienda ejecutar el programa nuevamente
   para visualizar los ejemplos de redes complejas.

