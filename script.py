import sys
import networkx as nx
import pyodbc
from pyvis.network import Network
import sys

objectName = str(sys.argv[1])
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=TLTTVMLT218;'
                      'Database=TestLab;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()
sql = "EXEC TestLab.dbo.GetReferencesLinks @ObjectName ='"+objectName + "';"
cursor.execute(sql)
G = nx.Graph()
for i in cursor:
    G.add_edge(i[1], i[2])
nx.draw(G, with_labels=True)
nt = Network(height='100%', width='100%')
nt.from_nx(G)
nt.show('nx.html')
