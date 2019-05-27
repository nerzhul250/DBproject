package model;

import java.sql.Date;

public class Funcionario {
	
	private String cedula;
	
	private String nombre;
	
	private String fechaNacimiento;
	
	private String direccion;
	
	private String telefono;

	public Funcionario(String cedula, String nombre, String fechaNacimiento, String direccion, String telefono) {
		super();
		this.cedula = cedula;
		this.nombre = nombre;
		this.fechaNacimiento = fechaNacimiento;
		this.direccion = direccion;
		this.telefono = telefono;
	}

	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	
	
	

}
