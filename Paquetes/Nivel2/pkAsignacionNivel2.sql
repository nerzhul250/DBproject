CREATE OR REPLACE PACKAGE pkAsignacionNivel2 AS -- spec
	PROCEDURE realizarAsignacion (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivAtendido asignacion.atendido%TYPE);
	FUNCTION fRetornarFuncionarioDisponible RETURN funcionario.cedula%TYPE;
END pkAsignacionNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkAsignacionNivel2 AS
	PROCEDURE realizarAsignacion (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivAtendido asignacion.atendido%TYPE) IS
	BEGIN
        IF EXISTS (SELECT codigo FROM solicitud WHERE codigo= ivSolicitudCodigo) AND EXISTS(SELECT cedula FROM funcionario WHERE cedula=ivFuncionarioCedula) AND NOT EXISTS (SELECT funcionarioCedula FROM asignacion WHERE funcionario_cedula= ivfuncionarioCedula AND solicitud_codigo= ivSolicitudCodigo) THEN   
          pkAsignacion.pInsertar(ivFechaAsignacion, ivFuncionarioCedula,ivSolicitudCodigo,ivFechaAtencion,ivcomentariosfuncionario,ivAtendido);
        ELSE
            RAISE_APPLICATION_ERROR(-20001,"funcionario no existe o usuario no existe o asignación ya hecha");
        END IF;
	END realizarAsignacion;
    
    FUNCTION fRetornarFuncionarioDisponible RETURN funcionario.cedula%TYPE IS
    ovCedula funcionario.cedula%TYPE;
    vCant integer;
    Cursor c1 IS
    SELECT cedula, COUNT(*)
        FROM asignacion
        GROUP BY cedula
        HAVING COUNT(*) < 3
        ORDER BY COUNT(*);
    BEGIN
        OPEN c1;
        FETCH c1 INTO ovCedula, vCant;
        
        CLOSE c1;
        RETURN ovCedula;
    END fRetornarFuncionarioDisponible;
END pkAsignacionNivel2;