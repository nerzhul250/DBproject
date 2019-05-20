CREATE OR REPLACE PACKAGE pkRegistroNivel2 AS -- spec
PROCEDURE pRegistrarSolicitudReporteDanios(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivTipoAnomaliaId solreportedanios.tipoanomalia_id%TYPE);
PROCEDURE pRegistrarSolicitudModificacionProducto(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivNuevoProducto solmodificacionproducto.producto_codigo%TYPE);
END pkRegistroNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkRegistroNivel2 AS -- body
PROCEDURE pRegistrarSolicitudReporteDanios(ivCedulaCliente solicitud.cliente_cedula%TYPE,ivProducto solicitud.producto_codigo%TYPE,ivDescripcion solicitud.descripcion%TYPE,ivTipoAnomaliaId solreportedanios.tipoanomalia_id%TYPE) IS
vLastId NUMBER;
BEGIN
SELECT MAX(codigo) into vLastId FROM tipoanomalia;
IF vLastId IS NULL then
    vLastId:=0;
END IF;
PKSOLREPORTEDANIOS.pInsertar(vLastId+1,'pendiente',ivDescripcion,ivCedulaCliente,ivProducto,sysdate,ivTipoAnomaliaId);
END pRegistrarSolicitudReporteDanios;
END pkRegistroNivel2;