CREATE OR REPLACE PACKAGE pkGestionTablas AS -- spec
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pModificarTipoAnomalia(ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pEliminarTipoAnomalia(ivId tipoanomalia.id%TYPE);
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
END pkGestionTablas;