import pyodbc
from flask import Flask, render_template, request
from flask_wtf import FlaskForm
from wtforms import SelectField
import networkx as nx
from pyvis.network import Network

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret'


class Form(FlaskForm):
    apps = SelectField('apps', choices=[])


conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=TLTTVMLT218;'
                      'Database=TestLab;'
                      'Trusted_Connection=yes;')
edges = []
tookReference = []
references = []
edges = []


def getInitialReference(appName):
    global edges
    cursor = conn.cursor()
    sql = "EXEC TestLab.dbo.GetInitialReferences @AppName='"+appName+"';"
    cursor.execute(sql)
    for i in cursor:
        edges.append((i[0], i[1]))
    a = set([x[1] for x in edges] + [x[0] for x in edges])
    a = set(a) - set(tookReference)
    return a


@app.route('/', methods=['GET', 'POST'])
def index():
    form = Form()
    cursor = conn.cursor()
    sql = "EXEC GetAllApps;"
    cursor.execute(sql)
    refs = []
    refs.append(('GetAll', '--Get All Nodes--'))
    for i in cursor:
        refs.append((i[1], i[1]))
    form.apps.choices = refs
    if request.method == 'POST':
        appName = form.apps.data
        if appName == 'GetAll':
            G = nx.Graph()
            cursor = conn.cursor()
            sql = "EXEC TestLab.dbo.GetAllReferences;"
            cursor.execute(sql)
            for i in cursor:
                G.add_edge(i[0], i[1])
            nx.draw(G, with_labels=True)
            nt = Network(height='100%', width='100%')
            nt.from_nx(G)
            # nt.toggle_physics(False)
            nt.show('nx.html')
        else:
            global edges
            edges.clear()
            global tookReference
            tookReference.clear()
            global references
            references.clear()
            references.append(appName)
            while len(references) > 0:
                tookReference.append(references[0])
                x = getInitialReference(references[0])
                references.pop(0)
                references.extend(x)
                references = list(dict.fromkeys(references))
            G = nx.Graph()
            for i in edges:
                G.add_edge(i[0], i[1])
            nx.draw(G, with_labels=True)
            nt = Network(height='100%', width='100%')
            nt.from_nx(G)
            nt.toggle_physics(False)
            nt.show('nx.html')

    return render_template('index.html', form=form)


if __name__ == '__main__':
    app.run(debug=True)
