CREATE OR REPLACE PACKAGE pkGestionTablas AS -- spec
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pModificarTipoAnomalia(ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pEliminarTipoAnomalia(ivId tipoanomalia.id%TYPE);

PROCEDURE pRegistrarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
PROCEDURE pModificarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
PROCEDURE pEliminarCliente(ivCedula cliente.cedula%TYPE);
END pkGestionTablas;
/
CREATE OR REPLACE PACKAGE BODY pkGestionTablas AS -- body
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE) IS
lastID NUMBER;
BEGIN
SELECT MAX(id) into lastID FROM tipoanomalia; 
IF lastID IS NULL then
    lastID:=0;
END IF;
PKTIPOANOMALIA.pInsertar(lastID+1,ivDescripcion);
END pRegistrarTipoAnomalia;
PROCEDURE pModificarTipoAnomalia(ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
dummy tipoanomalia%rowtype;
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
dummy:=PKTIPOANOMALIA.fConsultar(ivId);
PKTIPOANOMALIA.pModificar(ivId,ivDescripcion);
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
PROCEDURE pRegistrarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE) IS
dummy VARCHAR2(5000);
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
dummy:=PKCLIENTE.fConsultar(ivCedula);
RAISE_APPLICATION_ERROR(-20003,'Error, ya existe cliente con cedula: '||ivCedula);
EXCEPTION
    WHEN noFound THEN 
    PKCLIENTE.pInsertar(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
    WHEN OTHERS THEN 
    RAISE_APPLICATION_ERROR(-20002,'Error desconocido: '||SQLERRM||SQLCODE);
END pRegistrarCliente;
PROCEDURE pModificarCliente(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE) IS
dummy VARCHAR2(5000);
noFound EXCEPTION;
PRAGMA EXCEPTION_INIT(noFound,-20001);
BEGIN
dummy:=PKCLIENTE.fConsultar(ivCedula);
PKCLIENTE.pModificar(ivCedula cliente.cedula%TYPE,ivNombre cliente.nombre%TYPE,ivfechaNacimiento cliente.fechanacimiento%TYPE,ivdireccion cliente.direccion%TYPE,ivTelefono cliente.telefono%TYPE);
EXCEPTION
    WHEN noFound THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe cliente con cedula: '||ivCedula);
END pModificarCliente;
END pkGestionTablas;