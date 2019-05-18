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
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		setUpTipoAnomaliaOps();
		setUpClienteOps();
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
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
		});
	}
}
