USE [TestLab]
GO
/****** Object:  StoredProcedure [dbo].[GetAllReferences]    Script Date: 23-04-2022 20:16:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- ============================================= 
CREATE OR ALTER PROCEDURE [dbo].[GetAllReferences]  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT OD.ObjectName,OD2.ObjectName
  FROM [TestLab].[dbo].[ObjectDataXref] as ODX inner join 
  [TestLab].[dbo].[ObjectData] as OD on 
  ODX.[ObjectId]=OD.Id
  inner join 
  [TestLab].[dbo].[ObjectData] as OD2 on 
  ODX.ReferenceObjectId=OD2.Id 
 return 0;
END
