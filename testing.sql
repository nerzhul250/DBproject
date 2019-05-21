BEGIN
-- Se crean 5 funcionarios
pkFuncionario.pInsertar(1234,'Funcionario 1', '26/02/1999', 'Terranova', '3206457287');
pkFuncionario.pInsertar(1235,'Funcionario 2', '2/04/1985', 'Jamundi', '3204521657');
pkFuncionario.pInsertar(1236,'Funcionario 3', '6/06/1939', 'Cali', '334578951');
pkFuncionario.pInsertar(1237,'Funcionario 4', '16/08/1978', 'Popayan', '3206457287');
pkFuncionario.pInsertar(1238,'Funcionario 5', '5/10/1987', 'Santa Marta', '3206457287');

-- Se crean 5 clientes
pkCliente.pInsertar(1, 'Cliente 1','06/07/1997', 'Santiago de Cali', 4478992);
pkCliente.pInsertar(2, 'Cliente 2','06/07/1997', 'Bucaramanga', 4478992);
pkCliente.pInsertar(3, 'Cliente 3','06/07/1997', 'San Agustin', 4478992);
pkCliente.pInsertar(4, 'Cliente 4','06/07/1997', 'Tolemaida', 4478992);
pkCliente.pInsertar(5, 'Cliente 5','06/07/1997', 'Barranquilla', 4478992);

-- Se crean 5 parametros 
pkParametros.pInsertar(10, 'parametro 1', 'Valor 1');
pkParametros.pInsertar(11, 'parametro 2', 'Valor 2');
pkParametros.pInsertar(12, 'parametro 3', 'Valor 3');
pkParametros.pInsertar(13, 'parametro 4', 'Valor 4');
pkParametros.pInsertar(14, 'parametro 1', 'Valor 5');

-- Se crean 5 productos
pkProducto.pInsertar('A01', 'producto con codigo A01', 1);
pkProducto.pInsertar('B02', 'producto con codigo B02', 2);
pkProducto.pInsertar('C03', 'producto con codigo C03', 3);
pkProducto.pInsertar('D04', 'producto con codigo D04', 4);
pkProducto.pInsertar('E05', 'producto con codigo E05', 5);

-- 
END;
