package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnection {
	static Connection oracleConnection;
	public void closeConnection() throws SQLException {
		if(oracleConnection!=null) {
			oracleConnection.close();
			oracleConnection=null;
		}
	}
	public Connection returnConnection (String username, String password) throws SQLException {
		if(oracleConnection==null) {
			oracleConnection = DriverManager.getConnection(
					"jdbc:Oracle:thin:@//200.3.193.24:1522/ESTUD",
					username,
					password);
			return oracleConnection;
		}else {
			return oracleConnection;
		}
	}
	public static void main(String[] args) {
		System.out.println("-------------Prueba de registro de Oracle JDBC -------------");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("¡Driver no encontrado!");
			e.printStackTrace();
			return;
		}
		System.out.println("Oracle Driver registrado!");
	}
}
