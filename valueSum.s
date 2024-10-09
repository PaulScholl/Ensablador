/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Introducir 2 numeros e imprimir si la suma de estos es positiva, negativa o igual a cero
 */

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {
          
          int suma = 0, number1 = 0, number2 = 0;
          
          string line = "";
          
          Console.WriteLine("Ingrese primer numero : ");
          line = Console.ReadLine();
          number1 = int.Parse(line);
          
          Console.WriteLine("Ingrese segundo numero : ");
          line = Console.ReadLine();
          number2 = int.Parse(line);
        
          suma = number1 + number2;
          
          if(suma < 0)
            Console.Write("Negativa");
          else if  (suma > 0)
            Console.Write("Positiva");
          else if (suma == 0)
            Console.Write("Es cero");
        }
    }
*/
.global _start

.section .data
prompt1:   .asciz "Introduce el primer número: "
prompt2:   .asciz "Introduce el segundo número: "
resultPos: .asciz "La suma es positiva.\n"
resultNeg: .asciz "La suma es negativa.\n"
resultZero: .asciz "La suma es cero.\n"
buffer:    .space 16               // Buffer para almacenar los números

.section .text
_start:
    // Solicitar el primer número
    ldr x0, =prompt1               // Cargar el mensaje
    mov x1, x0                     // Mover la dirección a x1
    mov x2, 26                     // Longitud del mensaje
    mov x8, 64                     // Syscall para sys_write
    mov x0, 1                      // Descritor de archivo para stdout
    svc #0                         // Llama al sistema para imprimir

    // Leer el primer número
    mov x0, 0                      // Descritor de archivo para stdin
    ldr x1, =buffer                // Cargar la dirección del buffer
    mov x2, 16                     // Longitud máxima de la entrada
    mov x8, 63                     // Syscall para sys_read
    svc #0                         // Llama al sistema para leer la entrada

    // Convertir el primer número de cadena a entero
    ldr x1, =buffer                // Cargar el buffer en x1
    bl atoi                        // Llamar a la función atoi
    mov x19, x0                    // Guardar el primer número en x19

    // Solicitar el segundo número
    ldr x0, =prompt2               // Cargar el segundo mensaje
    mov x1, x0                     // Mover la dirección a x1
    mov x2, 30                     // Longitud del mensaje
    mov x8, 64                     // Syscall para sys_write
    mov x0, 1                      // Descritor de archivo para stdout
    svc #0                         // Llama al sistema para imprimir

    // Leer el segundo número
    mov x0, 0                      // Descritor de archivo para stdin
    ldr x1, =buffer                // Cargar la dirección del buffer
    mov x2, 16                     // Longitud máxima de la entrada
    mov x8, 63                     // Syscall para sys_read
    svc #0                         // Llama al sistema para leer la entrada

    // Convertir el segundo número de cadena a entero
    ldr x1, =buffer                // Cargar el buffer en x1
    bl atoi                        // Llamar a la función atoi
    add x19, x19, x0               // Sumar el primer y el segundo número

    // Determinar si la suma es positiva, negativa o cero
    cmp x19, 0                     // Comparar la suma con 0
    bgt sum_positive               // Si es mayor que 0, es positiva
    blt sum_negative               // Si es menor que 0, es negativa
    b sum_zero                     // Si es igual a 0, es cero

sum_positive:
    ldr x0, =resultPos             // Cargar el mensaje de suma positiva
    mov x1, x0                     // Mover la dirección a x1
    mov x2, 24                     // Longitud del mensaje
    mov x8, 64                     // Syscall para sys_write
    mov x0, 1                      // Descritor de archivo para stdout
    svc #0                         // Llama al sistema para imprimir
    b end                          // Salir

sum_negative:
    ldr x0, =resultNeg             // Cargar el mensaje de suma negativa
    mov x1, x0                     // Mover la dirección a x1
    mov x2, 24                     // Longitud del mensaje
    mov x8, 64                     // Syscall para sys_write
    mov x0, 1                      // Descritor de archivo para stdout
    svc #0                         // Llama al sistema para imprimir
    b end                          // Salir

sum_zero:
    ldr x0, =resultZero            // Cargar el mensaje de suma cero
    mov x1, x0                     // Mover la dirección a x1
    mov x2, 24                     // Longitud del mensaje
    mov x8, 64                     // Syscall para sys_write
    mov x0, 1                      // Descritor de archivo para stdout
    svc #0                         // Llama al sistema para imprimir

end:
    // Llamada al sistema para salir
    mov x8, 93                     // Syscall para sys_exit
    mov x0, 0                      // Código de salida
    svc #0                         // Llama al sistema para salir

// Función para convertir cadena de texto a entero (atoi)
atoi:
    mov x0, 0                       // Inicializa el resultado
atoi_loop:
    ldrb w2, [x1], 1                // Leer un byte de la cadena
    subs w2, w2, '0'                // Restar el valor ASCII de '0'
    blt atoi_end                    // Si es menor que '0', salir del bucle
    cmp w2, 9                       // Compara con 9
    bgt atoi_end                    // Si es mayor que 9, salir del bucle
    mul x0, x0, 10                  // Multiplicar el resultado actual por 10
    add x0, x0, w2                  // Sumar el dígito actual
    b atoi_loop                     // Repetir para el siguiente carácter
atoi_end:
    ret                             // Retornar el valor
