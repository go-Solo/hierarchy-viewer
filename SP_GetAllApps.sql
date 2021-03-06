USE [TestLab]
GO
/****** Object:  StoredProcedure [dbo].[GetAllApps]    Script Date: 23-04-2022 20:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[GetAllApps]
AS
BEGIN 
	SET NOCOUNT ON;

  SELECT Distinct ODX.[ObjectId] as Id, OD.ObjectName 
  FROM [TestLab].[dbo].[ObjectDataXref] as ODX inner join 
  [TestLab].[dbo].[ObjectData] as OD on 
  ODX.[ObjectId]=OD.Id
  union 

  SELECT Distinct ODX.[ReferenceObjectId] as Id, OD.ObjectName    
  FROM [TestLab].[dbo].[ObjectDataXref] as ODX inner join 
    [TestLab].[dbo].[ObjectData] as OD on 
  ODX.[ReferenceObjectId]=OD.Id
  order by ObjectName;
  return 0;
END
