CREATE OR REPLACE PACKAGE pkSolCreacion AS -- spec
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivTipo solicitud.tipo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE);
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE);
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivTipo solicitud.tipo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE);
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2;
END pkSolCreacion;
/
CREATE OR REPLACE PACKAGE BODY pkSolCreacion AS
--insertar
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivTipo solicitud.tipo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE) IS
BEGIN
INSERT INTO solicitud VALUES (ivCodigo,ivEstado,ivDescripcion,ivClienteCedula,ivProductoCodigo,ivFechaCracion, ivTipo);
INSERT INTO solcreacion VALUES (ivCodigo);
END pInsertar;

--borrar
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE) IS
BEGIN
DELETE FROM solcreacion WHERE solicitud_codigo = ivCodigo;
DELETE FROM solicitud WHERE codigo = ivCodigo;
END pBorrar;

--modificar
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivTipo solicitud.tipo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE) IS
BEGIN
UPDATE solicitud 
SET estado=ivEstado,descripcion=ivDescripcion,cliente_cedula=ivClienteCedula,producto_codigo=ivProductoCodigo,fechacreacion=ivFechaCracion, tipo=ivTipo 
WHERE codigo = ivCodigo;
END pModificar;

--consultar
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2 IS
vCodigo solicitud.codigo%TYPE;
vEstado solicitud.estado%TYPE;
vDescripcion solicitud.descripcion%TYPE;
vClienteCedula solicitud.cliente_cedula%TYPE;
vProductoCodigo solicitud.producto_codigo%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
ovconsulta VARCHAR2(5000);
BEGIN
SELECT codigo,estado,descripcion,cliente_cedula,producto_codigo,fechacreacion
    INTO vCodigo,vEstado,vDescripcion,vClienteCedula,vProductoCodigo,vFechaCreacion
    FROM solcreacion 
    INNER JOIN solicitud 
    ON solicitud.codigo=solcreacion.solicitud_codigo 
    WHERE codigo=ivCodigo;
ovconsulta:= vCodigo||','||vEstado||','||vDescripcion||','||vClienteCedula||','||vProductoCodigo||','||vFechaCreacion;
RETURN ovconsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe solicitacion de creación de producto con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkSolCreacion;