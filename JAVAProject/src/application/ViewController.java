package application;

import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;
import model.OracleConnection;

public class ViewController implements Initializable{
	/**
	 * Creacion tipo anomalia
	 */
	@FXML
	private TextField txfCrearDescripcionAnomalia;
	@FXML
	private Button btCrearAnomalia;
	/**
	 * Modificacion tipo anomalia
	 */
	@FXML
	private TextField txfModificarIdAnomalia;
	@FXML
	private TextField txfModificarDescripcionAnomalia;
	@FXML
	private Button btModificarAnomalia;
	/**
	 * Eliminar tipo anomalia
	 */
	@FXML
	private TextField txfEliminarAnomalia;
	@FXML
	private Button btEliminarAnomalia;
	
	/**
	 * Creacion Cliente
	 */
	@FXML
	private TextField txfCrearCedulaCliente;
	@FXML
	private TextField txfCrearNombreCliente;
	@FXML
	private TextField txfCrearDireccionCliente;
	@FXML
	private TextField txfCrearTelefonoCliente;
	@FXML
	private DatePicker dpCrearFechaNacimientoCliente;
	@FXML
	private Button btCrearCliente;
	/**
	 * Modificar Cliente
	 */
	@FXML
	private TextField txfModificarCedulaCliente;
	@FXML
	private TextField txfModificarNombreCliente;
	@FXML
	private TextField txfModificarDireccionCliente;
	@FXML
	private TextField txfModificarTelefonoCliente;
	@FXML
	private DatePicker dpModificarFechaNacimientoCliente;
	@FXML
	private Button btModificarCliente;
	/**
	 * Eliminar Cliente
	 */
	@FXML
	private TextField txfEliminarCedulaCliente;
	@FXML
	private Button btEliminarCliente;
	
	/**
	 * Crear parametro
	 */
	@FXML
	private TextField txfCrearNombreParametro;
	@FXML
	private TextField txfCrearValorParametro;
	@FXML
	private Button btCrearParametro;
	/**
	 * Modificar parametro
	 */
	@FXML
	private TextField txfModificarCodigoParametro;
	@FXML
	private TextField txfModificarNombreParametro;
	@FXML
	private TextField txfModificarValorParametro;
	@FXML
	private Button btModificarParametro;
	/**
	 * Eliminar parametro
	 */
	@FXML
	private TextField txfEliminarCodigoParametro;
	@FXML
	private Button btEliminarParametro;
	/**
	 * Registrar solicitud de reporte de danios
	 */
	@FXML
	private TextField txfRegistrarCeduCliSolicitud;
	@FXML
	private TextField txfRegistrarCodProdSolicitud;
	@FXML
	private TextField txfRegistrarDescripSolicitud;
	@FXML
	private TextField txfRegistrarIdAnomSolRepDan;
	@FXML
	private Button btRegistrarSolRepDan;
	
	/**
	 *  Crear funcionario
	 */
	@FXML
	private TextField txfCrearCedulaFuncionario;
	
	@FXML
	private TextField txfCrearNombreFuncionario;
	
	@FXML
	private DatePicker dpCrearFechaNacimientoFuncionario;
	
	@FXML
	private TextField txfCrearDireccionFuncionario;
	
	@FXML
	private TextField txfCrearTelefonoFuncionario;
	
	@FXML
	private Button btCrearFuncionario;
	
	/**
	 * Modificar funcionario
	 */
	@FXML
	private TextField txfModificarCedulaFuncionario;
	
	@FXML
	private TextField txfModificarNombreFuncionario;
	
	@FXML
	private DatePicker dpModificarFechaNacimientoFuncionario;
	
	@FXML
	private TextField txfModificarDireccionFuncionario;
	
	@FXML
	private TextField txfModificarTelefonoFuncionario;
	
	@FXML
	private Button btModificarFuncionario;
	
	/**
	 * Eliminar funcionario
	 */
	@FXML
	private TextField txfEliminarCedulaFuncionario;
	
	@FXML
	private Button btEliminarFuncionario;
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		setUpTipoAnomaliaOps();
		setUpClienteOps();
		setUpParametrosOps();
		setUpRegistroSolicitudes();
	}
	private void setUpRegistroSolicitudes() {
		btRegistrarSolRepDan.setOnAction(value->{
			try {
				Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKREGISTRONIVEL2.pRegistrarSolicitudReporteDanios(?,?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfRegistrarCeduCliSolicitud.getText());
				stmt.setString(2,txfRegistrarCodProdSolicitud.getText());
				stmt.setString(3,txfRegistrarDescripSolicitud.getText());
				stmt.setString(4,txfRegistrarIdAnomSolRepDan.getText());
				stmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
	}
	private void setUpParametrosOps() {
		btCrearParametro.setOnAction(value-> {
			Connection conn;
			try {
				conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pRegistrarParametro(?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfCrearNombreParametro.getText());
				stmt.setString(2,txfCrearValorParametro.getText());
				stmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
		btModificarParametro.setOnAction(value-> {
			Connection conn;
			try {
				conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pModificarParametro(?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfModificarCodigoParametro.getText());
				stmt.setString(2,txfModificarNombreParametro.getText());
				stmt.setString(3,txfModificarValorParametro.getText());				
				stmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
		btEliminarParametro.setOnAction(value-> {
			Connection conn;
			try {
				conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pEliminarParametro(?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfEliminarCodigoParametro.getText());				
				stmt.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
		
	}
	private void setUpClienteOps() {
		btCrearCliente.setOnAction(value-> {
			try {
				Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pRegistrarCliente(?,?,?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfCrearCedulaCliente.getText());
				stmt.setString(2,txfCrearNombreCliente.getText());
				stmt.setString(3,dpCrearFechaNacimientoCliente.getEditor().getText());
				stmt.setString(4,txfCrearDireccionCliente.getText());
				stmt.setString(5,txfCrearTelefonoCliente.getText());
				stmt.execute();
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
		btModificarCliente.setOnAction(value-> {
			try {
				Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pModificarCliente(?,?,?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				
				stmt.setString(1,txfModificarCedulaCliente.getText());
				
				if(txfModificarNombreCliente.getText().isEmpty()) {
					stmt.setString(2,null);					
				}else {
					stmt.setString(2,txfModificarNombreCliente.getText());					
				}
				
				if(dpModificarFechaNacimientoCliente.getEditor().getText().isEmpty()) {
					stmt.setString(3,null);					
				}else {
					stmt.setString(3,dpModificarFechaNacimientoCliente.getEditor().getText());					
				}
				
				if(txfModificarDireccionCliente.getText().isEmpty()) {
					stmt.setString(4,null);					
				}else {
					stmt.setString(4,txfModificarDireccionCliente.getText());					
				}
				
				if(txfModificarTelefonoCliente.getText().isEmpty()) {
					stmt.setString(5,null);					
				}else {
					stmt.setString(5,txfModificarTelefonoCliente.getText());
				}				
				
				stmt.execute();
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
		btEliminarCliente.setOnAction(value-> {
			Connection conn;
			try {
				conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pEliminarCliente(?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfEliminarCedulaCliente.getText());
				stmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
	}

	private void setUpTipoAnomaliaOps() {
		btCrearAnomalia.setOnAction(value-> {
			try {
				Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pRegistrarTipoAnomalia(?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfCrearDescripcionAnomalia.getText());
				stmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
		btModificarAnomalia.setOnAction(value-> {
			try {
				Connection conn=OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pModificarTipoAnomalia(?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfModificarIdAnomalia.getText());
				if(txfModificarDescripcionAnomalia.getText().isEmpty()) {
					stmt.setString(2,null);					
				}else {
					stmt.setString(2,txfModificarDescripcionAnomalia.getText());					
				}
				stmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
		btEliminarAnomalia.setOnAction(value->{
			Connection conn;
			try {
				conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKGESTIONTABLAS.pEliminarTipoAnomalia(?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfEliminarAnomalia.getText());
				stmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
	}
}
