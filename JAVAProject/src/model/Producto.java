package model;

public class Producto {
	
private String codigo;

private String descripcion;

private String tipo;

public Producto(String codigo, String descripcion, String tipo) {
	super();
	this.codigo = codigo;
	this.descripcion = descripcion;
	this.tipo = tipo;
}

public String getCodigo() {
	return codigo;
}

public void setCodigo(String codigo) {
	this.codigo = codigo;
}

public String getDescripcion() {
	return descripcion;
}

public void setDescripcion(String descripcion) {
	this.descripcion = descripcion;
}

public String getTipo() {
	return tipo;
}

public void setTipo(String tipo) {
	this.tipo = tipo;
}



}
