USE [Tienda_MusicalV2]
go
DROP TABLE IF EXISTS FotoTienda
GO
CREATE Table FotoTienda
(
    FotoId int,
    FotoTiendaName varchar(255),
   FotoTiendaImage  varbinary(max)
)
go

INSERT INTO dbo.FotoTienda
( 
  FotoId,
  FotoTiendaName,
  FotoTiendaImage
)  
SELECT  1,'Guitarra Acústica',  
      * FROM OPENROWSET  
      ( BULK 'C:\Img\GuitarraAcustica.JPG',SINGLE_BLOB)  as ImageFile
GO
--(1 row affected)
--Completion time: 2023-03-16T02:18:41.8108638+01:00
INSERT INTO dbo.FotoTienda
( 
  FotoId,
  FotoTiendaName,
  FotoTiendaImage
)  
SELECT  2,'Guitarra Eléctrica',  
      * FROM OPENROWSET  
      ( BULK 'C:\Img\GuitarraElectrica.JPG',SINGLE_BLOB)  as ImageFile
GO
--(1 row affected)
--Completion time: 2023-03-16T02:19:05.7840336+01:00
INSERT INTO dbo.FotoTienda
( 
  FotoId,
  FotoTiendaName,
  FotoTiendaImage
)  
SELECT  3,'Bajos',  
      * FROM OPENROWSET  
      ( BULK 'C:\Img\Bajos.JPG',SINGLE_BLOB)  as ImageFile
go
--(1 row affected)
--Completion time: 2023-03-16T02:19:33.7835758+01:00
SELECT * FROM FotoTienda
GO


-- Instalando desde Microsoft Store

-- Get Data, SQL Server, Login to your SQL Server, and pick your table that
-- stores images.
-- NAVEGADOR. TRANSFORMAR.
-- Change the binary column to Text
-- = Table.TransformColumnTypes(dbo_FotoTienda,{{"FotoTiendaImage", type text}})
-- Now create a custom column and append a URI to tell Power BI these are png images. If
-- using jpeg use jpeg instead of png.

--Close & Apply the data.
--This is an important step. In the Modeling tab, change the image column ([FotoTienda]) to a
--Data Category of Image URL.


-- Cambiar Personalizado por Foto

--  Table.AddColumn(#"Tipo cambiado", "Personalizado", each "data:image/JFIF;base64," & [FotoTiendaImage])

-- Now you can use a visuals, like a table, and display your images that came from a SQL
-- Server vs. having to find a way to store images on a public internet site.