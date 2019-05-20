CREATE OR REPLACE PACKAGE pkAsignacion AS
PROCEDURE pInsertar (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivAtendido asignacion.atendido%TYPE);
PROCEDURE pBorrar (ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE);
PROCEDURE pModificar (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivpAtendido asignacion.atendido%TYPE);
FUNCTION fConsultar(ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE) RETURN asignacion%rowtype;
END pkAsignacion;
/
CREATE OR REPLACE PACKAGE BODY pkAsignacion  AS
-- insertar
PROCEDURE pInsertar (ivFechaAsignacion asignacion.fechaasignacion%TYPE,ivFuncionarioCedula asignacion.funcionario_cedula%TYPE,ivSolicitudCodigo asignacion.solicitud_codigo%TYPE,ivFechaAtencion asignacion.fechaatencion%TYPE,ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE,ivAtendido asignacion.atendido%TYPE) IS
BEGIN
INSERT INTO asignacion VALUES(ivFechaAsignacion,ivFuncionarioCedula,ivSolicitudCodigo,ivFechaAtencion,ivComentariosFuncionario,ivAtendido);
END pInsertar;

--borrar
PROCEDURE pBorrar (ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE) IS
BEGIN
DELETE FROM asignacion WHERE asignacion.funcionario_cedula = ivFuncionarioCedula AND asignacion.solicitud_codigo = ivSolicitudCodigo;
END pBorrar;

--modificar
PROCEDURE pModificar (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivpAtendido asignacion.atendido%TYPE) IS
BEGIN
UPDATE asignacion SET fechaasignacion = ivFechaAsignacion, fechaatencion = ivFechaAtencion, comentariosfuncionario = ivComentariosFuncionario, atendido = ivpAtendido WHERE funcionario_cedula = ivFuncionarioCedula AND solicitud_codigo = ivSolicitudCodigo;
END pModificar;

--consultar
FUNCTION fConsultar (ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE) 
RETURN asignacion%rowtype IS ovConsulta asignacion%rowtype;
BEGIN
SELECT * into ovConsulta 
FROM asignacion WHERE funcionario_cedula = ivFuncionarioCedula AND solicitud_codigo = ivSolicitudCodigo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe una asignacion con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;

END pkAsignacion;




