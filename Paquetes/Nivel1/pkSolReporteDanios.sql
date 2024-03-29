CREATE OR REPLACE PACKAGE pkSolReporteDanios AS -- spec
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE,ivTipo solicitud.tipo%TYPE,ivTipoAnomalia_Id solreportedanios.tipoanomalia_id%TYPE);
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE);
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE,ivTipo solicitud.tipo%TYPE,ivTipoAnomalia_Id solreportedanios.tipoanomalia_id%TYPE);
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2;
END pkSolReporteDanios;
/
CREATE OR REPLACE PACKAGE BODY pkSolReporteDanios AS
-- insertar
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE,ivTipo solicitud.tipo%TYPE,ivTipoAnomalia_Id solreportedanios.tipoanomalia_id%TYPE) IS
BEGIN
INSERT INTO solicitud VALUES (ivCodigo,ivEstado,ivDescripcion,ivClienteCedula,ivProductoCodigo,ivFechaCreacion,ivTipo);
INSERT INTO solreportedanios VALUES (ivCodigo,ivTipoAnomalia_Id);
END pInsertar;
-- borrar
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE) IS
BEGIN
DELETE FROM solreportedanios WHERE solicitud_codigo = ivCodigo;
DELETE FROM solicitud WHERE codigo = ivCodigo;
END pBorrar;
-- modificar
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE,ivTipo solicitud.tipo%TYPE,ivTipoAnomalia_Id solreportedanios.tipoanomalia_id%TYPE) IS
BEGIN
UPDATE solicitud SET estado=ivEstado,descripcion=ivDescripcion,cliente_cedula=ivClienteCedula,producto_codigo=ivProductoCodigo,fechacreacion=ivfechacreacion,tipo=ivTipo WHERE codigo = ivCodigo;
UPDATE solreportedanios SET tipoanomalia_id=ivTipoAnomalia_Id WHERE solicitud_codigo = ivCodigo;
END pModificar;
-- consultar
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2 IS
vCodigo solicitud.codigo%TYPE;
vEstado solicitud.estado%TYPE;
vDescripcion solicitud.descripcion%TYPE;
vClienteCedula solicitud.cliente_cedula%TYPE;
vProductoCodigo solicitud.producto_codigo%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vTipoAnomalia_Id solreportedanios.tipoanomalia_id%TYPE;
ovconsulta VARCHAR2(5000);
BEGIN
SELECT codigo,estado,descripcion,cliente_cedula,producto_codigo,tipoanomalia_id,fechacreacion 
into vCodigo,vEstado,vDescripcion,vClienteCedula,vProductoCodigo,vTipoAnomalia_Id ,vFechaCreacion
FROM solreportedanios INNER JOIN solicitud ON solicitud.codigo=solreportedanios.solicitud_codigo WHERE codigo=ivCodigo;
ovconsulta:= vCodigo||','||vEstado||','||vDescripcion||','||vClienteCedula||','||vProductoCodigo||','||vFechaCreacion||','||vTipoAnomalia_Id;
RETURN ovconsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe solicito de reporte de danios con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkSolReporteDanios;