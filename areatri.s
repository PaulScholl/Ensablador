/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: la base y altura de un triangulo y calcular su area
*/

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {
          
          float area = 0f, bace = 0f, altura = 0f;
          
          string line = "";
          
          Console.WriteLine("Ingrese base: ");
          line = Console.ReadLine();
          bace = float.Parse(line);
          
          Console.WriteLine("Ingrese altura: ");
          line = Console.ReadLine();
          altura = float.Parse(line);
         
         area = (bace * altura)/2;
          
          Console.WriteLine("Su area {0}",area);
        }
    }
*/
.global _start

.section .data
prompt_base:  .asciz "Introduce la base del triángulo: "
prompt_height: .asciz "Introduce la altura del triángulo: "
result_msg:   .asciz "El área del triángulo es: %d\n"
buffer:       .space 16               // Buffer para almacenar los números

.section .text
_start:
    // Solicitar la base
    ldr x0, =prompt_base             // Cargar el mensaje
    mov x1, x0                       // Mover la dirección a x1
    mov x2, 30                       // Longitud del mensaje
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

    // Leer la base
    mov x0, 0                        // Descritor de archivo para stdin
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, 16                       // Longitud máxima de la entrada
    mov x8, 63                       // Syscall para sys_read
    svc #0                           // Llama al sistema para leer la entrada

    // Convertir la base de cadena a entero
    ldr x1, =buffer                  // Cargar el buffer en x1
    bl atoi                          // Llamar a la función atoi
    mov x19, x0                      // Guardar la base en x19

    // Solicitar la altura
    ldr x0, =prompt_height           // Cargar el mensaje de altura
    mov x1, x0                       // Mover la dirección a x1
    mov x2, 35                       // Longitud del mensaje
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

    // Leer la altura
    mov x0, 0                        // Descritor de archivo para stdin
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, 16                       // Longitud máxima de la entrada
    mov x8, 63                       // Syscall para sys_read
    svc #0                           // Llama al sistema para leer la entrada

    // Convertir la altura de cadena a entero
    ldr x1, =buffer                  // Cargar el buffer en x1
    bl atoi                          // Llamar a la función atoi
    mov x20, x0                      // Guardar la altura en x20

    // Calcular el área: área = (base * altura) / 2
    mul x21, x19, x20                // Multiplicar base * altura
    lsr x21, x21, 1                  // Dividir el resultado entre 2 (shift a la derecha)

    // Imprimir el resultado
    ldr x0, =result_msg              // Cargar el mensaje de resultado
    mov x1, x21                      // Mover el área calculada a x1
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

end:
    // Llamada al sistema para salir
    mov x8, 93                       // Syscall para sys_exit
    mov x0, 0                        // Código de salida
    svc #0                           // Llama al sistema para salir

// Función para convertir cadena de texto a entero (atoi)
atoi:
    mov x0, 0                        // Inicializa el resultado
atoi_loop:
    ldrb w2, [x1], 1                 // Leer un byte de la cadena
    subs w2, w2, '0'                 // Restar el valor ASCII de '0'
    blt atoi_end                     // Si es menor que '0', salir del bucle
    cmp w2, 9                        // Compara con 9
    bgt atoi_end                     // Si es mayor que 9, salir del bucle
    mul x0, x0, 10                   // Multiplicar el resultado actual por 10
    add x0, x0, w2                   // Sumar el dígito actual
    b atoi_loop                      // Repetir para el siguiente carácter
atoi_end:
    ret                              // Retornar el valor
