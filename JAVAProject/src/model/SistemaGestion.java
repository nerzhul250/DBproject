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

	public void crearParametro(Parametro p) throws SQLException {
		conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pRegistrarParametro(?,?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,p.getNombre());
		stmt.setString(2,p.getValor());
		stmt.execute();
	}

	public void modificarParametro(Parametro p) throws SQLException {
		conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pModificarParametro(?,?,?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,p.getCodigo());
		stmt.setString(2,p.getNombre());
		stmt.setString(3,p.getValor());				
		stmt.execute();
	}

	public void eliminarParametro(Parametro p) throws SQLException {
		conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pEliminarParametro(?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,p.getCodigo());				
		stmt.execute();
	}

	public void registrarTipoAnomalia(TipoAnomalia t) throws SQLException {
		conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pRegistrarTipoAnomalia(?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,t.getDescripcion());
		stmt.execute();
	}

	public void modificarTipoAnomalia(TipoAnomalia t) throws SQLException {
		conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pModificarTipoAnomalia(?,?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,t.getId());
		stmt.setString(2,t.getDescripcion());					
		stmt.execute();
	}

	public void eliminarTipoAnomalia(TipoAnomalia t) throws SQLException {
		conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pEliminarTipoAnomalia(?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,t.getId());
		stmt.execute();
	}

	public void registrarCliente(Cliente c) throws SQLException {
		Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pRegistrarCliente(?,?,?,?,?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,c.getCedula());
		stmt.setString(2,c.getNombre());
		stmt.setString(3,c.getFechaNacimiento());
		stmt.setString(4,c.getDireccion());
		stmt.setString(5,c.getTelefono());
		stmt.execute();
	}

	public void modificarCliente(Cliente c) throws SQLException {
		Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pModificarCliente(?,?,?,?,?)}";
		CallableStatement stmt = conn.prepareCall(query);				
		stmt.setString(1,c.getCedula());
		stmt.setString(2,c.getNombre());					
		stmt.setString(3,c.getFechaNacimiento());
		stmt.setString(4,c.getDireccion());
		stmt.setString(5,c.getTelefono());
		stmt.execute();
	}

	public void eliminarCliente(Cliente c) throws SQLException {
		conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
		String query = "{CALL PKGESTIONTABLAS.pEliminarCliente(?)}";
		CallableStatement stmt = conn.prepareCall(query);
		stmt.setString(1,c.getCedula());
		stmt.execute();
	}
}
