package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class SistemaGestion {

	private Connection conn;
	
	private static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";

	
	public SistemaGestion() {
	}
	
	public String registrarFuncionario(Funcionario f) {
		String mensaje = "";
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkFuncionarioNivel2.registrarFuncionario(?,?,?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, f.getCedula());
			stmt.setString(2, f.getNombre());
			stmt.setString(3, f.getFechaNacimiento());
			stmt.setString(4, f.getDireccion());
			stmt.setString(5, f.getTelefono());
			stmt.executeQuery();
			mensaje = "El funcionario con cedula " + f.getCedula() + " fue insertado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		return mensaje;

	}
	
	public String modificarFuncionario(Funcionario f) {
		String mensaje = "";
		
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkFuncionarioNivel2.modificarFuncionario(?,?,?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, f.getCedula());
			stmt.setString(2, f.getNombre());
			stmt.setString(3, f.getFechaNacimiento());
			stmt.setString(4, f.getDireccion());
			stmt.setString(5, f.getTelefono());
			stmt.executeQuery();
			mensaje = "La informacion del funcionario con cedula " + f.getCedula() + " fue modificada satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		
		return mensaje;
	}

	public String borrarFuncionario(String pCedula) {
		String mensaje = "";		
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkFuncionarioNivel2.borrarFuncionario(?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, pCedula);
			stmt.executeQuery();
			mensaje = "El funcionario con cedula " + pCedula + " fue eliminado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		
		return mensaje;
	}
	
	public String crearProducto(Producto p) {
		String mensaje = "";
		
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkProductoNivel2.registrarProducto(?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, p.getCodigo());
			stmt.setString(2, p.getDescripcion());
			stmt.setInt(3, p.getTipo());
			stmt.executeQuery();
			mensaje = "El producto con codigo " + p.getCodigo() + " fue insertado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		
		return mensaje;
	}
	
	public String modificarProducto(Producto p) {
		String mensaje = "";
		
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkProductoNivel2.modificarProducto(?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, p.getCodigo());
			stmt.setString(2, p.getDescripcion());
			stmt.setInt(3, p.getTipo());
			stmt.executeQuery();
			mensaje = "El producto con codigo " + p.getCodigo() + " fue modificado satisfactoriamente";
		} catch (SQLException e) {
			mensaje = e.getMessage();
		}
		
		return mensaje;
	}
	
	public String borrarProducto(String codigo) {
		String mensaje = "";
		
		try {
			conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL pkProductoNivel2.borrarProducto(?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, codigo);
			stmt.executeQuery();
			mensaje = "El producto con codigo " + codigo + " fue eliminado satisfactoriamente";
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
