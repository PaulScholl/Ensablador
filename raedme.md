

1. Pedir los 3 lados de un triangulo y regresar el area de este </br>
  graph TD </br>
    A[Inicio] --> B[Capturar lado a]</br>
    B --> C[Capturar lado b]</br>
    C --> D[Capturar lado c]</br>
    D --> E{¿Es un triángulo válido?}</br>
    E -->|Sí| F[Calcular semiperímetro s = (a + b + c) / 2]</br>
    F --> G[Calcular área usando fórmula de Herón]</br>
    G --> H[Imprimir área del triángulo]</br>
    H --> I[Fin]</br>
    E -->|No| J[Imprimir "Triángulo inválido"]</br>
    J --> I</br>

2. Imprimir los numeros enteros desde el numero 9 al numero 43</br>
     graph TD</br>
    A[Inicio] --> B[Inicializar contador en 9]</br>
    B --> C{¿Contador <= 43?}</br>
    C -->|Sí| D[Imprimir contador]</br>
    D --> E[Incrementar contador en 1]</br>
    E --> C</br>
    C -->|No| F[Fin]</br>
3. Imprimir los numeros impares del 7 al 51
   graph TD</br>
    A[Inicio] --> B[Inicializar contador en 7]</br>
    B --> C{¿Contador <= 51?}</br>
    C -->|Sí| D[Imprimir contador]</br>
    D --> E[Incrementar contador en 2]</br>
    E --> C</br>
    C -->|No| F[Fin]</br>
4. Un programa que desligue si un numero almacenado es par o impar </br>
   graph TD</br>
    A[Inicio] --> B[Leer número almacenado]</br>
    B --> C{¿Número % 2 == 0?}</br>
    C -->|Sí| D[Imprimir "El número es par"]</br>
    C -->|No| E[Imprimir "El número es impar"]</br>
    D --> F[Fin]</br>
    E --> F</br>
5. Imprimir los numeros pares del 2 al 48 </br>
   graph TD</br>
    A[Inicio] --> B[Inicializar contador en 2]</br>
    B --> C{¿Contador <= 48?}</br>
    C -->|Sí| D[Imprimir contador]</br>
    D --> E[Incrementar contador en 2]</br>
    E --> C</br>
    C -->|No| F[Fin]</br>
6. Sumar los primeros 1000 numeros enteros e imprimir el resultado</br>
   graph TD</br>
    A[Inicio] --> B[Inicializar suma = 0, contador = 1]</br>
    B --> C{¿Contador <= 1000?}</br>
    C -->|Sí| D[Sumar contador a suma]</br>
    D --> E[Incrementar contador en 1]</br>
    E --> C</br>
    C -->|No| F[Imprimir suma total]</br>
    F --> G[Fin]</br>
7. Pedir un angulo agudo  e imprimir los angulos complementario y suplementario de un agulo </br>
graph TD</br>
    A[Inicio] --> B[Solicitar ángulo agudo]</br>
    B --> C{¿Ángulo < 90°?}</br>
    C -->|Sí| D[Calcular ángulo complementario: 90° - ángulo]</br>
    D --> E[Calcular ángulo suplementario: 180° - ángulo]</br>
    E --> F[Imprimir ángulo complementario y suplementario]</br>
    F --> G[Fin]</br>
    C -->|No| H[Imprimir "El ángulo no es agudo"]</br>
    H --> G</br>
8. Imprimir las sumas desde 1+1 hasta 12 + 12 </br>
graph TD</br>
    A[Inicio] --> B[Inicializar contador en 1]</br>
    B --> C{¿Contador <= 12?}</br>
    C -->|Sí| D[Calcular suma: contador + contador]</br>
    D --> E[Imprimir suma]</br>
    E --> F[Incrementar contador en 1]</br>
    F --> C</br>
    C -->|No| G[Fin]</br>
9.  Solicitar la base y altura de un triangulo e imprimir su area
10.  
