import java.util.Scanner;

public class EjemploJava {

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int numero; // Número introducido por el usuario.

    System.out.print("Escribe un número: ");
    numero = sc.nextInt();

    if (numero > 0) && (numero < 100) {
      System.out.println("El número está entre 0 y 100.");
    } else {
      System.out.println("El número está fuera del intervalo!");
    }
  }
}
