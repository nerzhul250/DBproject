CREATE OR REPLACE PACKAGE pkAtencionNivel2 AS --spec
PROCEDURE pAtenderSolicitudCreacion (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE);
    
PROCEDURE pAtenderSolicitudRetiro (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE);
    
PROCEDURE pAtenderSolicitudReclamo (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE);

PROCEDURE pAtenderSolicitudDanio (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE);
END pkAtencionNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkAtencionNivel2 AS --body

PROCEDURE pAtenderSolicitudCreacion (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE) IS

vConsultaAsignacion asignacion%rowtype;
vConsultaSolicitud VARCHAR2(100);
vCodigoSolicitud producto.codigo%TYPE;
vCedulaCliente cliente.cedula%TYPE;
vCodigoProducto servicioPrestado.Producto_codigo%TYPE;
vPrimerDiaSigMes DATE;
vDescripcionSolicitud solicitud.descripcion%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vFechaAsignacion asignacion.fechaasignacion%TYPE;
vSysDate DATE;
BEGIN
    vConsultaAsignacion := pkAsignacion.fConsultar (ivCedulaFuncionario,ivCodigoSolicitud);
    
    vCodigoSolicitud := vConsultaAsignacion.solicitud_codigo;
    
    vFechaAsignacion := vConsultaAsignacion.fechaasignacion;
    
    SELECT data INTO VCedulaCliente
    FROM
    (SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL)
    where id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    pkServicioPrestado.pInsertar(vCodigoProducto, vCedulaCliente, vPrimerDiaSigMes, NULL);
    
    pkSolCreacion.pModificar (ivCodigoSolicitud ,'ATENDIDA', vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'CREACION', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
END pAtenderSolicitudCreacion;


PROCEDURE pAtenderSolicitudRetiro (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE) IS
    
vConsultaAsignacion asignacion%rowtype;
vConsultaSolicitud VARCHAR2(500);
vCodigoSolicitud producto.codigo%TYPE;
vCedulaCliente cliente.cedula%TYPE;
vCodigoProducto servicioPrestado.Producto_codigo%TYPE;
vPrimerDiaSigMes DATE;
vDescripcionSolicitud solicitud.descripcion%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vFechaAsignacion asignacion.fechaasignacion%TYPE;
vSysDate DATE;
vConsultaServicioPrestado VARCHAR2(500);
vFechaInicio DATE;
BEGIN
    vConsultaAsignacion := pkAsignacion.fConsultar (ivCedulaFuncionario,ivCodigoSolicitud);
    
    vCodigoSolicitud := vConsultaAsignacion.solicitud_codigo;
    
    vFechaAsignacion := vConsultaAsignacion.fechaasignacion;
    
    SELECT data INTO vCedulaCliente
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolCancelacionProducto.pModificar (ivCodigoSolicitud ,'ATENDIDA', vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'CANCELACION', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
END pAtenderSolicitudRetiro;


PROCEDURE pAtenderSolicitudReclamo (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE) IS
    
vConsultaAsignacion asignacion%rowtype;
vConsultaSolicitud VARCHAR2(500);
vCodigoSolicitud producto.codigo%TYPE;
vCedulaCliente cliente.cedula%TYPE;
vCodigoProducto servicioPrestado.Producto_codigo%TYPE;
vPrimerDiaSigMes DATE;
vDescripcionSolicitud solicitud.descripcion%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vFechaAsignacion asignacion.fechaasignacion%TYPE;
vSysDate DATE;
vConsultaServicioPrestado VARCHAR2(500);
vFechaInicio DATE;
BEGIN
    vConsultaAsignacion := pkAsignacion.fConsultar (ivCedulaFuncionario,ivCodigoSolicitud);
    
    vCodigoSolicitud := vConsultaAsignacion.solicitud_codigo;
    
    vFechaAsignacion := vConsultaAsignacion.fechaasignacion;
    
    SELECT data INTO vCedulaCliente
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolReclamo.pModificar (ivCodigoSolicitud ,ivRespuesta, vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'RECLAMO', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
    
END pAtenderSolicitudReclamo;

PROCEDURE pAtenderSolicitudDanio (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE) IS
    
vConsultaAsignacion asignacion%rowtype;
vConsultaSolicitud VARCHAR2(500);
vCodigoSolicitud producto.codigo%TYPE;
vCedulaCliente cliente.cedula%TYPE;
vCodigoProducto servicioPrestado.Producto_codigo%TYPE;
vPrimerDiaSigMes DATE;
vDescripcionSolicitud solicitud.descripcion%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vFechaAsignacion asignacion.fechaasignacion%TYPE;
vSysDate DATE;
vConsultaServicioPrestado VARCHAR2(500);
vFechaInicio DATE;
vTipoAnomalia solreportedanios.TIPOANOMALIA_ID%TYPE;
BEGIN
    vConsultaAsignacion := pkAsignacion.fConsultar (ivCedulaFuncionario,ivCodigoSolicitud);
    
    vCodigoSolicitud := vConsultaAsignacion.solicitud_codigo;
    
    vFechaAsignacion := vConsultaAsignacion.fechaasignacion;
    
    SELECT data INTO vCedulaCliente
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT data INTO vTipoAnomalia
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 7;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR('A,B,C,D', '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolReporteDanios.pModificar (ivCodigoSolicitud ,ivRespuesta, vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'DANIO', vFechaCreacion, vTipoAnomalia);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
    
END pAtenderSolicitudDanio;

END pkAtencionNivel2;

