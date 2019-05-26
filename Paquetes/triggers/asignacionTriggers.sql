CREATE OR REPLACE TRIGGER asignacionAutomatica
AFTER INSERT ON solicitud
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;
   pkAsignacionNivel2.realizarAsignacion (SYSDATE, cedula, :NEW.codigo, null, null, null);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica');
END ;