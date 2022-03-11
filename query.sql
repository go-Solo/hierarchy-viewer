SELECT OD1.ObjectName as Name ,
  OD2.ObjectName as ReferenceName
FROM [TestLab].[dbo].[ObjectDataXref] as ODX
  inner join [TestLab].[dbo].[ObjectData] as OD1
  on ODX.ObjectId=OD1.Id
  inner join [TestLab].[dbo].[ObjectData] as OD2
  on  ODX.[ReferenceObjectId]=OD2.Id