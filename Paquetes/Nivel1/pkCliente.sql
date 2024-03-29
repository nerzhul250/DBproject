CREATE OR REPLACE PACKAGE pkCliente AS -- spec
	PROCEDURE pInsertar (ivCedula cliente.cedula%TYPE, 	ivNombre cliente.nombre%TYPE, ivfechaNacimiento cliente.fechanacimiento%TYPE, ivdireccion cliente.direccion%TYPE, ivTelefono cliente.telefono%TYPE);
	PROCEDURE pBorrar(ivCedula cliente.cedula%TYPE);
	PROCEDURE pModificar(ivCedula cliente.cedula%TYPE, 	ivNombre cliente.nombre%TYPE, ivfechaNacimiento cliente.fechanacimiento%TYPE, ivdireccion cliente.direccion%TYPE, ivTelefono cliente.telefono%TYPE);
	FUNCTION fConsultar (ivCedula cliente.cedula%TYPE) RETURN cliente%rowtype;
END pkCliente;
/
CREATE OR REPLACE PACKAGE BODY pkCliente AS
	
	PROCEDURE pInsertar (ivCedula cliente.cedula%TYPE, 	ivNombre cliente.nombre%TYPE, ivfechaNacimiento cliente.fechanacimiento%TYPE, ivdireccion cliente.direccion%TYPE, ivTelefono cliente.telefono%TYPE) IS
	BEGIN
		INSERT INTO cliente VALUES (ivCedula, ivNombre, ivfechaNacimiento, ivdireccion, ivTelefono);
	END pInsertar;

	PROCEDURE pBorrar(ivCedula cliente.cedula%TYPE) IS
	BEGIN 	
		DELETE FROM cliente WHERE cedula= ivCedula;
	END pBorrar;
	
	PROCEDURE pModificar(ivCedula cliente.cedula%TYPE, 	ivNombre cliente.nombre%TYPE, ivfechaNacimiento cliente.fechanacimiento%TYPE, ivdireccion cliente.direccion%TYPE, ivTelefono cliente.telefono%TYPE) IS
	BEGIN
		UPDATE cliente SET cedula= ivCedula, nombre = ivNombre, fechanacimiento= ivfechaNacimiento, direccion= ivdireccion, telefono = ivTelefono WHERE cedula= ivCedula;
	END pModificar;
	
	FUNCTION fConsultar (ivCedula cliente.cedula%TYPE) RETURN cliente%rowtype IS
		ovConsulta cliente%rowtype;
	BEGIN
		SELECT * INTO ovConsulta
		FROM cliente
		WHERE cedula = ivCedula;
		return ovConsulta;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20001,'Error, no existe el cliente solicitado');
			WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
	END fConsultar;
END pkCliente;