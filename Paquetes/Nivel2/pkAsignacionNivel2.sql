CREATE OR REPLACE PACKAGE pkAsignacionNivel2 AS -- spec
	PROCEDURE realizarAsignacion (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivAtendido asignacion.atendido%TYPE);
	FUNCTION fRetornarFuncionarioDisponible RETURN funcionario.cedula%TYPE;
    PROCEDURE cambiarEstadoSolicitud (ivCodigo solicitud.codigo%TYPE, ivestado solicitud.estado%TYPE);
    PROCEDURE asignacionProgramada; 
END pkAsignacionNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkAsignacionNivel2 AS

    PROCEDURE cambiarEstadoSolicitud (ivCodigo solicitud.codigo%TYPE, ivestado solicitud.estado%TYPE) IS
    BEGIN
        UPDATE solicitud
        SET estado = ivestado
        WHERE codigo = ivCodigo;
    END cambiarEstadoSolicitud;
    
   PROCEDURE asignacionProgramada IS
    Cursor c1 IS
        SELECT codigo
        FROM solicitud
        WHERE estado= 'Pendiente'
        ORDER BY SYSDATE- fechacreacion;
   
     Cursor c2 IS
        SELECT cedula 
        FROM funcionario
        WHERE (SELECT COUNT(*)
        FROM asignacion
        WHERE asignacion.funcionario_cedula= cedula)<3;
        codigoSol solicitud.codigo%TYPE;
   BEGIN
     dbms_output.put_line( 'STARTING' ); 
        OPEN c1;
        FOR fun in c2
        LOOP
            FETCH c1 INTO codigoSol;
            EXIT WHEN c1%notfound;
             dbms_output.put_line( fun.cedula ); 
             
            pkAsignacionnivel2.realizarAsignacion(SYSDATE, fun.cedula, codigoSol,null,null,null);
            cambiarEstadoSolicitud(codigosol,'Asignado');
        END LOOP;
        CLOSE c1;
   END asignacionProgramada;
   
   
	PROCEDURE realizarAsignacion (ivFechaAsignacion asignacion.fechaasignacion%TYPE, ivFuncionarioCedula asignacion.funcionario_cedula%TYPE, ivSolicitudCodigo asignacion.solicitud_codigo%TYPE, ivFechaAtencion asignacion.fechaatencion%TYPE, ivComentariosFuncionario asignacion.comentariosfuncionario%TYPE, ivAtendido asignacion.atendido%TYPE) IS
	numRegistrosSolicitud integer;
    numRegistrosFuncionarios integer;
    numRegistrosAsignacion integer;
    ex_custom EXCEPTION;
     PRAGMA EXCEPTION_INIT( ex_custom, -20001 );
    BEGIN
    SELECT COUNT(*) INTO numRegistrosSolicitud FROM solicitud WHERE codigo= ivSolicitudCodigo;
    SELECT COUNT(*)INTO numRegistrosFuncionarios FROM funcionario WHERE cedula=ivFuncionarioCedula;
    SELECT COUNT(*) INTO numRegistrosAsignacion FROM asignacion WHERE funcionario_cedula= ivfuncionarioCedula AND solicitud_codigo= ivSolicitudCodigo;
        IF numRegistrosSolicitud =1 AND numRegistrosFuncionarios =1 AND numRegistrosAsignacion=0 THEN   
          pkAsignacion.pInsertar(ivFechaAsignacion, ivFuncionarioCedula,ivSolicitudCodigo,ivFechaAtencion,ivcomentariosfuncionario,ivAtendido);
          cambiarEstadoSolicitud(ivSolicitudCodigo, 'Asignado');
            ELSE
        RAISE ex_custom;

        END IF;
    EXCEPTION 
        WHEN ex_custom THEN
            RAISE_APPLICATION_ERROR(-20002,'funcionario no existe o usuario no existe o asignacion ya hecha');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002,'Error desconocido'||SQLERRM||SQLCODE);
	END realizarAsignacion;
    
    FUNCTION fRetornarFuncionarioDisponible RETURN funcionario.cedula%TYPE IS
    ovCedula funcionario.cedula%TYPE;
    vCant integer;
    Cursor c1 IS
    SELECT funcionario_cedula, COUNT(*)
        FROM asignacion 
        GROUP BY funcionario_cedula
        HAVING COUNT(*) < 3
        ORDER BY COUNT(*);
    Cursor c2 IS
        SELECT cedula 
        FROM funcionario
        WHERE (SELECT COUNT(*)
        FROM asignacion
        WHERE asignacion.funcionario_cedula= cedula)<3;
    BEGIN
        OPEN c2;
        FETCH c2 INTO ovCedula;
        
        CLOSE c2;
        RETURN TRIM(ovCedula);
    END fRetornarFuncionarioDisponible;
END pkAsignacionNivel2;