package application;

import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import model.*;
import oracle.sql.DATE;

public class ViewController implements Initializable{
	
	
	SistemaGestion sistemaGestion;
	
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
	private TextField txfEliminarIdAnomalia;
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
	 * Registrar solicitud
	 */
	@FXML
	private TextField txfRegistrarCeduCliSolicitud;
	@FXML
	private TextField txfRegistrarCodProdSolicitud;
	@FXML
	private TextField txfRegistrarDescripSolicitud;
	/**
	 * Registrar solicitud de reporte de danios
	 */
	@FXML
	private TextField txfRegistrarIdAnomSolRepDan;
	@FXML
	private Button btRegistrarSolRepDan;
	/**
	 * Registrar solicitud de modificacion de producto
	 */
	@FXML
	private TextField txfRegistrarIdNuevoProdSolModProd;
	@FXML
	private Button btRegistrarSolModProd;
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
	
	@FXML
	private Label labelResultadoFuncionario;
	
	/**
	 * Crear producto
	 */
	@FXML
	private TextField txfCrearCodigoProducto;
	
	@FXML
	private TextField txfCrearDescripcionProducto;
	
	@FXML
	private ChoiceBox<String> mbCrearTipoProducto;
	
	@FXML
	private Button btCrearProducto;
	
	/**
	 * Modificar producto
	 */
	@FXML
	private TextField txfModificarCodigoProducto;
	
	@FXML
	private TextField txfModificarDescripcionProducto;
	
	@FXML
	private ChoiceBox<String> mbModificarTipoProducto;
	
	@FXML
	private Button btModificarProducto;
	
	/**
	 * Eliminar producto
	 */
	@FXML
	private TextField txfEliminarCodigoProducto;
	
	@FXML
	private Button btEliminarProducto;
	
	
	
	
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
	//	dpCrearFechaNacimientoFuncionario;
		sistemaGestion = new SistemaGestion();
		setUpTipoAnomaliaOps();
		setUpClienteOps();
		setUpParametrosOps();
		setUpRegistroSolicitudes();
	}
	
	/**
	 * Registro funcionario
	 */
	
	@FXML
	private void registrarFuncionario() {
		String mensaje = "";
		if(txfCrearCedulaFuncionario.getText().equals("") || txfCrearNombreFuncionario.getText().equals("") || dpCrearFechaNacimientoFuncionario.getEditor().getText().equals("") || txfCrearDireccionFuncionario.getText().equals("") || txfCrearTelefonoFuncionario.getText().equals("")){
			mensaje = "Por favor llene todos los campos";	
		}else{
			Funcionario f = new Funcionario(txfCrearCedulaFuncionario.getText(),txfCrearNombreFuncionario.getText(), dpCrearFechaNacimientoFuncionario.getEditor().getText(), txfCrearDireccionFuncionario.getText(), txfCrearTelefonoFuncionario.getText());
			mensaje = sistemaGestion.registrarFuncionario(f);
		}
		labelResultadoFuncionario.setText(mensaje);	
	}
	@FXML
	public void asignarSolicitudAFuncionario(ActionEvent e) {
		try {
			Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL PKASIGNACIONNIVEL2.realizarAsignacion(SYSDATE,?,?,null,null,null)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(2,txtFuncionarioCedula.getText());
			stmt.setString(3,txtSolicitudCodigo.getText());
		}catch(SQLException ex) {
			showErrorMessage(ex.getMessage());
		}
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
				showErrorMessage(e.getMessage());
			}
		});
		btRegistrarSolModProd.setOnAction(value -> {
			try {
				Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKREGISTRONIVEL2.pRegistrarSolicitudModificacionProducto(?,?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfRegistrarCeduCliSolicitud.getText());
				stmt.setString(2,txfRegistrarCodProdSolicitud.getText());
				stmt.setString(3,txfRegistrarDescripSolicitud.getText());
				stmt.setString(4,txfRegistrarIdNuevoProdSolModProd.getText());
				stmt.execute();
			}catch(SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
	}
	private void setUpParametrosOps() {
		btCrearParametro.setOnAction(value-> {
			try {
				Parametro p=new Parametro(null,txfCrearNombreParametro.getText(),txfCrearValorParametro.getText());
				sistemaGestion.crearParametro(p);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btModificarParametro.setOnAction(value-> {
			try {
				Parametro p=new Parametro(txfModificarCodigoParametro.getText(),txfModificarNombreParametro.getText(),txfModificarValorParametro.getText());
				sistemaGestion.modificarParametro(p);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btEliminarParametro.setOnAction(value-> {
			try {
				Parametro p=new Parametro(txfEliminarCodigoParametro.getText(),null,null);
				sistemaGestion.eliminarParametro(p);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		
	}
	private void setUpClienteOps() {
		btCrearCliente.setOnAction(value-> {
			try {
				Cliente c=new Cliente(txfCrearCedulaCliente.getText(),txfCrearNombreCliente.getText()
						,dpCrearFechaNacimientoCliente.getEditor().getText()
						, txfCrearDireccionCliente.getText()
						,txfCrearTelefonoCliente.getText());
				sistemaGestion.registrarCliente(c);
			}catch(SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btModificarCliente.setOnAction(value-> {
			try {
				Cliente c;
				c=new Cliente(txfCrearCedulaCliente.getText(),txfCrearNombreCliente.getText()
						,dpCrearFechaNacimientoCliente.getEditor().getText()
						, txfCrearDireccionCliente.getText()
						,txfCrearTelefonoCliente.getText());
				c.setCedula(txfModificarCedulaCliente.getText());
				if(txfModificarNombreCliente.getText().isEmpty()) {
					c.setNombre(null);
				}else {
					c.setNombre(txfModificarNombreCliente.getText());
				}
				if(dpModificarFechaNacimientoCliente.getEditor().getText().isEmpty()) {
					c.setFechaNacimiento(null);
				}else {
					c.setFechaNacimiento(dpModificarFechaNacimientoCliente.getEditor().getText());
				}
				if(txfModificarDireccionCliente.getText().isEmpty()) {
					c.setDireccion(null);
				}else {
					c.setDireccion(txfModificarDireccionCliente.getText());
				}
				if(txfModificarTelefonoCliente.getText().isEmpty()) {
					c.setTelefono(null);					
				}else {
					c.setTelefono(txfModificarTelefonoCliente.getText());					
				}								
				sistemaGestion.modificarCliente(c);
			}catch(SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btEliminarCliente.setOnAction(value-> {
			try {
				Cliente c;
				c=new Cliente(txfCrearCedulaCliente.getText(),txfCrearNombreCliente.getText()
						,dpCrearFechaNacimientoCliente.getEditor().getText()
						, txfCrearDireccionCliente.getText()
						,txfCrearTelefonoCliente.getText());
				c.setCedula(txfEliminarCedulaCliente.getText());
				sistemaGestion.eliminarCliente(c);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
	}

	private void setUpTipoAnomaliaOps() {
		btCrearAnomalia.setOnAction(value-> {
			try {
				TipoAnomalia t=new TipoAnomalia(null,txfCrearDescripcionAnomalia.getText());
				sistemaGestion.registrarTipoAnomalia(t);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btModificarAnomalia.setOnAction(value-> {
			try {
				TipoAnomalia t;
				if(txfModificarDescripcionAnomalia.getText().isEmpty()) {
					t=new TipoAnomalia(txfModificarIdAnomalia.getText(),null);
				}else {
					t=new TipoAnomalia(txfModificarIdAnomalia.getText(),txfModificarDescripcionAnomalia.getText());
				}
				sistemaGestion.modificarTipoAnomalia(t);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btEliminarAnomalia.setOnAction(value->{
			try {
				TipoAnomalia t=new TipoAnomalia(txfEliminarIdAnomalia.getText(),null);
				sistemaGestion.eliminarTipoAnomalia(t);
			} catch (SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
	}
	public void showErrorMessage(String message) {
		Alert alert = new Alert(AlertType.ERROR);
		alert.setTitle("Error");
		alert.setHeaderText("Error");
		String error=message.split("\n")[0];
		error=error.substring(error.indexOf(" "));
		alert.setContentText(error);
		alert.showAndWait();
	}
}
