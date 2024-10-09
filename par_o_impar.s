/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Determinar si un numero guardado es par o impar
 */

/* Ejemplo en C#

    using System;
    class Program {
        static void Main() {
            
            int numero = 15;
            
            if ((numero % 2) == 1)
                Console.Write("Impar");
            else
                Console.Write("Par");
        }
    }
*/

.global _start

.section .data
    msg_even:    .asciz "El número es par\n"
    msg_odd:     .asciz "El número es impar\n"

.section .bss
    .lcomm result, 1

.section .text
_start:
    // Supongamos que el número se pasa en el registro x0
    mov x0, #15   // Cambia el número aquí (ejemplo: 15)

    // Verificamos si el número es par o impar
    and x1, x0, #1  // x1 = x0 & 1, verificamos el bit menos significativo

    // Si x1 es 0, el número es par
    cbz x1, even_number

odd_number:
    // Si el número es impar, mostrar el mensaje correspondiente
    ldr x0, =msg_odd
    bl print_string
    b end_program

even_number:
    // Si el número es par, mostrar el mensaje correspondiente
    ldr x0, =msg_even
    bl print_string

end_program:
    // Salida del programa
    mov x8, #93       // syscall para exit
    mov x0, #0        // status de salida
    svc #0

print_string:
    // x0 ya contiene la dirección del string
    mov x1, x0        // x1 = dirección del string
    mov x2, #17       // longitud del string (cambiar según la longitud del mensaje)
    mov x8, #64       // syscall para write
    mov x0, #1        // file descriptor para stdout
    svc #0
    ret