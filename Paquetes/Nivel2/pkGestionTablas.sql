CREATE OR REPLACE PACKAGE pkGestionTablas AS -- spec
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE);
END pkGestionTablas;
/
CREATE OR REPLACE PACKAGE BODY pkGestionTablas AS -- body
PROCEDURE pRegistrarTipoAnomalia(ivDescripcion tipoanomalia.descripcion%TYPE) IS
lastID NUMBER;
BEGIN
lastID:=0;
SELECT MAX(id) into lastID FROM tipoanomalia; 
PKTIPOANOMALIA.pInsertar(lastID+1,ivDescripcion);
END pRegistrarTipoAnomalia;
END pkGestionTablas;