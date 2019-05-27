CREATE OR REPLACE PACKAGE pkFuncionarioNivel2 AS
	PROCEDURE registrarFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
	PROCEDURE modificarFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
	PROCEDURE borrarFuncionario (ivCedula funcionario.cedula%TYPE);
END pkFuncionarioNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkFuncionarioNivel2 AS
		PROCEDURE registrarFuncionario (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE) IS
        cantidad NUMBER(1);	
        BEGIN
            SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				RAISE_APPLICATION_ERROR(-20001,'El funcionario con cedula ' || ivCedula || ' ya existe');
			ELSE
				pkFuncionario.pInsertar(ivCedula, ivNombre, ivFechaNacimiento, ivDireccion, ivTelefono);
            END IF;
		END registrarFuncionario;
	
		PROCEDURE modificarFuncionario(ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE) IS
		cantidad NUMBER(1);
		oldRow funcionario%rowtype;
		vNombre funcionario.nombre%TYPE;
		vFechaNacimiento funcionario.fechanacimiento%TYPE;
		vDireccion funcionario.direccion%TYPE;
		vTelefono funcionario.telefono%TYPE;
		BEGIN 
            SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				oldRow := pkFuncionario.fConsultar(ivCedula);
				IF  ivNombre IS NULL THEN
					vNombre := oldRow.nombre;
				ELSE
					vNombre := ivNombre;
				END IF;
				
				IF ivFechaNacimiento IS NULL THEN
					vFechaNacimiento := oldRow.fechanacimiento;
				ELSE
					vFechaNacimiento := ivFechaNacimiento;
				END IF;
				
				IF ivDireccion IS NULL THEN
					vDireccion := oldRow.direccion;
				ELSE 
					vDireccion := ivDireccion;
				END IF;
				
				IF ivTelefono IS NULL THEN 
					vTelefono := oldRow.telefono;
				ELSE
					vTelefono := ivTelefono;
				END IF;
				pkFuncionario.pModificar(ivCedula, vNombre, vFechaNacimiento, vDireccion, vTelefono);
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El funcionario con cedula ' || ivCedula ||' no existe');
			END IF;
		END modificarFuncionario;
		
		PROCEDURE borrarFuncionario(ivCedula funcionario.cedula%TYPE) IS
		cantidad NUMBER(1);
		BEGIN
			SELECT COUNT(*) INTO cantidad FROM funcionario WHERE cedula = ivCedula;
			IF cantidad = 1 THEN
				pkFuncionario.pBorrar(ivCedula);
			
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El funcionario con cedula ' || ivCedula ||' no existe');
			END IF;
		END borrarFuncionario;
END pkFuncionarioNivel2;
	