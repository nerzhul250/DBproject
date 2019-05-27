package application;

import java.awt.Dialog;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.GregorianCalendar;
import java.util.ResourceBundle;

import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
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
	 * Registrar solicitud de reclamo
	 */
	@FXML
	private Button btRegistrarSolReclamo;
	/**
	 * Registrar solicitud de creacion
	 */
	@FXML
	private Button btRegistrarSolCreacion;
	/**
	 * Registrar solicitud de cancelacion de producto
	 */
	@FXML
	private Button btRegistrarSolCancProd;
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
	
	// AQUI EMPIEZA LA COSA DE ASIGNACION
	@FXML
	private TextField txtSolicitudCodigo;
	
	@FXML
	private TextField txtFuncionarioCedula;
	
	//PESTAÑA ATENCION
	@FXML
	private TextField txtCodigoFuncionario;
	
	@FXML
	private TextField txtCodigoSolicitud;
	
	@FXML
	private CheckBox cbAprobado;
	
	@FXML
	private TextArea txtComentarioFuncionario;
	
	private ObservableList<String> listaTiposPorductos = FXCollections.observableArrayList("Servicio de Voz", "Servicio de Datos", "Servicio Integrado");
	
	@FXML
	private Label labelResultadoProducto;
	
	/**
	 * Consulta solicitudes
	 */
	@FXML
	private TextArea txtConsulta;
	@FXML
	private Button btConsultaSolicitud;
	@FXML
	private Button btConsultaAsignacion;
	@FXML
	private Button btConsultaServicioPrestado;
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		sistemaGestion = new SistemaGestion();
		setUpTipoAnomaliaOps();
		setUpClienteOps();
		setUpParametrosOps();
		setUpRegistroSolicitudes();
		mbCrearTipoProducto.setItems(listaTiposPorductos);
		mbModificarTipoProducto.setItems(listaTiposPorductos);
	}
	/**
	 * Consultas
	 */
	@FXML
	private void consultarSolicitudes() {
		Connection connection;
		try {
			connection = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM solicitud");
			String report="";
			while (rs.next()) {
				report += "\n" + rs.getInt("CODIGO") + "\t\t" + rs.getString("ESTADO") + "\t\t" +
			 rs.getString("DESCRIPCION") + "\t\t" + rs.getString("CLIENTE_CEDULA") +"\t\t"+ rs.getString("PRODUCTO_CODIGO")+"\t\t"
			 + rs.getDate("FECHACREACION").toString()+"\t\t"+rs.getString("TIPO");
			}
			txtConsulta.setText(report);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@FXML
	private void consultarAsignaciones() {
		Connection connection;
		try {
			connection = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM asignacion");
			String report="";
			while (rs.next()) {
				report += "\n" + rs.getDate("FECHAASIGNACION").toString() + "\t\t" + rs.getString("FUNCIONARIO_CEDULA") + "\t\t" +
			 rs.getInt("SOLICITUD_CODIGO") + "\t\t" + (rs.getDate("FECHAATENCION")==null?"null":rs.getDate("FECHAATENCION").toString()) +"\t\t"+ (rs.getString("COMENTARIOSFUNCIONARIO")==null?"null":rs.getString("COMENTARIOSFUNCIONARIO"))+"\t\t"
			 + rs.getBoolean("ATENDIDO");
			}
			txtConsulta.setText(report);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@FXML
	private void consultarServiciosPrestados() {
		Connection connection;
		try {
			connection = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT * FROM servicioprestado");
			String report="";
			while (rs.next()) {
				report += "\n" +rs.getString("PRODUCTO_CODIGO") + "\t\t" +
			 rs.getString("CLIENTE_CEDULA") + "\t\t" + (rs.getDate("FECHATERMINACIONSERVICIO")==null?"null":rs.getDate("FECHATERMINACIONSERVICIO").toString())+"\t\t"
			 + rs.getDate("FECHAINICIOSERVICIO").toString();
			}
			txtConsulta.setText(report);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * Registro funcionario
	 */
	
	@FXML
	private void registrarFuncionario() {
		String mensaje = "";
		if(txfCrearCedulaFuncionario.getText().equals("")){
			mensaje = "Por favor rellene el campo de la cedula del funcionario";	
		}else{
			Funcionario f = new Funcionario(txfCrearCedulaFuncionario.getText(),txfCrearNombreFuncionario.getText(), dpCrearFechaNacimientoFuncionario.getEditor().getText(), txfCrearDireccionFuncionario.getText(), txfCrearTelefonoFuncionario.getText());
			mensaje = sistemaGestion.registrarFuncionario(f);
		}
		labelResultadoFuncionario.setText(mensaje);	
	}
	
	@FXML
	private void modificarFuncionario() {
		String mensaje = "";
		if(txfModificarCedulaFuncionario.getText().equals("")) {
			mensaje = "Por favor escriba la cedula de funcionario a modificar";	
		}else {
			Funcionario f = new Funcionario(txfModificarCedulaFuncionario.getText(), txfModificarNombreFuncionario.getText(), dpModificarFechaNacimientoFuncionario.getEditor().getText(), txfModificarDireccionFuncionario.getText(), txfModificarTelefonoFuncionario.getText());
			if(txfModificarNombreFuncionario.getText().equals("")) {
				f.setNombre(null);
			}
			if(dpModificarFechaNacimientoFuncionario.getEditor().getText().equals("")) {
				f.setFechaNacimiento(null);
			}
			if(txfModificarDireccionFuncionario.getText().equals("")) {
				f.setDireccion(null);
			}
			if(txfModificarTelefonoFuncionario.getText().equals("")) {
				f.setTelefono(null);
			}
			mensaje = sistemaGestion.modificarFuncionario(f);
			System.out.println(mensaje);
		}
		labelResultadoFuncionario.setText(mensaje);
		
	}
	
	@FXML	
	public void borrarFuncionario() {
		String mensaje = "";
		if(txfEliminarCedulaFuncionario.getText().equals("")) {
			mensaje = "Por favor escriba la cedula de funcionario a eliminar";	
		}else {
			mensaje = sistemaGestion.borrarFuncionario(txfEliminarCedulaFuncionario.getText());
		}
		labelResultadoFuncionario.setText(mensaje);
	}
	
	
	@FXML
	public void crearProducto() {
		String mensaje;
		if(txfCrearCodigoProducto.getText().equals("")) {
			mensaje = "Por favor esciba el codigo del producto";
		}else {
			int n = -1;
			String selection = mbCrearTipoProducto.getSelectionModel().getSelectedItem();
			if(selection.equals("Servicio de Voz")) {
				n = 1;
			}else if(selection.equals("Servicio de Datos")) {
				n = 2;
			}else if(selection.equals("Servicio Integrado")) {
				n = 3;
			}
			
			Producto p = new Producto(txfCrearCodigoProducto.getText(), txfCrearDescripcionProducto.getText(),n);
			
			if(txfCrearDescripcionProducto.getText().equals("")) {
				p.setDescripcion(null);
			}
			
			mensaje = sistemaGestion.crearProducto(p);
		}
		labelResultadoProducto.setText(mensaje);	
	}
	
	@FXML
	public void modificarProducto() {
		String mensaje;
		if(txfModificarCodigoProducto.getText().equals("")) {
			mensaje = "Por favor esciba el codigo del producto";
		}else {
			int n = -1;
			String selection = mbModificarTipoProducto.getSelectionModel().getSelectedItem();
			if(selection.equals("Servicio de Voz")) {
				n = 1;
			}else if(selection.equals("Servicio de Datos")) {
				n = 2;
			}else if(selection.equals("Servicio Integrado")) {
				n = 3;
			}
			
			Producto p = new Producto(txfModificarCodigoProducto.getText(), txfModificarDescripcionProducto.getText(),n);
			
			if(txfModificarDescripcionProducto.getText().equals("")) {
				p.setDescripcion(null);
			}
			
			mensaje = sistemaGestion.modificarProducto(p);
		}
		labelResultadoProducto.setText(mensaje);	
	}
	
	@FXML
	public void asignarSolicitudAFuncionario(ActionEvent e) {
		try {

			Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{CALL PKASIGNACIONNIVEL2.realizarAsignacion(?,?,?,?,?,?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.setDate(1, new java.sql.Date(System.currentTimeMillis()));
			stmt.setString(2,txtFuncionarioCedula.getText());

			stmt.setInt(3,Integer.parseInt(txtSolicitudCodigo.getText().trim()));

			stmt.setNull(4, java.sql.Types.DATE);
			stmt.setNull(5, java.sql.Types.VARCHAR);
			stmt.setNull(6, java.sql.Types.CHAR);

			Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
			alert.setHeaderText("Succeded!");
			alert.getDialogPane().setContentText("Asignación con éxito");
			alert.showAndWait();
			//("Asignacion con exito");
			stmt.execute();
		}catch(SQLException ex) {
			showErrorMessage("error en la base: "+ex.getMessage());
		}
	}
	
	public void atenderSolicitud (ActionEvent e) {
		try {
			Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
			String query = "{? = call pkAtencionNivel2.fTipoSolicitud(?)}";
			CallableStatement stmt = conn.prepareCall(query);
			stmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			try {
				int toPass = Integer.parseInt(txtCodigoSolicitud.getText());
				stmt.setInt(2, toPass);
				stmt.execute();
				String type = stmt.getString(1);
				System.out.println("TIPO " + type);
				type=type.toUpperCase();
				switch (type) {
				case "REPORTEDANIOS":
					String accepted = cbAprobado.isSelected() ? "ATENIDA" : "ANULADA";
					conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
					query = "{CALL PKATENCIONNIVEL2.pAtenderSolicitudDanio(?,?,?,?)}";
					stmt = conn.prepareCall(query);
					stmt.setString(1, txtCodigoFuncionario.getText());
					stmt.setInt(2, toPass);
					stmt.setString(3, txtComentarioFuncionario.getText());
					stmt.setString(4, accepted);
					stmt.execute();
					break;

				case "RECLAMO":
					accepted = cbAprobado.isSelected() ? "ATENIDA" : "ANULADA";
					conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
					query = "{CALL PKATENCIONNIVEL2.pAtenderSolicitudReclamo(?,?,?,?)}";
					stmt = conn.prepareCall(query);
					stmt.setString(1, txtCodigoFuncionario.getText());
					stmt.setInt(2, toPass);
					stmt.setString(3, txtComentarioFuncionario.getText());
					stmt.setString(4, accepted);
					stmt.execute();
					break;
					
				case "CREACION":
					System.out.println("HOli jejejje");
					accepted = cbAprobado.isSelected() ? "ATENIDA" : "ANULADA";
					conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
					query = "{CALL PKATENCIONNIVEL2.pAtenderSolicitudCreacion(?,?,?)}";
					stmt = conn.prepareCall(query);
					stmt.setString(1, txtCodigoFuncionario.getText());
					stmt.setInt(2, toPass);
					stmt.setString(3, txtComentarioFuncionario.getText());
					stmt.execute();
					System.out.println("Chau jejejjej");
					break;
					
				case "CANCELACIONPRODUCTO":
					accepted = cbAprobado.isSelected() ? "ATENIDA" : "ANULADA";
					conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
					query = "{CALL PKATENCIONNIVEL2.pAtenderSolicitudRetiro(?,?,?)}";
					stmt = conn.prepareCall(query);
					stmt.setString(1, txtCodigoFuncionario.getText());
					stmt.setInt(2, toPass);
					stmt.setString(3, txtComentarioFuncionario.getText());
					stmt.execute();
					break;
				}
			} catch (NumberFormatException e2) {
				showErrorMessage("El codigo del producto debe de ser un entero");
			}
		} catch (SQLException e1) {
			showErrorMessage(e1.getMessage());
			e1.printStackTrace();
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
		btRegistrarSolReclamo.setOnAction(value -> {
			try {
				Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKREGISTRONIVEL2.pRegistrarSolicitudReclamo(?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfRegistrarCeduCliSolicitud.getText());
				stmt.setString(2,txfRegistrarCodProdSolicitud.getText());
				stmt.setString(3,txfRegistrarDescripSolicitud.getText());
				stmt.execute();
			}catch(SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btRegistrarSolCreacion.setOnAction(value -> {
			try {
				Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKREGISTRONIVEL2.pRegistrarSolicitudCreacion(?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfRegistrarCeduCliSolicitud.getText());
				stmt.setString(2,txfRegistrarCodProdSolicitud.getText());
				stmt.setString(3,txfRegistrarDescripSolicitud.getText());
				stmt.execute();
			}catch(SQLException e) {
				showErrorMessage(e.getMessage());
			}
		});
		btRegistrarSolCancProd.setOnAction(value -> {
			try {
				Connection conn = OracleConnection.returnConnection(OracleConnection.USER,OracleConnection.PASS);
				String query = "{CALL PKREGISTRONIVEL2.pRegistrarSolicitudCancelacionProducto(?,?,?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfRegistrarCeduCliSolicitud.getText());
				stmt.setString(2,txfRegistrarCodProdSolicitud.getText());
				stmt.setString(3,txfRegistrarDescripSolicitud.getText());
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
