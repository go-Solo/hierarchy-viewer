import networkx as nx
import pyodbc
from pyvis.network import Network

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=TLTTVMLT218;'
                      'Database=TestLab;'
                      'Trusted_Connection=yes;')

cursor = conn.cursor()
cursor.execute(
    'SELECT OD1.ObjectName as Name ,OD2.ObjectName as ReferenceName FROM [TestLab].[dbo].[ObjectDataXref] as ODX inner join [TestLab].[dbo].[ObjectData] as OD1   on ODX.ObjectId=OD1.Id   inner join [TestLab].[dbo].[ObjectData] as OD2  on  ODX.[ReferenceObjectId]=OD2.Id;')
G = nx.Graph()

for i in cursor:
    G.add_edge(i[0], i[1],physics=False)
nx.draw(G, with_labels=True)
nt = Network(height='100%', width='100%')
nt.from_nx(G)
nt.show('nx.html')
