//Clase de apoyo
import java.io.*;
class Teclado
{
	public static int LeerLinea()
	{		
		String cadena="";
		try
		{
		/*Podiamos haber puesto					//System.in entrada estandar
		InputStreamReader a = new InputStreamReader(System.in); //InputStreamReader lee un solo caracter del teclado
		BufferedReader stdIn=new BufferedReader(a);		//BufferedReader lee varios caracteres del teclado
		*/
			BufferedReader stdIn=new BufferedReader(new InputStreamReader(System.in));
			cadena=stdIn.readLine();  //Uso mÈtodo readLine de BufferedReader
		}
		catch(IOException error)   //cacha errores de I/O
		{
			System.out.println("No se leyo correctamente");
		}
		return Integer.parseInt(cadena);
	}
	//Este mètodo aunque existe, no se utiliza
	public static void main(String args[])
	{
		System.out.println("Se leyo:"+ LeerLinea());
	}

}
