CREATE OR REPLACE PACKAGE pkProductoNivel2 AS
	PROCEDURE registrarProducto (ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE);
	PROCEDURE modificarProducto (ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE);
	PROCEDURE borrarProducto (ivCodigo producto.codigo%TYPE);
END pkProductoNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkProductoNivel2 AS
		PROCEDURE registrarProducto (ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE) IS
        cantidad NUMBER(1);	
        BEGIN
            SELECT COUNT(*) INTO cantidad FROM producto WHERE codigo = ivCodigo;
			IF cantidad = 1 THEN
				RAISE_APPLICATION_ERROR(-20001,'El producto con codigo ' || ivCodigo || ' ya existe');
			ELSE
				pkProducto.pInsertar(ivCodigo, ivDescripcion, ivTipo);
            END IF;
		END registrarProducto;
	
		PROCEDURE modificarProducto(ivCodigo producto.codigo%TYPE, ivDescripcion producto.descripcion%TYPE, ivTipo producto.tipo%TYPE) IS
		cantidad NUMBER(1);
		oldRow producto%rowtype;
		vDescripcion producto.descripcion%TYPE;
		vTipo producto.tipo%TYPE;
		BEGIN 
            SELECT COUNT(*) INTO cantidad FROM producto WHERE codigo = ivCodigo;
			IF cantidad = 1 THEN
				oldRow := pkProducto.fConsultar(ivCodigo);
				IF  ivDescripcion IS NULL THEN
					vDescripcion := oldRow.descripcion;
				ELSE
					vDescripcion := ivDescripcion;
				END IF;
				
				IF ivTipo IS NULL THEN
					vTipo := oldRow.tipo;
				ELSE
					vTipo := ivTipo;
				END IF;
				
				pkProducto.pModificar(ivCodigo, vDescripcion, vTipo);
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El producto con codigo ' || ivCodigo ||' no existe');
			END IF;
		END modificarProducto;
		
		PROCEDURE borrarProducto(ivCodigo producto.codigo%TYPE) IS
		cantidad NUMBER(1);
		BEGIN
			SELECT COUNT(*) INTO cantidad FROM producto WHERE codigo = ivCodigo;
			IF cantidad = 1 THEN
				pkProducto.pBorrar(ivCodigo);
			ELSE
				RAISE_APPLICATION_ERROR(-20001,'El producto con codigo ' || ivCodigo ||' no existe');
			END IF;
		END borrarProducto;
END pkProductoNivel2;
	