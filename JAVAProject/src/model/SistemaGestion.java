package model;

import java.sql.CallableStatement;
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
		String mensaje = "";
		try {
			String query = "{CALL pkFuncionarioNivel2.registrarFuncionario(?,?,?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, f.getCedula());
			stmt.setString(2, f.getNombre());
			stmt.setDate(3, f.getFechaNacimiento());
			stmt.setString(4, f.getDireccion());
			stmt.setString(5, f.getTelefono());
			stmt.executeQuery();
			mensaje = "El funcionario con cedula " + f.getCedula() + " fue insertado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		return mensaje;

	}
}
