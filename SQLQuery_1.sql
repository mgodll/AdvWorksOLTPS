-- Pruebas para hacer la parte A

/*
SELECT Production.Product.Name AS NOMBRE,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       Sales.SalesOrderDetail.ModifiedDate AS FECHAS
FROM Sales.SalesOrderDetail
       CROSS JOIN Production.Product
*/
/*
SELECT Production.Product.Name AS NOMBRE,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       Sales.SalesOrderDetail.ModifiedDate AS FECHAS
FROM Sales.SalesOrderDetail
     --LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     LEFT JOIN Production.Product ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
*/
/*
SELECT Production.Product.Name AS Categoria,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       dbo.Calendario.Calendar_Date AS FECHAS
FROM Sales.SalesOrderDetail
     LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate
     LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
*/
/*
SELECT Production.ProductSubcategory.Name AS Categoria,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       dbo.Calendario.Calendar_Date AS FECHAS
FROM Sales.SalesOrderDetail
     LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate
     LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
     LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
*/
/*
SELECT Production.ProductCategory.Name AS Categoria,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       dbo.Calendario.Calendar_Date AS FECHAS
FROM Sales.SalesOrderDetail
     LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate
     LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
     LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
     RIGHT JOIN Production.ProductCategory  ON Production.ProductCategory.ProductCategoryID = Production.Product.ProductSubcategoryID
GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name, Sales.SalesOrderDetail.LineTotal
ORDER BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name, Sales.SalesOrderDetail.LineTotal
*/
/*
SELECT Production.ProductCategory.Name AS Categoria,
       Sales.SalesOrderDetail.LineTotal AS VENTAS,
       dbo.Calendario.Calendar_Date AS FECHAS
FROM Sales.SalesOrderDetail
     LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate
     LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
     LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
     CROSS JOIN Production.ProductCategory
GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name, Sales.SalesOrderDetail.LineTotal
ORDER BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name, Sales.SalesOrderDetail.LineTotal
*/
/*
SELECT Production.ProductCategory.Name AS Categoria,
       CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (Sales.SalesOrderDetail.LineTotal) ELSE 0.0 END AS TotalVentas,
       dbo.Calendario.Calendar_Date AS FECHAS
FROM Sales.SalesOrderDetail
     LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
     RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate
     LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
     LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
     CROSS JOIN Production.ProductCategory
     WHERE dbo.Calendario.Calendar_Date BETWEEN '2011-05-31 00:00:00.0000000' AND '2011-06-02 00:00:00.0000000' 
--GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
ORDER BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
*/
-- Parte A 1
/*
SELECT  Production.ProductCategory.Name AS Categoria,  
        dbo.Calendario.Calendar_Date AS Fecha,
        SUM (CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (Sales.SalesOrderDetail.LineTotal) ELSE 0.0 END) AS TotalVentas -- si coinciden son de la misma categoria para que se sumen
FROM Sales.SalesOrderDetail
    LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
    RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate -- si no existe las fechas de los registros en calendario no se tienen encuenta las ventas
    LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID -- no se toma la categoria
    LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
    CROSS JOIN Production.ProductCategory -- para tener encuenta todo los valores existentes 
WHERE dbo.Calendario.Calendar_Date BETWEEN '2011-05-31 00:00:00.0000000' AND '2011-07-07 00:00:00.0000000' -- el filtrado entre un rango
GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
ORDER BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
*/

--Parte B 1
/*
SELECT  Production.ProductCategory.Name AS Categoria,  
        CONVERT(VARCHAR(10), DATEPART(ISO_WEEK, dbo.Calendario.Calendar_Date)) + '-' + CONVERT(VARCHAR(10), DATEPART(YEAR, dbo.Calendario.Calendar_Date)) AS Fecha,
        SUM (CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (ROUND(Sales.SalesOrderDetail.LineTotal,2)) ELSE 0.0 END) AS TotalVentas -- si coinciden son de la misma categoria para que se sumen
FROM Sales.SalesOrderDetail
    LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
    RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate -- si no existe las fechas de los registros en calendario no se tienen encuenta las ventas
    LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID -- no se toma la categoria
    LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
    CROSS JOIN Production.ProductCategory -- para tener encuenta todo los valores existentes 
WHERE dbo.Calendario.Calendar_Date BETWEEN '2011-05-31 00:00:00.0000000' AND '2011-07-07 00:00:00.0000000' -- el filtrado entre un rango
GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
ORDER BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name
*/
------------------------------------------------------------------------------
--Parte 2.1
------------------------------------------------------------------------------
--FUNCION PIVOT

SELECT* INTO #PIVOT FROM(
SELECT  Production.ProductCategory.Name AS Categoria, 
        dbo.Calendario.Calendar_Date AS Fecha, 
        SUM (CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (Sales.SalesOrderDetail.LineTotal) ELSE 0.0 END) AS TotalVentas -- si coinciden son de la misma categoria para que se sumen 
FROM Sales.SalesOrderDetail 
    LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
    RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate -- si no existe las fechas de los registros en calendario no se tienen encuenta las ventas 
    LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID -- no se toma la categoria 
    LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
    CROSS JOIN Production.ProductCategory -- para tener encuenta todo los valores existentes 
    --WHERE dbo.Calendario.Calendar_Date BETWEEN '2011-06-11 00:00:00.0000000' AND '2011-06-15 00:00:00.0000000' -- el filtrado entre un rango
    GROUP BY dbo.Calendario.Calendar_Date, Production.ProductCategory.Name ) T

/*
SELECT * FROM #PIVOT
PIVOT (SUM(TotalVentas) FOR Fecha IN ([2011-06-11],[2011-06-15]) ) AS FPV
*/
--FUNCION PIVOT DINAMICO

DECLARE @DIA NVARCHAR(MAX)
SET @DIA = ''
SELECT @DIA = @DIA + '[' + FECHAS + '],' 
FROM(
    SELECT DISTINCT  CONVERT( VARCHAR(100), PRUEBAS.Calendar_Date,23) AS FECHAS  
    FROM dbo.Calendario AS PRUEBAS 
) TT
SET @DIA = LEFT(@DIA, LEN(@DIA)-1)
--SELECT @DIA
EXEC ('
SELECT * FROM #PIVOT
PIVOT (SUM(TotalVentas) FOR Fecha IN ('+ @DIA +') ) AS FPV
') -- AMBIENTE DE CADENA
-- FECHA SON LAS BASES DE LAS COLUMNAS PIVOTADAS Y DIA SON LOS NOMBRES DE LAS COLUMNAS PIVOTADAS
*/
------------------------------------------------------------------------------
--PARTE 2.2
-------------------------------------------------------------------------------
/*
CREATE VIEW Sales_W
AS
SELECT Production.ProductCategory.Name AS Categoria, --Seleciona NombreCategoria y Fechas.
    'Sem ' + CONVERT(varchar(MAX) , dbo.Calendario.Week_of_Year_ISO) + ' - ' + CONVERT (varchar(MAX), dbo.Calendario.Year_ISO) AS Fecha,
        SUM (CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (Sales.SalesOrderDetail.LineTotal) ELSE 0.0 END) AS TotalVentas -- si coinciden son de la misma categoria para que se sumen 
FROM Sales.SalesOrderDetail 
    LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
    RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate -- si no existe las fechas de los registros en calendario no se tienen encuenta las ventas 
    LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID -- no se toma la categoria 
    LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
    CROSS JOIN Production.ProductCategory -- para tener encuenta todo los valores existentes 
    GROUP BY dbo.Calendario.Week_of_Year_ISO, dbo.Calendario.Year_ISO,  Production.ProductCategory.Name
GO

DECLARE @Prue VARCHAR(MAX)
SET @Prue = ''
SELECT @Prue = @Prue + '[' + B.FC + '],'
FROM (SELECT DISTINCT 'Sem ' + CONVERT(VARCHAR(MAX), Week_of_Year_ISO) + ' - ' + CONVERT (VARCHAR(MAX), Year_ISO) AS FC FROM dbo.Calendario) AS B
SET @Prue = LEFT(@Prue, LEN(@Prue)-1)
--SELECT @Prue
EXECUTE ('
SELECT * FROM dbo.Sales_W
PIVOT (SUM(TotalVentas) FOR [Fecha] IN ('+ @Prue+')) AS pvt')
*/
----------------------------------------------------------------------------------
--PARTE 2.3
----------------------------------------------------------------------------------
/*
CREATE VIEW Sales_M
AS
SELECT Production.ProductCategory.Name AS Categoria, --Seleciona NombreCategoria y Fechas.
    CONVERT(varchar(MAX),  dbo.Calendario.Calendar_Month)+ ' ' +CONVERT(varchar(MAX),  dbo.Calendario.Month_Name_Abbreviation) + ' ' + CONVERT (varchar(MAX),  dbo.Calendario.Calendar_Year) AS Fecha,
        SUM (CASE WHEN (Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID) THEN (Sales.SalesOrderDetail.LineTotal) ELSE 0.0 END) AS TotalVentas -- si coinciden son de la misma categoria para que se sumen 
FROM Sales.SalesOrderDetail 
    LEFT JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
    RIGHT JOIN dbo.Calendario  ON dbo.Calendario.Calendar_Date = Sales.SalesOrderHeader.OrderDate -- si no existe las fechas de los registros en calendario no se tienen encuenta las ventas 
    LEFT JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID -- no se toma la categoria 
    LEFT JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
    CROSS JOIN Production.ProductCategory -- para tener encuenta todo los valores existentes 
    GROUP BY dbo.Calendario.Calendar_Month, dbo.Calendario.Month_Name_Abbreviation, dbo.Calendario.Calendar_Year, Production.ProductCategory.Name
GO

DECLARE @FP VARCHAR(MAX)
SET @FP = ''
SELECT @FP = @FP + '[' + LL.FC + '],'
FROM (SELECT DISTINCT CONVERT(varchar (MAX), Calendar_Month)+ ' ' +CONVERT(varchar (MAX), Month_Name_Abbreviation) + ' ' + CONVERT (varchar(MAX), Calendar_Year) AS FC FROM dbo.Calendario) AS LL
SET @FP = LEFT(@FP, LEN(@FP)-1)
--SELECT @FechaPivot
EXECUTE ('
SELECT * FROM dbo.Sales_M
PIVOT (SUM(TotalVentas) FOR [Fecha] IN ('+ @FP+')) AS pvt')
*/