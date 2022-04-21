
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class SesionJDBC {
	//MUY IMPORTANTE: Poner las credenciales del laboratorio. 
	private static String USUARIO = "postgres";
	private static String PASSWORD = "admin";  
	//Nombre de la base de datos
	private static String NOMBRE_BASEDATOS = "universidad";
	//Conexion con la base de datos
	private static String STRING_CONEXION = "jdbc:postgresql://localhost:5432/"+NOMBRE_BASEDATOS;
	
	public static void main(String[] args) {
		try {
			ejemplo1();
			//ejemplo2();
			
			//Sigue incorporando mas ejemplos			
			ejemplo3();
			//ejemplo4();
			ejemplo5();
			ejemplo6();
			prueba();
			
		} catch (SQLException e) { //Tratamiento por Excepcion 
			
			e.printStackTrace();
		}
	}


	/*
	Ejercicio 1. Realizar un metodo en Java que presente por pantalla toda la informacion de los grados
	*/
	public static void ejemplo1() throws SQLException{
		System.out.println("################### EJEMPLO 1 ###################");
		Connection con = getConexion();
		
		//Crear la consulta SQL
		StringBuilder query = new StringBuilder();
		query.append("SELECT * ");
		query.append("FROM grado ");
		
		//Objeto de tipo Statement para enviar la consulta a la base de datos
		Statement st = con.createStatement();
		//executeQuery retornara un resultSet
		ResultSet rs = st.executeQuery(query.toString());
		presentaResultados(rs);
		
		//Muy importante, liberar todos los objetos relacionados con la base de datos
		rs.close();
		st.close();
		con.close();
	}

	/*
	Ejemplo 2. Realizar un metodo en Java que presente por pantalla 
	           toda la informacion de un profesor, se pedirá su nombre por entrada estandard
	*/
	public static void ejemplo2() throws SQLException{
		System.out.println("################### EJEMPLO 2 ###################");
		Connection con = getConexion();
		
		//Creacion de la consulta SQL
		StringBuilder query = new StringBuilder();
		
		// ? sera reemplazado por el valor introducido por entrada estandard
		query.append("SELECT * ");
		query.append("FROM profesor WHERE profesor_nombre = ?"); 
		
		//Crear el objeto Statement para realizar las sentencias de la base de datos
		PreparedStatement st = con.prepareStatement(query.toString());
	
		System.out.println("Introduce el nombre del profesor: ");
	    String nombre = LeerString();
	    st.setString(1, nombre);
		//executeQuery retornara un resultSet
		ResultSet rs = st.executeQuery();
		presentaResultados(rs);
		
		//Muy importante, liberar todos los objetos relacionados con la base de datos
		rs.close();
		st.close();
		con.close();
	}
	
	/**
	 * Ejemplo 3
	 * 
	 * @throws SQLException
	 */
	private static void ejemplo3() throws SQLException {
		System.out.println("################### EJEMPLO 3 ###################");
		Connection con = getConexion ();
		StringBuilder query = new StringBuilder ();
		query.append("SELECT g1.grado_nombre "
				+ "FROM grado g1 "
				+ "WHERE NOT EXISTS ("
				+ "SELECT DISTINCT g2.grado_nombre "
				+ "FROM grado g2 "
				+ "INNER JOIN grado_modulo gm USING(grado_id) "
				+ "INNER JOIN modulo m USING (modulo_id) "
				+ "WHERE m.modulo_nombre='Fundamentos de Informatica' "
				+ "AND g1.grado_id = g2.grado_id "
				+ ")");
		PreparedStatement st = con.prepareStatement(query.toString());
		ResultSet rs = st.executeQuery();
		presentaResultados(rs);
		
		rs.close();
		st.close();
		con.close();
	}

	/**
	 * Ejemplo 4
	 * 
	 * @throws SQLException
	 */
	private static void ejemplo4() throws SQLException {
		System.out.println("################### EJEMPLO 4 ###################");
		Connection con = getConexion ();
		StringBuilder query = new StringBuilder ();
		query.append("SELECT g1.grado_nombre "
				+ "FROM grado g1 "
				+ "WHERE NOT EXISTS ( "
				+ "SELECT DISTINCT g2.grado_nombre "
				+ "FROM grado g2 "
				+ "INNER JOIN grado_modulo gm USING(grado_id) "
				+ "INNER JOIN modulo m USING (modulo_id) "
				+ "WHERE m.modulo_nombre = ? "
				+ "AND g1.grado_id = g2.grado_id "
				+ ")");
		
		
		PreparedStatement st = con.prepareStatement(query.toString());
		System.out.println("Introduce el nombre de la asignatura: ");
	    st.setString(1, LeerString());

		ResultSet rs = st.executeQuery();
		presentaResultados(rs);
		
		rs.close();
		st.close();
		con.close();
	}

	/**
	 * Ejemplo 5
	 * 
	 * @throws SQLException
	 */
	private static void ejemplo5() throws SQLException {
		System.out.println("################### EJEMPLO 5 ###################");
		Connection con = getConexion ();
		StringBuilder query = new StringBuilder ();
		query.append("SELECT DISTINCT estudiante_nombre, estudiante_apellidos "
				+ "FROM estudiante est "
				+ "INNER JOIN estudiante_grado_modulo egm USING (estudiante_id) "
				+ "INNER JOIN grado g USING (grado_id) "
				+ "WHERE LOWER (g.grado_nombre) = 'ingenieria informatica en tecnologias de la informacion' "
				+ "AND estudiante_id NOT IN ( "
				+ "SELECT estudiante_id "
				+ "FROM estudiante est "
				+ "INNER JOIN estudiante_grado_modulo egm USING (estudiante_id) "
				+ "INNER JOIN modulo m USING (modulo_id) "
				+ "WHERE LOWER (modulo_nombre) = 'estructuras de datos')");
	
		
		PreparedStatement st = con.prepareStatement(query.toString());
		ResultSet rs = st.executeQuery();
		presentaResultados(rs);
		
		rs.close();
		st.close();
		con.close();
	}

	/**
	 * Ejemplo 6
	 * 
	 * @throws SQLException
	 */
	private static void ejemplo6() throws SQLException {
		System.out.println("################### EJEMPLO 6 ###################");
		Connection con = getConexion ();
		StringBuilder query = new StringBuilder ();
		query.append("SELECT DISTINCT estudiante_nombre, estudiante_apellidos "
				+ "FROM estudiante est "
				+ "INNER JOIN estudiante_grado_modulo egm USING (estudiante_id) "
				+ "INNER JOIN grado g USING (grado_id) "
				+ "WHERE LOWER (g.grado_nombre) = LOWER(?) "
				+ "AND estudiante_id NOT IN ( "
				+ "SELECT estudiante_id "
				+ "FROM estudiante est "
				+ "INNER JOIN estudiante_grado_modulo egm USING (estudiante_id) "
				+ "INNER JOIN modulo m USING (modulo_id) "
				+ "WHERE LOWER (modulo_nombre) = LOWER(?))");
	
		
		PreparedStatement st = con.prepareStatement(query.toString());
		System.out.println("Introduce el nombre del grado: ");
	    st.setString(1, LeerString());
		System.out.println("Introduce el nombre del modulo: ");
	    st.setString(2, LeerString());
		ResultSet rs = st.executeQuery();
		presentaResultados(rs);
		
		rs.close();
		st.close();
		con.close();
	}

	private static void prueba () throws SQLException {
		System.out.println("################### EJEMPLO 7 ###################");
		Connection con = getConexion();
		
		StringBuilder query = new StringBuilder ();
		
		query.append("UPDATE estudiante SET estudiante_apellidos='Palacio Gomez Prueba' "
				+ "WHERE estudiante_id = ?");
		PreparedStatement st = con.prepareStatement(query.toString());
		System.out.println("Introduce el ID del estudiante: ");
		st.setInt(1, LeerInt());

		int rs = st.executeUpdate();
		System.out.printf("Se han insertado %d tuplas\n", rs);
		//presentaResultados(rs);
		
		//rs.close();
		st.close();
		con.close();
	}

	private static Connection getConexion() throws SQLException{
		
		return  DriverManager.getConnection(STRING_CONEXION,USUARIO,PASSWORD);
	}
	
	/**
	 * Metodo para procesar el resultado de ResultSet
	 * @throws SQLException
	 */
	private static void presentaResultados(ResultSet rs) throws SQLException {
		int numeroColumnas = rs.getMetaData().getColumnCount();
		StringBuilder headers = new StringBuilder();
     
		for(int i = 1; i < numeroColumnas ; i++)
			headers.append(rs.getMetaData().getColumnName(i) + "\t");
		headers.append(rs.getMetaData().getColumnName(numeroColumnas));
     
		System.out.println(headers.toString());
		StringBuilder result = null;
     
		while (rs.next()) {
			result = new StringBuilder();	
			for(int i = 1; i < numeroColumnas ; i++)
				result.append(rs.getObject(i) + "\t");
			result.append(rs.getObject(numeroColumnas));
			System.out.println(result.toString());
		}
     
		if(result == null)
			System.out.println("No hay datos");
	}
	
	@SuppressWarnings("resource")
	private static String LeerString(){
		return new Scanner(System.in).nextLine();		
	}
	
	@SuppressWarnings("resource")
	private static int LeerInt(){
		return new Scanner(System.in).nextInt();			
	}
}
