-- Generado por Oracle SQL Developer Data Modeler 18.4.0.339.1536
--   en:        2019-05-11 15:58:31 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE asignacion CASCADE CONSTRAINTS;

DROP TABLE cliente CASCADE CONSTRAINTS;

DROP TABLE funcionario CASCADE CONSTRAINTS;

DROP TABLE parametros CASCADE CONSTRAINTS;

DROP TABLE producto CASCADE CONSTRAINTS;

DROP TABLE servicioprestado CASCADE CONSTRAINTS;

DROP TABLE solcancelacionproducto CASCADE CONSTRAINTS;

DROP TABLE solcreacion CASCADE CONSTRAINTS;

DROP TABLE solicitud CASCADE CONSTRAINTS;

DROP TABLE solmodificacionproducto CASCADE CONSTRAINTS;

DROP TABLE solreclamo CASCADE CONSTRAINTS;

DROP TABLE solreportedanios CASCADE CONSTRAINTS;

DROP TABLE tipoanomalia CASCADE CONSTRAINTS;

CREATE TABLE asignacion (
    fechaasignacion          DATE,
    funcionario_cedula       VARCHAR2(20 CHAR) NOT NULL,
    solicitud_codigo         NUMBER(10) NOT NULL,
    fechaatencion            DATE,
    comentariosfuncionario   VARCHAR2(2000 CHAR),
    atendido                 CHAR(1)
);

ALTER TABLE asignacion ADD CONSTRAINT asignacion_pk PRIMARY KEY ( funcionario_cedula,
                                                                  solicitud_codigo );

CREATE TABLE cliente (
    cedula            VARCHAR2(20 CHAR) NOT NULL,
    nombre            VARCHAR2(50 CHAR),
    fechanacimiento   DATE,
    direccion         VARCHAR2(20 CHAR),
    telefono          VARCHAR2(20 CHAR)
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cedula );

CREATE TABLE funcionario (
    cedula            VARCHAR2(20 CHAR) NOT NULL,
    nombre            VARCHAR2(50 CHAR),
    fechanacimiento   DATE,
    direccion         VARCHAR2(20 CHAR),
    telefono          VARCHAR2(20 CHAR)
);

ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cedula );

CREATE TABLE parametros (
    codigo   NUMBER(10) NOT NULL,
    nombre   VARCHAR2(20 CHAR),
    valor    VARCHAR2(50 CHAR)
);

ALTER TABLE parametros ADD CONSTRAINT parametros_pk PRIMARY KEY ( codigo );

CREATE TABLE producto (
    codigo        VARCHAR2(10 CHAR) NOT NULL,
    descripcion   VARCHAR2(100 CHAR),
    tipo          NUMBER(6)
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( codigo );

CREATE TABLE servicioprestado (
    producto_codigo            VARCHAR2(10 CHAR) NOT NULL,
    cliente_cedula             VARCHAR2(20 CHAR) NOT NULL,
    fechainicioservicio        DATE,
    fechaterminacionservicio   DATE
);

ALTER TABLE servicioprestado ADD CONSTRAINT servicioprestado_pk PRIMARY KEY ( producto_codigo,
                                                                              cliente_cedula );

CREATE TABLE solcancelacionproducto (
    solicitud_codigo NUMBER(10) NOT NULL
);

ALTER TABLE solcancelacionproducto ADD CONSTRAINT solcanceprod_pk PRIMARY KEY ( solicitud_codigo );

CREATE TABLE solcreacion (
    solicitud_codigo NUMBER(10) NOT NULL
);

ALTER TABLE solcreacion ADD CONSTRAINT solcreacion_pk PRIMARY KEY ( solicitud_codigo );

CREATE TABLE solicitud (
    codigo            NUMBER(10) NOT NULL,
    estado            VARCHAR2(50 CHAR),
    descripcion       VARCHAR2(2000 CHAR),
    cliente_cedula    VARCHAR2(20 CHAR) NOT NULL,
    producto_codigo   VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE solicitud ADD CONSTRAINT solicitud_pk PRIMARY KEY ( codigo );

CREATE TABLE solmodificacionproducto (
    solicitud_codigo   NUMBER(10) NOT NULL,
    producto_codigo    VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE solmodificacionproducto ADD CONSTRAINT solmodprod_pk PRIMARY KEY ( solicitud_codigo );

CREATE TABLE solreclamo (
    solicitud_codigo NUMBER(10) NOT NULL
);

ALTER TABLE solreclamo ADD CONSTRAINT solreclamo_pk PRIMARY KEY ( solicitud_codigo );

CREATE TABLE solreportedanios (
    solicitud_codigo   NUMBER(10) NOT NULL,
    tipoanomalia_id    NUMBER(4) NOT NULL
);

ALTER TABLE solreportedanios ADD CONSTRAINT solrepdan_pk PRIMARY KEY ( solicitud_codigo );

CREATE TABLE tipoanomalia (
    id            NUMBER(4) NOT NULL,
    descripcion   VARCHAR2(2000 CHAR)
);

ALTER TABLE tipoanomalia ADD CONSTRAINT tipoanomalia_pk PRIMARY KEY ( id );

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_funcionario_fk FOREIGN KEY ( funcionario_cedula )
        REFERENCES funcionario ( cedula );

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE servicioprestado
    ADD CONSTRAINT servicioprestado_cliente_fk FOREIGN KEY ( cliente_cedula )
        REFERENCES cliente ( cedula );

ALTER TABLE servicioprestado
    ADD CONSTRAINT servicioprestado_producto_fk FOREIGN KEY ( producto_codigo )
        REFERENCES producto ( codigo );

ALTER TABLE solcancelacionproducto
    ADD CONSTRAINT solcanceprod_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE solcreacion
    ADD CONSTRAINT solcreacion_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_cliente_fk FOREIGN KEY ( cliente_cedula )
        REFERENCES cliente ( cedula );

ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_producto_fk FOREIGN KEY ( producto_codigo )
        REFERENCES producto ( codigo );

ALTER TABLE solmodificacionproducto
    ADD CONSTRAINT solmodiprod_producto_fk FOREIGN KEY ( producto_codigo )
        REFERENCES producto ( codigo );

ALTER TABLE solmodificacionproducto
    ADD CONSTRAINT solmodprod_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE solreclamo
    ADD CONSTRAINT solreclamo_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE solreportedanios
    ADD CONSTRAINT solrepdan_solicitud_fk FOREIGN KEY ( solicitud_codigo )
        REFERENCES solicitud ( codigo );

ALTER TABLE solreportedanios
    ADD CONSTRAINT solrepdan_tipoanomalia_fk FOREIGN KEY ( tipoanomalia_id )
        REFERENCES tipoanomalia ( id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
