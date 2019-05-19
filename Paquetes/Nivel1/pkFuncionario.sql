CREATE OR REPLACE PACKAGE pkFuncionario AS 
PROCEDURE pInsertar (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
PROCEDURE pBorrar (ivCedula funcionario.cedula%TYPE);
PROCEDURE pModificar (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
FUNCTION fConsultar (ivCedula funcionario.cedula%TYPE) RETURN funcionario%rowtype;
END pkFuncionario;
/
CREATE OR REPLACE PACKAGE BODY pkFuncionario AS
-- insertar
PROCEDURE pInsertar (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
BEGIN
INSERT INTO funcionario VALUES(ivCedula, ivNombre, ivFechaNacimiento, ivDireccion, ivTelefono);
END pInsertar;
--borrar
PROCEDURE pBorrar (ivCedula funcionario.cedula%TYPE);
BEGIN
DELETE FROM funcionario WHERE  funcionario.cedula = ivCedula;
END pBorrar;
--modificar
PROCEDURE pModificar (ivCedula funcionario.cedula%TYPE, ivNombre funcionario.nombre%TYPE, ivFechaNacimiento funcionario.fechanacimiento%TYPE, ivDireccion funcionario.direccion%TYPE, ivTelefono funcionario.telefono%TYPE);
BEGIN
UPDATE funcionario SET nombre = ivNombre, fechanacimiento = ivFechaNacimiento, direccion = ivDireccion, telefono = ivTelefono WHERE cedula = ivCedula;
END pModificar;
-- consultar
FUNCTION fConsultar (ivCedula funcionario.cedula%TYPE) RETURN funcionario%rowtype IS ovConsulta funcionario%rowtype;
BEGIN
SELECT * INTO ovConsulta FROM funcionario WHERE cedula = ivCedula;
RETURN ovConsulta;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe una asignacion con ese id');
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkFuncionario;
