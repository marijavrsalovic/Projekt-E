import gurobipy as gp
from gurobipy import GRB

# DEKLARIRANJE VARIJABLI POMOĆU RJEČNIKA
ch = {}   # PUNJENJE BATERIJE
dch = {}  # PRAŽNJENJE BATERIJE
soe = {}  # STANJE NAPUNJENOSTI BATERIJE
x = {}    # BINARNA VARIJABLA: PUNJENJE / PRAŽNJENJE

# KREIRANJE MODELA (pretpostavljam da ti treba)
model = gp.Model("baterija")

# UČINKOVITOST PUNJENJA I PRAŽNJENJA
eff = 0.9

# KAPACITET BATERIJE
C = 1.0 # zamijeniti s pravim kapacitetom

# MAKSIMALNA SNAGA PUNJENJA/PRAZNJENJA
Pmax = 1.0

# POČETNO STANJE NAPUNJENOSTI
soe[0] = 0.0

# DEFINIRANJE VARIJABLI ZA 3 SATA
for t in range(1, 4): #radim u periodu od 3h
    ch[t] = model.addVar(lb=0, ub=GRB.INFINITY, name=f"ch_{t}")
    dch[t] = model.addVar(lb=0, ub=GRB.INFINITY, name=f"dch_{t}")
    soe[t] = model.addVar(lb=0, ub=GRB.INFINITY, name=f"soe_{t}")
    x[t] = model.addVar(vtype=GRB.BINARY, name=f"x_{t}")

# DEFINIRANJE OGRANIČENJA
for t in range(1, 4):
    model.addConstr(
        soe[t] == soe[t - 1] + ch[t] * eff - dch[t] / eff,
        name=f"balans_{t}",
    )
    model.addConstr(soe[t] <= C, name=f"kapacitet_{t}")
    model.addConstr(ch[t] <= Pmax * x[t], name=f"max_ch_{t}")
    model.addConstr(dch[t] <= Pmax * (1 - x[t]), name=f"max_dch_{t}")

def cost():
    temp = 0.0
    for t in range(1, 25):
        temp += prices.DAM[t - 1] * (dch[t] - ch[t])
    return temp
