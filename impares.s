/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Contar los numeros enteros imapres del 7 a 51
 */

/* Ejemplo en C#

    using System;
    class Program {
        static void Main() {
            for(int contador = 7; contador <52; contador++){
                if((contador % 2)==1)
                    Console.WriteLine("{0}",contador);
            }
        }
    } 
*/

.global _start

.section .data
numFmt:    .asciz "%d\n"      // Formato para imprimir el número

.section .bss
.comm numberBuffer, 4         // Buffer para almacenar el número

.section .text
_start:
    mov x0, 7                 // Inicia el contador en 7 (primer número impar)

loop:
    cmp x0, 52                // Compara si x0 ha llegado a 52
    bge end                   // Si es mayor o igual a 52, termina

    // Imprimir el número
    mov x1, x0                // Coloca el número a imprimir en x1
    ldr x2, =numFmt           // Dirección del formato
    mov x8, 64                // Número de syscall para sys_write (64 es para write en ARM64)
    mov x16, 1                // Descritor de archivo para stdout
    svc #0                    // Llama al sistema para imprimir

    add x0, x0, 2             // Incrementa el contador en 2 (para que solo sean impares)
    b loop                    // Vuelve al inicio del bucle

end:
    // Llamada al sistema para salir (sys_exit)
    mov x8, 93                // Número de syscall para sys_exit en ARM64
    mov x0, 0                 // Código de salida
    svc #0                    // Llama al sistema para salir
