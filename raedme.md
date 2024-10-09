

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
