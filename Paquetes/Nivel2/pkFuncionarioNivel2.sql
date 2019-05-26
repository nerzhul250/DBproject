CREATE OR REPLACE PACKAGE pkFuncionarioNivel2 AS
	PROCEDURE registrarCrearFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
	PROCEDURE modificarFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
	PROCEDURE borrarFuncionario (ivCedula funcionario.cedula%TYPE);
END pkFuncionarioNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkFuncionarioNivel2 AS
		PROCEDURE registrarCrearFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE) IS
        cantidad NUMBER(1);
        BEGIN
            SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				RAISE_APPLICATION_ERROR(-20001,'El funcionario ya existe');
			ELSE
				pkFuncionario.pInsertar(ivCedula, ivNombre, ivFechaNacimiento, ivDireccion, ivTelefono);
            END IF;
		END registrarCrearFuncionario;
	
		PROCEDURE modificarFuncionario(ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE) IS
		cantidad NUMBER(1);
		BEGIN 
            SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				pkFuncionario.pModificar(ivCedula, ivNombre, ivFechaNacimiento, ivDireccion, ivTelefono);
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El funcionario no existe');
			END IF;
		END modificarFuncionario;
		
		PROCEDURE borrarFuncionario(ivCedula funcionario.cedula%TYPE) IS
		cantidad NUMBER(1);
		BEGIN
			SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				pkFuncionario.pBorrar(ivCedula);
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El funcionario no existe');
			END IF;
		END borrarFuncionario;
END pkFuncionarioNivel2;
	