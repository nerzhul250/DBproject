CREATE OR REPLACE PACKAGE pkRegistroNivel2 AS -- spec
    PROCEDURE pRegistrarSolicitudReporteDanios(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivTipoAnomaliaId solreportedanios.tipoanomalia_id%TYPE);
    PROCEDURE pRegistrarSolicitudModificacionProducto(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivNuevoProducto solmodificacionproducto.producto_codigo%TYPE);
    PROCEDURE pRegistrarSolicitudReclamo(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE);
    PROCEDURE pRegistrarSolicitudCreacion(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE);
    PROCEDURE pRegistrarSolicitudCancelacionProducto(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE);
END pkRegistroNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkRegistroNivel2 AS -- body
PROCEDURE pRegistrarSolicitudReporteDanios(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivTipoAnomaliaId solreportedanios.tipoanomalia_id%TYPE) IS
    vLastId NUMBER;
    BEGIN
    SELECT MAX(codigo) into vLastId FROM solicitud;
    IF vLastId IS NULL then
        vLastId:=0;
    END IF;
    PKSOLREPORTEDANIOS.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,sysdate,'reporteDanios',ivTipoAnomaliaId);
    END pRegistrarSolicitudReporteDanios;
    PROCEDURE pRegistrarSolicitudModificacionProducto(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivNuevoProducto solmodificacionproducto.producto_codigo%TYPE) IS
    vLastId NUMBER;
    BEGIN
    SELECT MAX(codigo) into vLastId FROM solicitud;
    IF vLastId IS NULL then
        vLastId:=0;
    END IF;
    PKSOLMODIFICACIONPRODUCTO.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,sysdate,'modificacionProducto',ivNuevoProducto);
END pRegistrarSolicitudModificacionProducto;
PROCEDURE pRegistrarSolicitudReclamo(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE) IS
    vLastId NUMBER;
    BEGIN
    SELECT MAX(codigo) into vLastId FROM solicitud;
    IF vLastId IS NULL then
        vLastId:=0;
    END IF;
    PKSOLRECLAMO.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,'reclamo',sysdate);
END pRegistrarSolicitudReclamo;
PROCEDURE pRegistrarSolicitudCreacion(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE) IS
    vLastId NUMBER;
    BEGIN
    SELECT MAX(codigo) into vLastId FROM solicitud;
    IF vLastId IS NULL then
        vLastId:=0;
    END IF;
    PKSOLCREACION.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,'creacion',sysdate);
END pRegistrarSolicitudCreacion;
PROCEDURE pRegistrarSolicitudCancelacionProducto(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE) IS
    vLastId NUMBER;
    BEGIN
    SELECT MAX(codigo) into vLastId FROM solicitud;
    IF vLastId IS NULL then
        vLastId:=0;
    END IF;
    PKSOLCANCELACIONPRODUCTO.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,'cancelacionProducto',sysdate);
    END pRegistrarSolicitudCancelacionProducto;
END pkRegistroNivel2;