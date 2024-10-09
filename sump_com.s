/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Ingresar un angulo agudo y regresar su angulo complementario y suementario
 */

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {
          
          int angulo = 0, com = 0, sup = 0;
          
          string line = "";
          
          Console.WriteLine("Ingrese angulo: ");
          line = Console.ReadLine();
          angulo = int.Parse(line);
         
        
          com = 90 - angulo;
          sup = 180 - angulo;
          
          Console.WriteLine("Su angulo {0}",angulo);
          Console.WriteLine("Su angulo complementario es {0}",com);
          Console.WriteLine("Su angulo suplementario es {0}",sup);
        }
    }
*/

.global _start

.section .data
prompt:      .asciz "Introduce los grados del ángulo agudo (0-89): "
complemento: .asciz "El complemento es: %d grados.\n"
suplemento:  .asciz "El suplemento es: %d grados.\n"
buffer:      .space 16               // Buffer para almacenar el número

.section .text
_start:
    // Solicitar el ángulo agudo
    ldr x0, =prompt                 // Cargar el mensaje
    mov x1, x0                      // Mover la dirección a x1
    mov x2, 43                      // Longitud del mensaje
    mov x8, 64                      // Syscall para sys_write
    mov x0, 1                       // Descritor de archivo para stdout
    svc #0                          // Llama al sistema para imprimir

    // Leer el ángulo agudo
    mov x0, 0                       // Descritor de archivo para stdin
    ldr x1, =buffer                 // Cargar la dirección del buffer
    mov x2, 16                      // Longitud máxima de la entrada
    mov x8, 63                      // Syscall para sys_read
    svc #0                          // Llama al sistema para leer la entrada

    // Convertir el ángulo de cadena a entero
    ldr x1, =buffer                 // Cargar el buffer en x1
    bl atoi                         // Llamar a la función atoi
    mov x19, x0                     // Guardar el ángulo en x19

    // Calcular complemento y suplemento
    sub x20, 90, x19                // x20 = complemento (90 - ángulo)
    sub x21, 180, x19               // x21 = suplemento (180 - ángulo)

    // Imprimir complemento
    ldr x0, =complemento            // Cargar el mensaje de complemento
    mov x1, x20                     // Mover el complemento a x1
    mov x8, 64                      // Syscall para sys_write
    mov x0, 1                       // Descritor de archivo para stdout
    svc #0                          // Llama al sistema para imprimir

    // Imprimir suplemento
    ldr x0, =suplemento             // Cargar el mensaje de suplemento
    mov x1, x21                     // Mover el suplemento a x1
    mov x8, 64                      // Syscall para sys_write
    mov x0, 1                       // Descritor de archivo para stdout
    svc #0                          // Llama al sistema para imprimir

end:
    // Llamada al sistema para salir
    mov x8, 93                      // Syscall para sys_exit
    mov x0, 0                       // Código de salida
    svc #0                          // Llama al sistema para salir        