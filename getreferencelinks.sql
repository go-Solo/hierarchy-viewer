USE [TestLab]
GO
/****** Object:  StoredProcedure [dbo].[GetReferencesLinks]    Script Date: 05-04-2022 18:16:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or ALTER PROCEDURE [dbo].[GetReferencesLinks]
    @ObjectName  VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ObjectId INT;
    DECLARE @ObjectIds VARCHAR(MAX);
    DECLARE @Level INT;
    DECLARE @IsExitLoop BIT;
    DECLARE @ReferenceLinks AS TABLE
      (
        ObjectId INT,
        ObjectName VARCHAR(200),
        ReferenceName VARCHAR(200),
        ReferenceId INT,
        Level INT
      );
    DECLARE @ReferenceLinkLevels AS TABLE
      (
        ObjectId INT,
        ObjectName VARCHAR(200),
        ReferenceName VARCHAR(200),
        ReferenceId INT,
        Level INT
      );

    SET @Level = 1;
    SELECT
        @ObjectId = Id
    FROM TestLab.dbo.ObjectData
    WHERE Objectname = @ObjectName;

    INSERT INTO @ReferenceLinks
        ( ObjectId, ObjectName, ReferenceName, ReferenceId, Level)
    EXEC TestLab.dbo.GetReferencesByIds @ObjectId, @Level;

    SET @IsExitLoop = 0;
    WHILE @Level <= 10
        OR @IsExitLoop = 1
      BEGIN

        SELECT
            @ObjectIds = COALESCE(@ObjectIds + ',', '') + CAST(ReferenceId AS VARCHAR(5))
        FROM @ReferenceLinks
        WHERE Level = @Level;

        SET @Level = @Level + 1;
        INSERT INTO @ReferenceLinkLevels
            (ObjectId, ObjectName, ReferenceName, ReferenceId, Level)
        EXEC TestLab.dbo.GetReferencesByIds @ObjectIds, @Level;

        INSERT INTO @ReferenceLinks
            ( ObjectId, ObjectName, ReferenceName, ReferenceId, Level )
        SELECT
            rll.*
        FROM @ReferenceLinkLevels AS rll
            LEFT OUTER JOIN @ReferenceLinks AS rl
            ON rll.ReferenceId = rl.ReferenceId
        WHERE rl.ReferenceId IS NULL;

        IF NOT EXISTS ( SELECT *
        FROM @ReferenceLinkLevels )
          BEGIN
            SET @IsExitLoop = 1;
        END;

        DELETE FROM @ReferenceLinkLevels;


    END;
    SELECT
        *
    FROM @ReferenceLinks;
    RETURN 0;
END;
