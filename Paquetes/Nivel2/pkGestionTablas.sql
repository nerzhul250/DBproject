CREATE OR REPLACE PACKAGE pkGestionTablas AS -- spec
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pModificarTipoAnomalia(ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pEliminarTipoAnomalia(ivId tipoanomalia.id%TYPE);

PROCEDURE pRegistrarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
PROCEDURE pModificarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
PROCEDURE pEliminarCliente(ivCedula cliente.cedula%TYPE);

PROCEDURE pRegistrarParametro(ivNombre parametros.nombre%TYPE,ivValor parametros.valor%TYPE);
PROCEDURE pModificarParametro(ivCodigo parametros.codigo%TYPE,ivNombre parametros.nombre%TYPE,ivValor parametros.valor%TYPE);
PROCEDURE pEliminarParametro(ivCodigo parametros.codigo%TYPE);
END pkGestionTablas;
/
CREATE OR REPLACE PACKAGE BODY pkGestionTablas AS -- body

--TipoAnomalia OPS

PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE) IS
vLastId NUMBER;
BEGIN
SELECT MAX(id) into vLastId FROM tipoanomalia;
IF vLastId IS NULL then
    vLastId:=0;
END IF;
PKTIPOANOMALIA.pInsertar(vLastId+1,ivDescripcion);
END pRegistrarTipoAnomalia;
PROCEDURE pModificarTipoAnomalia(ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
dummy tipoanomalia%rowtype;
vDescripcion tipoanomalia.descripcion%TYPE;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
dummy:=PKTIPOANOMALIA.fConsultar(ivId);
IF ivDescripcion IS NULL THEN
    vDescripcion:=dummy.descripcion;
    ELSE
    vDescripcion:=ivDescripcion;
END IF;
PKTIPOANOMALIA.pModificar(ivId,vDescripcion);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe tipo de anomalia con id: '||ivId);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pModificarTipoAnomalia;
PROCEDURE pEliminarTipoAnomalia(ivId tipoanomalia.id%TYPE) IS
dummy tipoanomalia%rowtype;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
dummy:=PKTIPOANOMALIA.fConsultar(ivId);
pktipoanomalia.pBorrar(ivId);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe tipo de anomalia con id: '||ivId);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pEliminarTipoAnomalia;

--Cliente OPS

PROCEDURE pRegistrarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE) IS
vDummy cliente%rowtype;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
vDummy:=PKCLIENTE.fConsultar(ivCedula);
RAISE_APPLICATION_ERROR(-20003,'Error, ya existe cliente con cedula: '||ivCedula);
EXCEPTION
    WHEN noFound THEN
    PKCLIENTE.pInsertar(ivCedula,ivNombre,ivfechaNacimiento,ivdireccion,ivTelefono);
    WHEN OTHERS THEN 
    RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pRegistrarCliente;
PROCEDURE pModificarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivFechaNacimiento cliente.fechanacimiento%TYPE,ivDireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE) IS
vDummy cliente%rowtype;
vNombre cliente.nombre%TYPE;
vFechaNacimiento cliente.fechanacimiento%TYPE;
vdireccion cliente.direccion%TYPE;
vTelefono cliente.telefono%TYPE;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN

vDummy:=PKCLIENTE.fConsultar(ivCedula);
IF ivNombre IS NULL THEN
    vNombre:=vDummy.nombre;
    ELSE
    vNombre:=ivNombre;
END IF;
IF ivFechaNacimiento IS NULL THEN
    vFechaNacimiento:=vDummy.fechanacimiento;
    ELSE
    vFechaNacimiento:=ivFechaNacimiento;
END IF;
IF ivDireccion IS NULL THEN
    vDireccion:=vDummy.direccion;
    ELSE
    vDireccion:=ivDireccion;
END IF;
IF ivTelefono IS NULL THEN
    vTelefono:=vDummy.telefono;
    ELSE
    vTelefono:=ivTelefono;
END IF;
PKCLIENTE.pModificar(ivCedula,vNombre,vFechaNacimiento,vDireccion,vTelefono);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe cliente con cedula: '||ivCedula);
END pModificarCliente;
PROCEDURE pEliminarCliente(ivCedula cliente.cedula%TYPE) IS
vDummy cliente%rowtype;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
vDummy:=PKCLIENTE.fConsultar(ivCedula);
PKCLIENTE.pBorrar(ivCedula);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe cliente con cedula: '||ivCedula);
END pEliminarCliente;

-- Parametros OPS

PROCEDURE pRegistrarParametro(ivNombre parametros.nombre%TYPE,ivValor parametros.valor%TYPE) IS
lastID NUMBER;
BEGIN
SELECT MAX(codigo) into lastID FROM parametros;
IF lastID IS NULL then
    lastID:=0;
END IF;
PKPARAMETROS.pInsertar(lastID+1,ivNombre,ivValor);
END pRegistrarParametro;
PROCEDURE pModificarParametro(ivCodigo parametros.codigo%TYPE,ivNombre parametros.nombre%TYPE,ivValor parametros.valor%TYPE) IS
vDummy parametros%rowtype;
vNombre parametros.nombre%TYPE;
vValor parametros.valor%TYPE;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
vDummy:=PKPARAMETROS.fConsultar(ivCodigo);
IF ivNombre IS NULL THEN
    vNombre:=vDummy.nombre;
    ELSE
    vNombre:=ivNombre;
END IF;
IF ivValor IS NULL THEN
    vValor:=vDummy.valor;
    ELSE
    vValor:=ivValor;
END IF;
PKPARAMETROS.pModificar(ivCodigo,vNombre,vValor);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe parametro con codigo: '||ivCodigo);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pModificarParametro;
PROCEDURE pEliminarParametro(ivCodigo parametros.codigo%TYPE) IS
vDummy parametros%rowtype;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
vDummy:=PKPARAMETROS.fConsultar(ivCodigo);
PKPARAMETROS.pBorrar(ivCodigo);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe parametro con codigo: '||ivCodigo);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pEliminarParametro;
END pkGestionTablas;