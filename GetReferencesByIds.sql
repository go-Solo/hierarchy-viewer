USE [TestLab]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or ALTER PROCEDURE [dbo].[GetReferencesByIds]
    @ObjecIds  VARCHAR(MAX),
    @Level INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ObjIds AS TABLE (Id INT);
    INSERT INTO @ObjIds
        ( Id )
    SELECT
        splitdata
    FROM [dbo].[fnSplitString] (@ObjecIds, ',');


    SELECT
        OD1.Id,
        OD1.ObjectName AS Name,
        OD2.ObjectName AS ReferenceName,
        OD2.Id,
        @Level
    FROM TestLab.dbo.ObjectDataXref AS ODX
        INNER JOIN TestLab.dbo.ObjectData AS OD1
        ON ODX.ObjectId = OD1.Id
        INNER JOIN TestLab.dbo.ObjectData AS OD2
        ON ODX.ReferenceObjectId = OD2.Id
        INNER JOIN @ObjIds AS OId
        ON OId.Id = Od1.Id
    WHERE OD2.Id<> 772;
    RETURN 0;
END;
