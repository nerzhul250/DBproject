CREATE OR REPLACE PACKAGE pkTipoAnomalia AS -- spec
PROCEDURE pInsertarTipoAnomalia (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pBorrarTipoAnomalia (ivId tipoanomalia.id%TYPE);
PROCEDURE pModificarTipoAnomalia (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
FUNCTION fConsultarTipoAnomalia (ivId tipoanomalia.id%TYPE) RETURN tipoanomalia%rowtype;
END pkTipoAnomalia;
/
CREATE OR REPLACE PACKAGE BODY pkTipoAnomalia AS -- body
-- insertar
PROCEDURE pInsertarTipoAnomalia (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
BEGIN
INSERT INTO tipoanomalia VALUES (ivId,ivDescripcion);
END pInsertarTipoAnomalia;
-- borrar
PROCEDURE pBorrarTipoAnomalia (ivId tipoanomalia.id%TYPE) IS
BEGIN
DELETE FROM tipoanomalia WHERE id = ivId;
END pBorrarTipoAnomalia;
-- modificar
PROCEDURE pModificarTipoAnomalia (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
BEGIN
UPDATE tipoanomalia SET descripcion=ivDescripcion WHERE id = ivId;
END pModificarTipoAnomalia;
-- consultar
FUNCTION fConsultarTipoAnomalia (ivId tipoanomalia.id%TYPE) RETURN tipoanomalia%rowtype IS
ovconsulta tipoanomalia%rowtype;
BEGIN
SELECT * into ovconsulta FROM tipoanomalia WHERE id=ivId;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe tipo de anomalia con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultarTipoAnomalia;
END pkTipoAnomalia;