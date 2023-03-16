
USE master;
GO

DROP DATABASE IF EXISTS Tienda_MusicalV2
GO

CREATE DATABASE Tienda_MusicalV2;
GO

USE Tienda_MusicalV2;
GO


CREATE TABLE Alquiler 
    (
     Id_Alquiler INTEGER NOT NULL , 
     Descripcion VARCHAR (80) , 
     Fecha_recogida DATE NOT NULL , 
     Fecha_entrega DATE NOT NULL , 
     Cantidad_dias INTEGER NOT NULL , 
     Instrumento_Id_Instrumento INTEGER NOT NULL , 
     Clientes_Id_Cliente VARCHAR (10) NOT NULL , 
     Clientes_Localizacion_Id_Localizacion INTEGER NOT NULL , 
     Oficina_IdOficina INTEGER NOT NULL 
    )
GO

ALTER TABLE Alquiler ADD CONSTRAINT Alquiler_PK PRIMARY KEY CLUSTERED (Id_Alquiler, Clientes_Id_Cliente, Clientes_Localizacion_Id_Localizacion, Oficina_IdOficina)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Bizum 
    (
     Numero_movil VARCHAR (9) NOT NULL , 
     Concepto VARCHAR (80) , 
     Metodo_Pago_id_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Bizum ADD CONSTRAINT Bizum_PK PRIMARY KEY CLUSTERED (Metodo_Pago_id_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Categoria 
    (
     Id_Categoria INTEGER NOT NULL , 
     Nombre VARCHAR (30) , 
     Descripcion VARCHAR (80) 
    )
GO

ALTER TABLE Categoria ADD CONSTRAINT Categoria_PK PRIMARY KEY CLUSTERED (Id_Categoria)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Clientes 
    (
     Id_Cliente VARCHAR (10) NOT NULL , 
     Nombre VARCHAR (30) NOT NULL , 
     Apellido1 VARCHAR (30) NOT NULL , 
     Apellido2 VARCHAR (30) , 
     Email VARCHAR (30) NOT NULL , 
     Fecha_Nacimiento DATE , 
     Movil VARCHAR (20) NOT NULL , 
     Nacionalidad_Id_Nacionalidad INTEGER NOT NULL , 
     Localizacion_Id_Localizacion INTEGER NOT NULL 
    )
GO

ALTER TABLE Clientes ADD CONSTRAINT Clientes_PK PRIMARY KEY CLUSTERED (Id_Cliente, Localizacion_Id_Localizacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Compra 
    (
     Id_Compra INTEGER NOT NULL , 
     Descripcion VARCHAR (80) , 
     Fecha_Compra DATE NOT NULL , 
     Instrumento_Id_Instrumento INTEGER NOT NULL , 
     Clientes_Id_Cliente VARCHAR (10) NOT NULL , 
     Clientes_Localizacion_Id_Localizacion INTEGER NOT NULL , 
     Oficina_IdOficina INTEGER NOT NULL 
    )
GO

ALTER TABLE Compra ADD CONSTRAINT Compra_PK PRIMARY KEY CLUSTERED (Id_Compra, Instrumento_Id_Instrumento, Clientes_Id_Cliente, Clientes_Localizacion_Id_Localizacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Factura_Alquiler 
    (
     id_facturaAlquiler INTEGER NOT NULL , 
     Total_alquiler MONEY NOT NULL , 
     Alquiler_Id_Alquiler INTEGER NOT NULL , 
     Alquiler_Clientes_Id_Cliente VARCHAR (10) NOT NULL , 
     Alquiler_Clientes_Localizacion_Id_Localizacion INTEGER NOT NULL , 
     Metodo_Pago_id_Pago INTEGER NOT NULL , 
     Alquiler_Oficina_IdOficina INTEGER NOT NULL 
    )
GO

ALTER TABLE Factura_Alquiler ADD CONSTRAINT Factura_Alquiler_PK PRIMARY KEY CLUSTERED (id_facturaAlquiler)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Factura_Compra 
    (
     Id_facturaCompra INTEGER NOT NULL , 
     Total_compra MONEY NOT NULL , 
     Compra_Id_Compra INTEGER NOT NULL , 
     Compra_Instrumento_Id_Instrumento INTEGER NOT NULL , 
     Compra_Clientes_Id_Cliente VARCHAR (10) NOT NULL , 
     Compra_Clientes_Localizacion_Id_Localizacion INTEGER NOT NULL , 
     Metodo_Pago_id_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Factura_Compra ADD CONSTRAINT Factura_Compra_PK PRIMARY KEY CLUSTERED (Id_facturaCompra)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Instrumento 
    (
     Id_Instrumento INTEGER NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Descripcion VARCHAR (80) , 
     Especificaciones VARCHAR (80) , 
     Categoria_Id_Categoria INTEGER NOT NULL , 
     Marca_Id_Marca INTEGER NOT NULL 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Instrumento__IDX ON Instrumento 
    ( 
     Marca_Id_Marca 
    ) 
GO

ALTER TABLE Instrumento ADD CONSTRAINT Instrumento_PK PRIMARY KEY CLUSTERED (Id_Instrumento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Localizacion 
    (
     Id_Localizacion INTEGER NOT NULL , 
     Direccion VARCHAR (50) , 
     Provincia VARCHAR (30) , 
     Codigo_Postal VARCHAR (5) 
    )
GO

ALTER TABLE Localizacion ADD CONSTRAINT Localizacion_PK PRIMARY KEY CLUSTERED (Id_Localizacion)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Marca 
    (
     Id_Marca INTEGER NOT NULL , 
     Nombre_Marca VARCHAR (30) 
    )
GO

ALTER TABLE Marca ADD CONSTRAINT Marca_PK PRIMARY KEY CLUSTERED (Id_Marca)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Metodo_Pago 
    (
     id_Pago INTEGER NOT NULL , 
     Fecha_pago DATE NOT NULL 
    )
GO

ALTER TABLE Metodo_Pago ADD CONSTRAINT Metodo_Pago_PK PRIMARY KEY CLUSTERED (id_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Nacionalidad 
    (
     Id_Nacionalidad INTEGER NOT NULL , 
     Nombre VARCHAR (30) 
    )
GO

ALTER TABLE Nacionalidad ADD CONSTRAINT Nacionalidad_PK PRIMARY KEY CLUSTERED (Id_Nacionalidad)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Oficina 
    (
     IdOficina INTEGER NOT NULL , 
     Nombre VARCHAR (30) NOT NULL , 
     Telefono VARCHAR (10) , 
     Localizacion_Id_Localizacion INTEGER NOT NULL 
    )
GO

ALTER TABLE Oficina ADD CONSTRAINT Oficina_PK UNIQUE NONCLUSTERED (IdOficina)
GO

CREATE TABLE Paypal 
    (
     Email VARCHAR (30) NOT NULL , 
     Contraseña VARCHAR (30) NOT NULL , 
     Metodo_Pago_id_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Paypal ADD CONSTRAINT Paypal_PK PRIMARY KEY CLUSTERED (Metodo_Pago_id_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tarjeta 
    (
     Nombre_tarjeta VARCHAR (30) NOT NULL , 
     Numero_tarjeta VARCHAR (18) NOT NULL , 
     Fecha_caducidad VARCHAR (4) NOT NULL , 
     CVV VARCHAR (3) NOT NULL , 
     Metodo_Pago_id_Pago INTEGER NOT NULL 
    )
GO

ALTER TABLE Tarjeta ADD CONSTRAINT TARJETA_PK UNIQUE NONCLUSTERED (Metodo_Pago_id_Pago)
GO

ALTER TABLE Alquiler 
    ADD CONSTRAINT Alquiler_Clientes_FK FOREIGN KEY 
    ( 
     Clientes_Id_Cliente, 
     Clientes_Localizacion_Id_Localizacion
    ) 
    REFERENCES Clientes 
    ( 
     Id_Cliente , 
     Localizacion_Id_Localizacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Alquiler 
    ADD CONSTRAINT Alquiler_Instrumento_FK FOREIGN KEY 
    ( 
     Instrumento_Id_Instrumento
    ) 
    REFERENCES Instrumento 
    ( 
     Id_Instrumento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Alquiler 
    ADD CONSTRAINT Alquiler_Oficina_FK FOREIGN KEY 
    ( 
     Oficina_IdOficina
    ) 
    REFERENCES Oficina 
    ( 
     IdOficina 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Bizum 
    ADD CONSTRAINT Bizum_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_id_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Clientes 
    ADD CONSTRAINT Clientes_Localizacion_FK FOREIGN KEY 
    ( 
     Localizacion_Id_Localizacion
    ) 
    REFERENCES Localizacion 
    ( 
     Id_Localizacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Clientes 
    ADD CONSTRAINT Clientes_Nacionalidad_FK FOREIGN KEY 
    ( 
     Nacionalidad_Id_Nacionalidad
    ) 
    REFERENCES Nacionalidad 
    ( 
     Id_Nacionalidad 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Compra 
    ADD CONSTRAINT Compra_Clientes_FK FOREIGN KEY 
    ( 
     Clientes_Id_Cliente, 
     Clientes_Localizacion_Id_Localizacion
    ) 
    REFERENCES Clientes 
    ( 
     Id_Cliente , 
     Localizacion_Id_Localizacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Compra 
    ADD CONSTRAINT Compra_Instrumento_FK FOREIGN KEY 
    ( 
     Instrumento_Id_Instrumento
    ) 
    REFERENCES Instrumento 
    ( 
     Id_Instrumento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Compra 
    ADD CONSTRAINT Compra_Oficina_FK FOREIGN KEY 
    ( 
     Oficina_IdOficina
    ) 
    REFERENCES Oficina 
    ( 
     IdOficina 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Factura_Alquiler 
    ADD CONSTRAINT Factura_Alquiler_Alquiler_FK FOREIGN KEY 
    ( 
     Alquiler_Id_Alquiler, 
     Alquiler_Clientes_Id_Cliente, 
     Alquiler_Clientes_Localizacion_Id_Localizacion, 
     Alquiler_Oficina_IdOficina
    ) 
    REFERENCES Alquiler 
    ( 
     Id_Alquiler , 
     Clientes_Id_Cliente , 
     Clientes_Localizacion_Id_Localizacion , 
     Oficina_IdOficina 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Factura_Alquiler 
    ADD CONSTRAINT Factura_Alquiler_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_id_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Factura_Compra 
    ADD CONSTRAINT Factura_Compra_Compra_FK FOREIGN KEY 
    ( 
     Compra_Id_Compra, 
     Compra_Instrumento_Id_Instrumento, 
     Compra_Clientes_Id_Cliente, 
     Compra_Clientes_Localizacion_Id_Localizacion
    ) 
    REFERENCES Compra 
    ( 
     Id_Compra , 
     Instrumento_Id_Instrumento , 
     Clientes_Id_Cliente , 
     Clientes_Localizacion_Id_Localizacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Factura_Compra 
    ADD CONSTRAINT Factura_Compra_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_id_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Instrumento 
    ADD CONSTRAINT Instrumento_Categoria_FK FOREIGN KEY 
    ( 
     Categoria_Id_Categoria
    ) 
    REFERENCES Categoria 
    ( 
     Id_Categoria 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Instrumento 
    ADD CONSTRAINT Instrumento_Marca_FK FOREIGN KEY 
    ( 
     Marca_Id_Marca
    ) 
    REFERENCES Marca 
    ( 
     Id_Marca 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Oficina 
    ADD CONSTRAINT Oficina_Localizacion_FK FOREIGN KEY 
    ( 
     Localizacion_Id_Localizacion
    ) 
    REFERENCES Localizacion 
    ( 
     Id_Localizacion 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Paypal 
    ADD CONSTRAINT Paypal_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_id_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Tarjeta 
    ADD CONSTRAINT TARJETA_Metodo_Pago_FK FOREIGN KEY 
    ( 
     Metodo_Pago_id_Pago
    ) 
    REFERENCES Metodo_Pago 
    ( 
     id_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO
