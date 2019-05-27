CREATE OR REPLACE PACKAGE pkProducto AS -- spec
	PROCEDURE pInsertar (ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE);
	PROCEDURE pBorrar(ivCodigo producto.codigo%TYPE);
	PROCEDURE pModificar(ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE);
	FUNCTION fConsultar (ivCodigo producto.codigo%TYPE) RETURN producto%rowtype;
END pkProducto;
/
CREATE OR REPLACE PACKAGE BODY pkProducto AS
	PROCEDURE pInsertar (ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE) IS
	BEGIN
		INSERT INTO producto VALUES (ivCodigo, ivDescripcion,ivTipo);
	END pInsertar;
	
	PROCEDURE pBorrar(ivCodigo producto.codigo%TYPE) IS
	BEGIN
		DELETE FROM producto WHERE producto.codigo = ivCodigo;
	END pBorrar;
	
	PROCEDURE pModificar(ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE) IS
	BEGIN
		UPDATE producto SET codigo= ivCodigo, descripcion = ivDescripcion, tipo = ivTipo WHERE codigo= ivCodigo;
	END pModificar;
	
	FUNCTION fConsultar (ivCodigo producto.codigo%TYPE) RETURN producto%rowtype IS ovConsulta producto%rowtype;
	BEGIN
		SELECT * INTO  ovConsulta FROM producto WHERE codigo = ivCodigo;
		return ovConsulta;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20001,'Error, no existe el producto solicitado');
			WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
	END fConsultar;
END pkProducto;