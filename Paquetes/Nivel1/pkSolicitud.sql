CREATE OR REPLACE PACKAGE pkSolicitud AS -- spec
    PROCEDURE pInsertar(ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE);
    FUNCTION fConsultar(ivCodigo solicitud.codigo%TYPE) RETURN solicitud%rowtype;
END pkSolicitud;
/
CREATE OR REPLACE PACKAGE BODY pkSolicitud AS -- body
PROCEDURE pInsertar(ivCodigo solicitud.codigo%TYPE,ivEstado solicitud.estado%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivFechaCreacion solicitud.fechacreacion%TYPE) IS
BEGIN
INSERT INTO solicitud VALUES (ivCodigo, ivEstado, ivDescripcion,ivCedulaCliente,ivProducto,ivFechaCreacion);
END pInsertar;
FUNCTION fConsultar(ivCodigo solicitud.codigo%TYPE) RETURN solicitud%rowtype IS
ovConsulta solicitud%rowtype;
BEGIN
SELECT * INTO ovConsulta FROM solicitud WHERE codigo=ivCodigo;
RETURN ovConsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe solicitud con codigo: '||ivCodigo);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkSolicitud;