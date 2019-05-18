CREATE OR REPLACE PACKAGE pkParametros AS 
PROCEDURE pInsertar (
ivCodigo parametros.codigo%TYPE,
ivNombre parametros.nombre%TYPE,
ivValor parametros.valor%TYPE);

PROCEDURE pBorrar (ivCodigo parametros.codigo%TYPE);

PROCEDURE pModificar (ivCodigo parametros.codigo%TYPE,
ivNombre parametros.nombre%TYPE,
ivValor parametros.valor%TYPE);

FUNCTION fConsultar (ivCodigo parametros.codigo%TYPE)
RETURN parametros%rowtype IS ovConsulta parametros%rowtype;

END pkAsignacion;
/
CREATE OR REPLACE PACKAGE BODY pkParametros AS

-- insertar
PROCEDURE pInsertar (
ivCodigo parametros.codigo%TYPE,
ivNombre parametros.nombre%TYPE,
ivValor parametros.valor%TYPE);
BEGIN
INSERT INTO parametros  VALUES
(ivCodigo,
ivNombre,
ivValor);
END pInsertar;

--borrar
PROCEDURE pBorrar (ivCodigo parametros.codigo%TYPE);
BEGIN
DELETE FROM parametros 
WHERE  parametros.codigo = ivCodigo;
END pBorrar;


--modificar
PROCEDURE pModificar (
ivCodigo parametros.codigo%TYPE,
ivNombre parametros.nombre%TYPE,
ivValor parametros.valor%TYPE);
BEGIN
UPDATE parametros 
SET nombre = ivNombre, valor = ivValor
WHERE codigo = ivCodigo;
END pModificar;

-- consultar
FUNCTION fConsultar (ivCodigo parametros.codigo%TYPE)
RETURN parametros%rowtype IS ovConsulta parametros%rowtype;
BEGIN 
SELECT * INTO ovConsulta
FROM parametros
WHERE codigo = ivCodigo;
WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'Error, no existe una asignacion con ese id');
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'Error desconocido'||SQLERRM||SQLCODE);
END fConsultar;

END pkAsignacion;



