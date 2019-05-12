CREATE OR REPLACE PACKAGE pkSolCancelacionProducto AS -- spec
PROCEDURE pInsertarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE);
PROCEDURE pBorrarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE);
PROCEDURE pModificarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE);
FUNCTION fConsultarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2;
END pkSolCancelacionProducto;
/
CREATE OR REPLACE PACKAGE BODY pkSolCancelacionProducto AS
-- insertar
PROCEDURE pInsertarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE) IS
BEGIN
INSERT INTO solicitud VALUES (ivCodigo,ivEstado,ivDescripcion,ivClienteCedula,ivProductoCodigo);
INSERT INTO solcancelacionproducto VALUES (ivCodigo);
END pInsertarSolCancelacionProducto;
-- borrar
PROCEDURE pBorrarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE) IS
BEGIN
DELETE FROM solcancelacionproducto WHERE solicitud_codigo = ivCodigo;
DELETE FROM solicitud WHERE codigo = ivCodigo;
END pBorrarSolCancelacionProducto;
-- modificar
PROCEDURE pModificarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivClienteCedula solicitud.cliente_cedula%TYPE, ivProductoCodigo solicitud.producto_codigo%TYPE) IS
BEGIN
UPDATE solicitud SET estado=ivEstado,descripcion=ivDescripcion,cliente_cedula=ivClienteCedula,producto_codigo=ivProductoCodigo WHERE codigo = ivCodigo;
END pModificarSolCancelacionProducto;
-- consultar
FUNCTION fConsultarSolCancelacionProducto (ivCodigo solicitud.codigo%TYPE) RETURN VARCHAR2 IS
vCodigo solicitud.codigo%TYPE;
vEstado solicitud.estado%TYPE;
vDescripcion solicitud.descripcion%TYPE;
vClienteCedula solicitud.cliente_cedula%TYPE;
vProductoCodigo solicitud.producto_codigo%TYPE;
ovconsulta VARCHAR2(5000);
BEGIN
SELECT codigo,estado,descripcion,cliente_cedula,producto_codigo
into vCodigo,vEstado,vDescripcion,vClienteCedula,vProductoCodigo
FROM solcancelacionproducto INNER JOIN solicitud ON solicitud.codigo=solcancelacionproducto.solicitud_codigo WHERE codigo=ivCodigo;
ovconsulta:= vCodigo||','||vEstado||','||vDescripcion||','||vClienteCedula||','||vProductoCodigo;
RETURN ovconsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe solicito de reporte de danios con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultarSolCancelacionProducto;
END pkSolCancelacionProducto;