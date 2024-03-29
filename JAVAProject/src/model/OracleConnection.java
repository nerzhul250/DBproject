package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnection {
	public static final String USER="P09551_1_10";
	public static final String PASS= "P09551_1_10_20191";
	private static Connection oracleConnection;

	private OracleConnection() {
		System.out.println("HEHEHEHEHE");
	}
	public static void closeConnection() throws SQLException {
		if(oracleConnection!=null) {
			oracleConnection.close();
			oracleConnection=null;
		}
	}
	public static Connection returnConnection (String username, String password) throws SQLException {
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
			System.out.println("�Driver no encontrado!");
			e.printStackTrace();
			return;
		}
		System.out.println("Oracle Driver registrado!");
	}
}
