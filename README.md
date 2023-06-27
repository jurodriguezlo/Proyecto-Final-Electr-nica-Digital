
# Temporizador de Corriente Eléctrica
_Juan Angelo Chaves, Tomás Santiago Rodríguez y Juan David Rodríguez Lobelo_
![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/EscudoUNAL1.jpg)
## Descripción
En este proyecto se expone el diseño e implementación de un sistema para monitorear el gasto eléctrico de un hogar como parte del proyecto final de Electrónica DIgital I de la Universidad Nacional de Colombia. Para ello, se usó un sensor de corriente no invasivo para medir el tiempo de corriente consumida por los electrodomésticos en uso, una  FPGA programada para registrar y procesar la información del sensor y mostrar el tiempo de uso de cada electrodoméstico en el display de 7 segmentos y un teclado matricial para ingresar un tiempo máximo de uso de un electrodoméstico y se programará la FPGA para que emita una alarma sonora cuando el tiempo de uso exceda el límite establecido.
El sistema permitirá a los usuarios conocer el consumo energético de cada dispositivo y así tomar medidas para reducir el consumo y ahorrar energía. 
## Alcance y Problemática
En Colombia muchas personas tienen dificultades para pagar sus facturas de energía eléctrica debido al alto costo de la electricidad y a veces, el consumo excesivo de energía. Un dispositivo para el ahorro de energía podría ayudar a reducir los costos de energía de las familias colombianas y contribuir a la sostenibilidad ambiental. Se pretende que este dispositivo sea de bajo costo para que este al alcance de cualquier persona que quiera controlar su consumo eléctrico.
## Objetivos:  
•	Diseñar y construir un dispositivo para el ahorro de energía en viviendas en Colombia, que permita reducir los costos de energía de las familias colombianas y contribuir a la sostenibilidad ambiental mediante el uso de conocimientos básicos de electrónica digital (lógica combinacional y secuencial). En este caso un temporizador o cronometro de tiempo de uso.  

•	Diseñar un circuito lógico combinacional y secuencial que cuente el tiempo en el que se suministra energía a los electrodomésticos de una vivienda.  

•	Integrar sensores que detecten cuando un electrodoméstico está en uso y alarmar en caso de uso excesivo.  

•	Incluir un temporizador para programar el tiempo de uso de ciertos electrodomésticos y optimizar el consumo de energía.  

## Análisis PESTAL del problema:  
### Político:  
El problema de la asequibilidad de la electricidad en Colombia es complejo y está influenciado por varios factores políticos:
En primer lugar, es importante destacar que Colombia es uno de los países de América Latina con los precios más altos de electricidad para los consumidores residenciales. Según datos de la Asociación Colombiana de Distribuidores de Energía Eléctrica (ASOCODIS), en 2021 el costo promedio de la electricidad para los hogares colombianos fue de $0,177 USD por kilovatio hora (kWh), mientras que en países vecinos como Perú y Ecuador fue de $0,115 USD y $0,110 USD por kWh, respectivamente.
En segundo lugar, la estructura tarifaria de la electricidad en Colombia es progresiva, lo que significa que los consumidores que utilizan más energía eléctrica pagan una tarifa más alta por cada kWh adicional. Esto puede ser un incentivo para los consumidores a reducir su consumo de energía, pero también puede ser un obstáculo para aquellos que no tienen los recursos para invertir en tecnologías eficientes en energía.  

### Económico:  

El alto costo de la electricidad para los consumidores residenciales puede tener un impacto negativo en el presupuesto familiar. Según datos del Banco Mundial, en 2020, el costo de la electricidad en Colombia representó el 5,5% del ingreso per cápita, mientras que en países como México y Perú fue del 2,9% y el 2,2% respectivamente. Esto significa que los hogares colombianos destinan una mayor proporción de su ingreso para cubrir los gastos de electricidad.  

### Social:

Según datos del Departamento Administrativo Nacional de Estadística (DANE), en 2020, el 27,4% de la población colombiana estaba en situación de pobreza multidimensional, lo que significa que no tienen acceso a servicios básicos como electricidad, agua potable, saneamiento básico y vivienda adecuada. El alto costo de la electricidad puede ser una barrera para que estas personas tengan acceso a servicios básicos y a una calidad de vida adecuada.  
## Descripción del funcionamiento:  

El programa será diseñado para que al detectar el flujo de corriente o el electrodoméstico encendido se pase un 1 como si fuese un botón de encendido conectado a un contador a un contador que iniciara a mostrar en la FPGA el numero de minutos encendidos que lleva el electrodoméstico, cuando el sensor deje de detectar corriente la cuenta se detendrá en el numero que llevaba y se iniciara de nuevo en este mismo número cuando vuelva a detectar el encendido, esto permitirá al usuario conocer el tiempo total de uso en un periodo largo de tiempo. Si el usuario desea resetear la cuenta para que vuelva a iniciar solo tendrá que (aún no se decide, pero hay 2 opciones, o que pase un código que la FPGA entienda como una contraseña con una maquina de estados, o que sea un simple botón) de esta manera reiniciara la cuenta. La FPGA también contara el tiempo que lleva ella encendida para que el usuario también conozca su gasto en corriente y energía, para visualizarlo, solo tendrá que oprimir un botón que cambiara a mostrar la cuenta de dicho tiempo. Por último, el usuario podrá colocar un tiempo de uso, después del cual, al llegar a dicho numero la FPGA activará una alarma, si el usuario no coloca ninguno este será por default un numero de horas predeterminado por los fabricantes. Dicho número de tiempo también será el máximo permitido de cuenta, ya que este solo es un proyecto académico y no comercial, luego de este tiempo y de que suene la alarma la FPGA reiniciara los contadores de tiempo.
## Diagramas de bloques  

Se realizo un detallado diagrama de bloques que permite visualizar de manera precisa todos los componentes que conforman el proyecto finalizado. Este diagrama proporciona una representación gráfica clara y completa de cada uno de los elementos involucrados en el proyecto, lo que facilita su comprensión y análisis.


![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Esq1x.jpg)

## Diagramas de flujo 

Con este diagrama de bloqueas podemos realizar el diagrama de flujo del dispositivo:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/ASMR1x.jpg)  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/ASMR2x.jpg)  

## Máquina de estados  

 Se diseño una maquina de estados tipo moore con la siguiente codificacion de entradas.  

 ![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Codx.jpg)  

 
Esta es la máquina de estados que permite guardar los números del teclado:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Estados1x.jpg)  

Con la siguiente tabla de verdad:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Tabla1.jpg)  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Tabla2x.jpg) 

Y los siguientes mapas de Karnaugh: 

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Kar1.jpeg)  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Kar2.jpeg)  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Kar3.jpeg)  

Para finalmente tener el esquema de flip-flops:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Flipx.jpg) 


## Implementación  
Se construyó dispositivo de la siguiente forma:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/FotoFPGAx.jpg)  
![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Foto_Teclado_Matricialx.jpg)  

Con las siguientes conexiones de la FPGA al teclado matricial:  

![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Conexiones_Teclado_1x.jpg)
![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Conexiones_Teclado_2x.jpg)
![Aquí la descripción de la imagen por si no carga](https://raw.githubusercontent.com/jurodriguezlo/Proyecto-Final-Electr-nica-Digital/master/Imágenes/Conexiones_Teclado_3x.jpg)
## Video  
 Link del video en youtube:  
 https://youtu.be/ucgpaSq-A_4

## Referencias  

•	https://www.portafolio.co/negocios/este-dispositivo-optimiza-el-consumo-de-energia-electrica-en-hogares-y-oficinas-553422  

•	https://www.elcolombiano.com/negocios/ecosmart-el-dispositivo-que-reduce-hasta-25-el-consumo-de-energia-JF9063446  

•	https://www.minenergia.gov.co/documents/10180/234066/Boletin+Estadistico+Mensual+septiembre+2021.pdf/6e12d6ec-c931-4a00-aa1e-3463f4b4cb7f  

•	https://www.dnp.gov.co/DNPN/Paginas/Consumo-de-energ%C3%ADa-el%C3%A9ctrica-en-Colombia---2020.aspx













