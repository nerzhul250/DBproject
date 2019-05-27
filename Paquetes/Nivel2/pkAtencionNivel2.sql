CREATE OR REPLACE PACKAGE pkAtencionNivel2 AS --spec
PROCEDURE pAtenderSolicitudCreacion (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE);
    
PROCEDURE pAtenderSolicitudRetiro (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE);
    
PROCEDURE pAtenderSolicitudReclamo (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE);

PROCEDURE pAtenderSolicitudDanio (ivCedulaFuncionario funcionario.cedula%TYPE, ivCodigoSolicitud solicitud.codigo%TYPE, 
    ivComentariosFuncionario asignacion.ComentariosFuncionario%TYPE, ivRespuesta solicitud.estado%TYPE);

PROCEDURE pAutoAccept;

FUNCTION fTipoSolicitud(ivSolicitudCodigo solicitud.codigo%TYPE) RETURN solicitud.tipo%TYPE;

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
    (SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL)
    where id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCreacion.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    pkSolCreacion.pModificar (ivCodigoSolicitud ,'ATENDIDA', vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'CREACION', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
    pkServicioPrestado.pInsertar(vCodigoProducto, vCedulaCliente, vPrimerDiaSigMes, NULL);
    
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error, la solicitud especificada no está asignada a ese funcionario ' || VCedulaCliente);
    
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
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolCancelacionProducto.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolCancelacionProducto.pModificar (ivCodigoSolicitud ,'ATENDIDA', vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'CANCELACION', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error, la solicitud especificada no está asignada a ese funcionario');
    
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
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReclamo.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolReclamo.pModificar (ivCodigoSolicitud ,ivRespuesta, vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'RECLAMO', vFechaCreacion);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error, la solicitud especificada no está asignada a ese funcionario');
    
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
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 4;
    
    SELECT data INTO vDescripcionSolicitud
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
     SELECT data INTO vCodigoProducto
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 5;
    
    SELECT TO_DATE(data) INTO vFechaCreacion
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 6;
    
    SELECT data INTO vTipoAnomalia
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 7;
    
    SELECT last_day (sysdate) +1 INTO vPrimerDiaSigMes
    FROM dual;
    
    SELECT SYSDATE into vSysDate
    FROM dual;
    
    SELECT TO_DATE(data) INTO vFechaInicio
    FROM ((SELECT LEVEL AS id, REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) AS data
    FROM dual
    CONNECT BY REGEXP_SUBSTR(pkSolReporteDanios.fConsultar(vCodigoSolicitud), '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE id = 3;
    
    
    pkServicioPrestado.pModificar(vCodigoProducto, vCedulaCliente, vFechaInicio, vSysDate);
    
    pkSolReporteDanios.pModificar (ivCodigoSolicitud ,ivRespuesta, vDescripcionSolicitud, vCedulaCliente, vCodigoProducto, 'DANIO', vFechaCreacion, vTipoAnomalia);
    
    pkAsignacion.pModificar(vFechaAsignacion, ivCedulaFuncionario, ivCodigoSolicitud, vSysDate, ivComentariosFuncionario, 'T');
    
EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error, la solicitud especificada no está asignada a ese funcionario');
    
END pAtenderSolicitudDanio;

FUNCTION fTipoSolicitud(ivSolicitudCodigo solicitud.codigo%TYPE) 
RETURN solicitud.tipo%TYPE IS ovTipoSolicitud solicitud.tipo%TYPE; 
BEGIN
SELECT TIPO into ovTipoSolicitud
FROM SOLICITUD
WHERE CODIGO = ivSolicitudCodigo;
RETURN ovTipoSolicitud;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe una solicitud con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fTipoSolicitud;

PROCEDURE pAutoAccept IS
    CURSOR toModifyReclamo IS
        SELECT Asignacion.FechaAsignacion, Asignacion.Solicitud_Codigo, Asignacion.Funcionario_Cedula
        FROM Asignacion INNER JOIN SOLICITUD ON Asignacion.Solicitud_Codigo = Solicitud.Codigo
        WHERE Asignacion.FechaAsignacion - (SELECT SYSDATE
        FROM dual) < (SELECT VALOR FROM PARAMETROS WHERE Parametros.Codigo = '16')
        AND (SOLICITUD.TIPO = 'reclamo') AND SOLICITUD.ESTADO = 'Asignado';
        
    CURSOR toModifyDanio IS
        SELECT Asignacion.FechaAsignacion, Asignacion.Solicitud_Codigo, Asignacion.Funcionario_Cedula
        FROM Asignacion INNER JOIN SOLICITUD ON Asignacion.Solicitud_Codigo = Solicitud.Codigo
        WHERE Asignacion.FechaAsignacion - (SELECT SYSDATE
        FROM dual) < (SELECT VALOR FROM PARAMETROS WHERE Parametros.Codigo = '16')
        AND (SOLICITUD.TIPO = 'reporteDanios') AND SOLICITUD.ESTADO = 'Asignado';
        
    BEGIN
    FOR Asig IN toModifyReclamo
    LOOP
    
        pkAtencionNivel2.pAtenderSolicitudReclamo (Asig.Funcionario_Cedula, Asig.Solicitud_Codigo, 
    'ATENDIDA AUTOMATICAMENTE POR EL SISTEMA', 'ATENDIDA');
    END LOOP;
    
    FOR Asig IN toModifyDanio
    LOOP
    
        pkAtencionNivel2.pAtenderSolicitudDanio (Asig.Funcionario_Cedula, Asig.Solicitud_Codigo, 
    'ATENDIDA AUTOMATICAMENTE POR EL SISTEMA', 'ATENDIDA');
    END LOOP;
        
END pAutoAccept;

END pkAtencionNivel2;

