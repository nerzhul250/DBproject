CREATE OR REPLACE PACKAGE pkSolModificacionProducto AS -- spec
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivFechaCreacion solicitud.fechaCreacion%TYPE, ivProductoCodigo2 solicitud.producto_codigo%TYPE);
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE);
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE, ivProductoCodigo2 solicitud.producto_codigo%TYPE);
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2;
END pkSolModificacionProducto;
/
CREATE OR REPLACE PACKAGE BODY pkSolModificacionProducto AS
--insertar
PROCEDURE pInsertar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivFechaCreacion solicitud.fechaCreacion%TYPE, ivProductoCodigo2 solicitud.producto_codigo%TYPE) IS
BEGIN
INSERT INTO solicitud VALUES (ivCodigo,ivEstado,ivDescripcion,ivClienteCedula,ivProductoCodigo,ivFechaCreacion);
INSERT INTO solmodificacionproducto VALUES (ivCodigo, ivProductoCodigo2);
END pInsertar;

--borrar
PROCEDURE pBorrar (ivCodigo solicitud.codigo%TYPE) IS
BEGIN
DELETE FROM solmodificacionproducto WHERE solicitud_codigo = ivCodigo;
DELETE FROM solicitud WHERE codigo = ivCodigo;
END pBorrar;

--modificar
PROCEDURE pModificar (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE, ivFechaCracion solicitud.fechaCreacion%TYPE, ivProductoCodigo2 solicitud.producto_codigo%TYPE) IS
BEGIN
UPDATE solicitud 
SET estado=ivEstado,descripcion=ivDescripcion,cliente_cedula=ivClienteCedula,producto_codigo=ivProductoCodigo,fechacreacion=ivFechaCracion 
WHERE codigo = ivCodigo;

UPDATE solmodificacionproducto
SET producto_codigo=ivProductoCodigo2
WHERE solicitud_codigo=ivCodigo;
END pModificar;

--consultar
FUNCTION fConsultar (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2 IS
vCodigo solicitud.codigo%TYPE;
vEstado solicitud.estado%TYPE;
vDescripcion solicitud.descripcion%TYPE;
vClienteCedula solicitud.cliente_cedula%TYPE;
vProductoCodigo solicitud.producto_codigo%TYPE;
vFechaCreacion solicitud.fechacreacion%TYPE;
vProductoCodigo2 solicitud.producto_codigo%TYPE;
ovconsulta VARCHAR2(5000);
BEGIN
SELECT codigo,estado,descripcion,cliente_cedula,solicitud.producto_codigo,fechacreacion,solmodificacionproducto.producto_codigo
    INTO vCodigo,vEstado,vDescripcion,vClienteCedula,vProductoCodigo,vFechaCreacion, vProductoCodigo2
    FROM solmodificacionproducto 
    INNER JOIN solicitud 
    ON solicitud.codigo=solmodificacionproducto.solicitud_codigo 
    WHERE codigo=ivCodigo;
ovconsulta:= vCodigo||','||vEstado||','||vDescripcion||','||vClienteCedula||','||vProductoCodigo||','||vFechaCreacion||','||vProductoCodigo2;
RETURN ovconsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe solicitación de reclamo de producto con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkSolModificacionProducto;