--FILESTREAM/FILETABLE-------------------------------------------
USE master 
GO
--Cambiamos el parámetro de configuración para indicar el nivel de acceso a filestream
--Despues de esta opciòn debemos reiniciar el servicio
EXEC sp_configure filestream_access_level, 2
RECONFIGURE
GO

USE Tienda_MusicalV2
GO

DROP TABLE IF EXISTS DBO.DOCUMENTOS_TIENDAMUSICAL
GO
--Creamos la tabla donde se almacenara la información
CREATE TABLE DBO.DOCUMENTOS_TIENDAMUSICAL
(
	ID INT IDENTITY,
	NOMBRE_INSTRUMENTO VARCHAR(255),
	CONTENIDO VARBINARY(MAX),
	EXTENSION CHAR(4)
)
GO
--Insertamos los documentos, 3 archivos con extension JPG
INSERT INTO DBO.DOCUMENTOS_TIENDAMUSICAL (NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT 'fender_am_pro', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\fender_am_pro.JPG', SINGLE_BLOB) AS DOCUMENT
--(1 row affected)
--Completion time: 2023-03-15T15:12:08.8001833+01:00

INSERT INTO DBO.DOCUMENTOS_TIENDAMUSICAL (NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT 'fgn_fujigen', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\fgn_fujigen.JPG', SINGLE_BLOB) AS DOCUMENT
--(1 row affected)
--Completion time: 2023-03-15T15:13:05.4946838+01:00

INSERT INTO DBO.DOCUMENTOS_TIENDAMUSICAL (NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT 'squier_cv', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\squier_cv.JPG', SINGLE_BLOB) AS DOCUMENT
--(1 row affected)
--Completion time: 2023-03-15T15:14:12.0807154+01:00

--Verificamos que se añadio la información
SELECT * FROM DOCUMENTOS_TIENDAMUSICAL

--Filestream con imágenes en el sistema operativo.-------------------------------------------
USE Tienda_MusicalV2
GO

DROP TABLE IF EXISTS DBO.DOCUMENTOS_FSINSTRUMENTOS
GO

CREATE TABLE DBO.DOCUMENTOS_FSINSTRUMENTOS
(
	ID INT IDENTITY,
	ID2 UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
	NOMBRE_INSTRUMENTO VARCHAR(255),
	CONTENIDO VARBINARY(MAX) FILESTREAM,
	EXTENSION CHAR(4)
)
GO

INSERT INTO DBO.DOCUMENTOS_FSINSTRUMENTOS (ID2, NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT NEWID(), 'fender_am_pro', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\fender_am_pro.JPG', SINGLE_BLOB) AS DOCUMENT
--(1 row affected)
--Completion time: 2023-03-15T23:36:48.2144725+01:00
--El contenido queda guardado en Filesystem
INSERT INTO DBO.DOCUMENTOS_FSINSTRUMENTOS (ID2, NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT NEWID(),'fgn_fujigen', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\fgn_fujigen.JPG', SINGLE_BLOB) AS DOCUMENT

INSERT INTO DBO.DOCUMENTOS_FSINSTRUMENTOS (ID2, NOMBRE_INSTRUMENTO, CONTENIDO, EXTENSION)
SELECT NEWID(),'squier_cv', Bulkcolumn, 'JPG'
FROM OPENROWSET(BULK N'C:\Img\squier_cv.JPG', SINGLE_BLOB) AS DOCUMENT

SELECT * FROM DBO.DOCUMENTOS_FSINSTRUMENTOS 

--Filetable------------------------------------------------------------------------
USE [master]
GO
--Forzamos la desconexion de los usuarios de forma inmediata (rollback immediate)
ALTER DATABASE [Tienda_MusicalV2] 
SET FILESTREAM( DIRECTORY_NAME = N'Triggerdb' ) WITH 
rollback immediate
GO
--Nonqualified transactions are being rolled back. Estimated rollback completion: 0%.
--Nonqualified transactions are being rolled back. Estimated rollback completion: 100%.
--Completion time: 2023-03-16T00:39:23.0932732+01:00

USE [master]
GO
--Insertamos el codigo generado para usar el filetable dentro de la base de datos
ALTER DATABASE [Tienda_MusicalV2] 
SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL, 
DIRECTORY_NAME = N'Triggerdb' ) WITH NO_WAIT
GO
--Vamos a crear una tabla nueva de tipo filetable e indicamos el directorio donde se guarda
USE Tienda_MusicalV2
GO
DROP TABLE IF EXISTS AlmacenDocumentos
GO
CREATE TABLE AlmacenDocumentos AS FileTable
WITH
(
	FileTable_Directory = 'AlmacenDocumentos',
	FileTable_Collate_Filename = database_default,
	FILETABLE_STREAMID_UNIQUE_CONSTRAINT_NAME=UQ_STREAM_ID
);
GO
--Commands completed successfully.
--Completion time: 2023-03-16T00:52:05.3601812+01:00


