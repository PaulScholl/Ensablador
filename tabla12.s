/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Imprimir las primeras 12 tablas de sumar hasta el 12
 */

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {
          
          int suma = 0;
          
          for(int contador = 1; contador < 13; contador++){
            
            Console.WriteLine("Sumas de {0}",contador);
            
            for(int contador2 = 1; contador2 <13; contador2++){
                
                suma = contador + contador2;
                Console.WriteLine("{0} + {1} = {2}",contador,contador2,suma);
            }
          }
        }
    }
    }
*/


.global _start

.section .data
format:    .asciz "%d + %d = %d\n"   // Formato para mostrar la suma

.section .bss
.comm buffer, 16                     // Buffer para almacenar temporalmente los valores

.section .text
_start:
    mov x2, 1                        // x2 será nuestro primer sumando (1 a 12)

outer_loop:
    cmp x2, 13                       // Compara si x2 ha llegado a 13 (fin del bucle)
    bge end                          // Si x2 >= 13, termina el bucle

    mov x3, 1                        // x3 será nuestro segundo sumando (1 a 12)

inner_loop:
    cmp x3, 13                       // Compara si x3 ha llegado a 13
    bge next                         // Si x3 >= 13, pasa al siguiente número en la tabla

    add x4, x2, x3                   // Sumar x2 + x3, resultado en x4

    // Imprimir la suma en el formato: "%d + %d = %d\n"
    ldr x0, =format                  // Cargar el formato de impresión
    mov x1, x2                       // Primer sumando en x1
    mov x2, x3                       // Segundo sumando en x2
    mov x3, x4                       // Resultado de la suma en x3
    mov x8, 64                       // Syscall para sys_write (64 en ARM64)
    mov x0, 1                        // Descritor de archivo para stdout (1)
    svc #0                           // Llama al sistema para imprimir

    add x3, x3, 1                    // Incrementa x3 para el próximo número en la tabla
    b inner_loop                     // Vuelve al bucle interno

next:
    add x2, x2, 1                    // Incrementa x2 para pasar al siguiente número
    b outer_loop                     // Vuelve al bucle externo

end:
    // Llamada al sistema para salir
    mov x8, 93                       // Syscall para sys_exit (93 en ARM64)
    mov x0, 0                        // Código de salida
    svc #0                           // Llama al sistema para salir
