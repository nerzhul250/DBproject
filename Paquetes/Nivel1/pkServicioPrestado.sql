CREATE OR REPLACE PACKAGE pkServicioPrestado AS -- spec
	PROCEDURE pInsertar (ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE, ivFechainicioservicio servicioprestado.fechainicioservicio%TYPE, ivFechaTerminacionServicio servicioprestado.fechaterminacionservicio%TYPE);
	PROCEDURE pBorrar(ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE);
	PROCEDURE pModificar(ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE, ivFechainicioservicio servicioprestado.fechainicioservicio%TYPE, ivFechaTerminacionServicio servicioprestado.fechaterminacionservicio%TYPE);
	FUNCTION fConsultar (ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE) RETURN VARCHAR2;
END pkServicioPrestado;
/
CREATE OR REPLACE PACKAGE BODY pkServicioPrestado AS
	PROCEDURE pInsertar (ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE, ivFechainicioservicio servicioprestado.fechainicioservicio%TYPE, ivFechaTerminacionServicio servicioprestado.fechaterminacionservicio%TYPE) IS
	BEGIN
		INSERT INTO servicioprestado VALUES (ivProductoCodigo,ivClienteCedula,ivFechainicioservicio,ivFechaTerminacionServicio);
	END pInsertar;
	
	PROCEDURE pBorrar (ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE) IS
	BEGIN
		DELETE FROM servicioprestado WHERE producto_codigo = ivProductoCodigo AND cliente_cedula= ivClienteCedula;
	END pInsertar;
	
	PROCEDURE pModificar(ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE, ivFechainicioservicio servicioprestado.fechainicioservicio%TYPE, ivFechaTerminacionServicio servicioprestado.fechaterminacionservicio%TYPE) IS
	BEGIN
		UPDATE servicioprestado SET producto_codigo = ivProductoCodigo, cliente_cedula = ivClienteCedula, fechainicioservicio = ivFechainicioservicio, fechaterminacionservicio= ivFechaTerminacionServicio WHERE producto_codigo= ivProductoCodigo AND cliente_cedula= ivClienteCedula;
	END
	
	FUNCTION fConsultar (ivProductoCodigo servicioprestado.producto_codigo%TYPE, ivClienteCedula servicioprestado.cliente_cedula%TYPE) RETURN VARCHAR2 IS
		vproductocodigo servicioprestado.producto_codigo%TYPE;
		vclientecedula servicioprestado.cliente_cedula%TYPE;
		
END pkServicioPrestado;