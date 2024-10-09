/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Imprimir la suma de los primeros 1000 numeros
 */

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {

          int suma = 0;

          for(int contador = 1; contador < 1001; contador++){
            suma += contador;
          }

          Console.Write("{0}",suma);
        }
    }
*/

.global _start

.section .data
resultMsg: .asciz "La suma es: %d\n"

.section .text
_start:
    mov x0, 1                    // Inicia el contador en 1
    mov x1, 0                    // Inicializa la suma en 0

loop:
    cmp x0, 1001                 // Compara si el contador ha llegado a 1000
    bge print_result             // Si x0 >= 1001, termina el bucle

    add x1, x1, x0               // Sumar el valor de x0 a la suma
    add x0, x0, 1                // Incrementar el contador en 1
    b loop                       // Repetir el bucle

print_result:
    // Imprimir la suma
    mov x2, x1                   // Cargar el resultado de la suma en x2
    ldr x1, =resultMsg           // Cargar la dirección del mensaje
    mov x8, 64                   // Syscall para write (64 en ARM64)
    mov x0, 1                    // Descritor de archivo para stdout (1)
    svc #0                       // Llama al sistema para imprimir

    // Llamada al sistema para salir
    mov x8, 93                   // Syscall para sys_exit (93 en ARM64)
    mov x0, 0                    // Código de salida
    svc #0                       // Llama al sistema para salir
