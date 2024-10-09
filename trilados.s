/*
 * Lenguajes de Interfaz
 * Rodriguez Gallardo Alan Paul
 * Descripcion: Ingresar los 3 lados de un triangulo y btener su area
 */

/* Ejemplo en C#

    using System;
    class Program {
      static void Main() {
          
          float operando = 0f,lado1 = 0f, lado2 = 0f, lado3 = 0f,s = 0f,p = 0f;
          double area= 0;
          string line = "";
          
          Console.WriteLine("Ingrese lado1: ");
          line = Console.ReadLine();
          lado1 = float.Parse(line);
          
          Console.WriteLine("Ingrese lado2: ");
          line = Console.ReadLine();
          lado2 = float.Parse(line);
          
          Console.WriteLine("Ingrese lado3: ");
          line = Console.ReadLine();
          lado3 = float.Parse(line);
         
          p = lado1 + lado2 + lado3;
          
          s = p / 2;
          
          operando = s*(s-lado1)*(s-lado2)*(s-lado3);
          
          area = Math.Sqrt(operando);
          Console.WriteLine("Su area {0}",area);
        }
    }
*/
.global _start

.section .data
prompt_a:     .asciz "Introduce la longitud del lado A: "
prompt_b:     .asciz "Introduce la longitud del lado B: "
prompt_c:     .asciz "Introduce la longitud del lado C: "
result_msg:   .asciz "El área del triángulo es: %d\n"
buffer:       .space 16               // Buffer para almacenar los números
area:         .space 8                 // Buffer para el área

.section .text
_start:
    // Solicitar el lado A
    ldr x0, =prompt_a                // Cargar el mensaje
    mov x1, x0                       // Mover la dirección a x1
    mov x2, 30                       // Longitud del mensaje
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

    // Leer el lado A
    mov x0, 0                        // Descritor de archivo para stdin
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, 16                       // Longitud máxima de la entrada
    mov x8, 63                       // Syscall para sys_read
    svc #0                           // Llama al sistema para leer la entrada

    // Convertir el lado A de cadena a entero
    ldr x1, =buffer                  // Cargar el buffer en x1
    bl atoi                          // Llamar a la función atoi
    mov x19, x0                      // Guardar el lado A en x19

    // Solicitar el lado B
    ldr x0, =prompt_b                // Cargar el mensaje de lado B
    mov x1, x0                       // Mover la dirección a x1
    mov x2, 30                       // Longitud del mensaje
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

    // Leer el lado B
    mov x0, 0                        // Descritor de archivo para stdin
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, 16                       // Longitud máxima de la entrada
    mov x8, 63                       // Syscall para sys_read
    svc #0                           // Llama al sistema para leer la entrada

    // Convertir el lado B de cadena a entero
    ldr x1, =buffer                  // Cargar el buffer en x1
    bl atoi                          // Llamar a la función atoi
    mov x20, x0                      // Guardar el lado B en x20

    // Solicitar el lado C
    ldr x0, =prompt_c                // Cargar el mensaje de lado C
    mov x1, x0                       // Mover la dirección a x1
    mov x2, 30                       // Longitud del mensaje
    mov x8, 64                       // Syscall para sys_write
    mov x0, 1                        // Descritor de archivo para stdout
    svc #0                           // Llama al sistema para imprimir

    // Leer el lado C
    mov x0, 0                        // Descritor de archivo para stdin
    ldr x1, =buffer                  // Cargar la dirección del buffer
    mov x2, 16                       // Longitud máxima de la entrada
    mov x8, 63                       // Syscall para sys_read
    svc #0                           // Llama al sistema para leer la entrada

    // Convertir el lado C de cadena a entero
    ldr x1, =buffer                  // Cargar el buffer en x1
    bl atoi                          // Llamar a la función atoi
    mov x21, x0                      // Guardar el lado C en x21

    // Calcular el semiperímetro: s = (a + b + c) / 2
    add x22, x19, x20                // x22 = A + B
    add x22, x22, x21                // x22 = A + B + C
    lsr x22, x22, 1                   // s = (A + B + C) / 2

    // Calcular el área usando la fórmula de Herón
    sub x23, x22, x19                // x23 = s - A
    sub x24, x22, x20                // x24 = s - B
    sub x25, x22, x21                // x25 = s - C

    mul x26, x22, x23                // x26 = s * (s - A)
    mul x26, x26, x24                // x26 = s * (s - A) * (s - B)
    mul x26, x26, x25                // x26 = s * (s - A) * (s - B) * (s - C)

    // Calcular la raíz cuadrada (utilizando el método de Newton)
    bl sqrt                          // Llamar a la función sqrt
    str d0, area                     // Almacenar el resultado en 'area'

    // Imprimir el resultado
    ldr x0, =result_msg              // Cargar el mensaje de resultado
    mov x1, x0                       // Mover el área a x1
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

// Función para calcular la raíz cuadrada
sqrt:
    mov x3, 0                        // Inicializa el resultado en 0
    mov x4, 1                        // Inicializa el incremento en 1
sqrt_loop:
    mul x5, x4, x4                  // x5 = x4 * x4
    cmp x5, x26                     // Compara x5 con x26 (el área calculada)
    bgt sqrt_end                    // Si x5 es mayor, salir del bucle
    mov x3, x4                      // Actualiza el resultado
    add x4, x4, 1                   // Incrementa x4
    b sqrt_loop                     // Repetir
sqrt_end:
    mov x0, x3                      // Retorna el resultado
    ret
