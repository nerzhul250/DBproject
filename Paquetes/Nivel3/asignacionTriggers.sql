
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
     dbms_output.put_line( 'no se hizo la asignacion automatica' ); 
END;
/
CREATE OR REPLACE TRIGGER asignacionAutomaticaSolReporte
AFTER INSERT  ON solreportedanios
FOR EACH ROW
DECLARE
 cedula funcionario.cedula%TYPE;
BEGIN
   cedula:=pkAsignacionNivel2.fRetornarFuncionarioDisponible;

   pkAsignacionNivel2.realizarAsignacion (SYSDATE,TRIM(cedula),:NEW.solicitud_codigo ,NULL, NULL, NULL);
   pkAsignacionNivel2.cambiarEstadoSolicitud (:NEW.solicitud_codigo, 'Asignado');
EXCEPTION
WHEN OTHERS THEN
    dbms_output.put_line( 'no se hizo la asignacion automatica' ); 
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
    pkAsignacionNivel2.cambiarEstadoSolicitud (:NEW.solicitud_codigo, 'Asignado');
EXCEPTION
WHEN OTHERS THEN
    dbms_output.put_line( 'no se hizo la asignacion automatica' ); 
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
    pkAsignacionNivel2.cambiarEstadoSolicitud (:NEW.solicitud_codigo, 'Asignado');
EXCEPTION
WHEN OTHERS THEN
    dbms_output.put_line( 'no se hizo la asignacion automatica' ); 
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
    pkAsignacionNivel2.cambiarEstadoSolicitud (:NEW.solicitud_codigo, 'Asignado');
EXCEPTION
WHEN OTHERS THEN
    dbms_output.put_line( 'no se hizo la asignacion automatica' ); 
END ;
/

