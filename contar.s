/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Contar los numeros del 9 a 43
 */

/* Ejemplo en C#

    using System;
    class Program {
        static void Main() {
        for(int contador = 9; contador <44; contador++)
        
        Console.WriteLine("{0}",contador);
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
    mov x0, 9                 // Inicia el contador en 9

loop:
    cmp x0, 44                // Compara si x0 ha llegado a 44
    bge end                   // Si es mayor o igual a 44, termina

    // Imprimir el número
    mov x1, x0                // Coloca el número a imprimir en x1
    ldr x2, =numFmt           // Dirección del formato
    mov x8, 64                // Número de syscall para sys_write (64 es para write en ARM64)
    mov x16, 1                // Descritor de archivo para stdout
    svc #0                    // Llama al sistema para imprimir

    add x0, x0, 1             // Incrementa el contador
    b loop                    // Vuelve al inicio del bucle

end:
    // Llamada al sistema para salir (sys_exit)
    mov x8, 93                // Número de syscall para sys_exit en ARM64
    mov x0, 0                 // Código de salida
    svc #0                    // Llama al sistema para salir
