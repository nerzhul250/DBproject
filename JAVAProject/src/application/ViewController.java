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

	@FXML
	private TextField txfDescripcionAnom;
	
	@FXML
	private Button btCrearAnom;
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		btCrearAnom.setOnAction(value-> {
			try {
				Connection conn=OracleConnection.returnConnection("P09551_1_10", "P09551_1_10_20191");
				String query = "{CALL PKGESTIONTABLAS.pRegistrarTipoAnomalia(?)}";
				CallableStatement stmt = conn.prepareCall(query);
				stmt.setString(1,txfDescripcionAnom.getText());
				stmt.execute();
				System.out.println("success!");
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("todosederrumbooo");
			}
		});
	}
}
