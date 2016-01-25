import java.lang.*;	//Bibliotecas de las clases de Java

//Se declara la clase principal con sus variables de instancia y sus mtodos

public class MiClase{
	public int array[];
	String nombre;
	int tamanio;
	//Observa que sus mŽtodos se deben declarar como pœblicos
	public MiClase(String name, int tam)
	{
		this.nombre = name;
		this.tamanio = tam;
		array = new int[tamanio];
	}
	public void setPos(int pos, int valor)
	{
		if((pos >= 0) && (pos < tamanio))
			array[pos] = valor;
		else
			System.out.println("Error la posici—n excede el rango de los ’ndices permitdos.");
	}
	public int getPos(int pos)
	{
		
		if((pos >= 0) && (pos < tamanio))
			return array[pos];
		else
		{
			System.out.println("Error la posici—n excede el rango de los ’ndices permitdos.");
			return (Integer) null;
		}
	}
	
	public void setString(String s)
	{
		this.nombre = s;
	}
	public String getString()
	{
		return nombre;
	}
	
	public int getTamanio()
	{
		return tamanio;
	}
	//El mŽtodo main solamente se puso para probar la clase, no es necesario
/*	public static void main(String args[])
	{
		final int tam = 3;
		MiClase miClase= new MiClase("Nueva clase", tam);
		
		System.out.println("Nombre de la clase: " + miClase.getString()); 
		for(int pos = 0; pos < tam; pos++)
		{
			int valor;
			System.out.println("Dame el valor en la posici—n: " + pos);
			
			valor = Teclado.LeerLinea();
			miClase.setPos(pos,valor);
		}
		System.out.println("El nœmero de elementos es: " + miClase.getTamanio());
		System.out.println("Los valores introducidos fueron: ");
		for(int pos = tam-1; pos >= 0; pos--)
		{
			System.out.println("Posici—n: " + pos + " = " + miClase.getPos(pos));
		}
	}*/
}
