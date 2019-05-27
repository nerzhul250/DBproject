
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolModificar
AFTER INSERT  ON solmodificacionProducto
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;

   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula), :NEW.solicitud_codigo,NULL, NULL, NULL);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica'||SQLERRM||SQLCODE);
END;
/
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolReporte
AFTER INSERT  ON solreportedanios
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;

   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula), :NEW.solicitud_codigo,NULL, NULL, NULL);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica'||SQLERRM||SQLCODE);
END ;
/
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolCancelacion
AFTER INSERT  ON solcancelacionproducto
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;

   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula), :NEW.solicitud_codigo,NULL, NULL, NULL);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica'||SQLERRM||SQLCODE);
END ;
/
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolCreacion
AFTER INSERT  ON solcreacion
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;
   
   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula),:NEW.solicitud_codigo,NULL, NULL, NULL);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica'||SQLERRM||SQLCODE);
END ;
/
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolReclamo
AFTER INSERT  ON solreclamo
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;
   
   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula), :NEW.solicitud_codigo,NULL, NULL, NULL);
EXCEPTION
WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002,'No se pudo hacer la asignación automatica'||SQLERRM||SQLCODE);
END ;
/

