package model;

public class TipoAnomalia {
	private String id;
	private String descripcion;
	
	public TipoAnomalia(String id, String descripcion) {
		super();
		this.id = id;
		this.descripcion = descripcion;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
}
