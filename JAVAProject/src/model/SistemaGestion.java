package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class SistemaGestion {

	private Connection conn;
	
	private static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";

	
	public SistemaGestion() {
		try {
			registerDriver();
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	private void registerDriver() {
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			System.err.println("ERROR: failed to load JDBC driver.");
			System.out.println("Error");
			e.printStackTrace();
		}
	}
	
	public String registrarFuncionario(Funcionario f) {
		String query = "{CALL pkFuncionarioNivel2.registrarFuncionario(" + f.getCedula() + "," + f.getNombre() + "," + f.getFechaNacimiento() + "," + f.getDireccion()+ "," + f.getTelefono() + ")}";
		String mensaje = "";
		try (Statement stmt =  conn.createStatement()){
			stmt.executeQuery(query);
			mensaje = "El funcionario con cedula " + f.getCedula() + " fue insertado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		return mensaje;

	}
}
