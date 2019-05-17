package application;

import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
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
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		setUpTipoAnomaliaOps();
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
				stmt.setString(2,txfModificarDescripcionAnomalia.getText());
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
