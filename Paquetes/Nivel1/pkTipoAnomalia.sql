CREATE OR REPLACE PACKAGE pkTipoAnomalia AS -- spec
PROCEDURE pInsertar (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
PROCEDURE pBorrar (ivId tipoanomalia.id%TYPE);
PROCEDURE pModificar (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE);
FUNCTION fConsultar (ivId tipoanomalia.id%TYPE) RETURN tipoanomalia%rowtype;
END pkTipoAnomalia;
/
CREATE OR REPLACE PACKAGE BODY pkTipoAnomalia AS -- body
-- insertar
PROCEDURE pInsertar (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
BEGIN
INSERT INTO tipoanomalia VALUES (ivId,ivDescripcion);
END pInsertar;
-- borrar
PROCEDURE pBorrar (ivId tipoanomalia.id%TYPE) IS
BEGIN
DELETE FROM tipoanomalia WHERE id = ivId;
END pBorrar;
-- modificar
PROCEDURE pModificar (ivId tipoanomalia.id%TYPE,ivDescripcion tipoanomalia.descripcion%TYPE) IS
BEGIN
UPDATE tipoanomalia SET descripcion=ivDescripcion WHERE id = ivId;
END pModificar;
-- consultar
FUNCTION fConsultar (ivId tipoanomalia.id%TYPE) RETURN tipoanomalia%rowtype IS
ovconsulta tipoanomalia%rowtype;
BEGIN
SELECT * into ovconsulta FROM tipoanomalia WHERE id=ivId;
RETURN ovconsulta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001,'Error, no existe tipo de anomalia con id: '||ivId);
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;
END pkTipoAnomalia;