using JuMP
import Cbc
mip_solver = optimizer_with_attributes(
    Cbc.Optimizer,
    MOI.Silent() => true
)
import OSQP
qp_solver = optimizer_with_attributes(
    OSQP.Optimizer,
    MOI.Silent() => true
)
import Gurobi
env = Gurobi.Env()
qp_solver = optimizer_with_attributes(
    () -> Gurobi.Optimizer(env),
    MOI.Silent() => true,
    # Without this, I get NumericalError in BemporadMorari called by BranchAndBound
    "DualReductions" => 0
)
import Ipopt
cont_solver = optimizer_with_attributes(
    Ipopt.Optimizer,
    MOI.Silent() => true
)
import Pavito
miqp_solver = optimizer_with_attributes(
    Pavito.Optimizer,
    "mip_solver" => mip_solver,
    # Can use OSQP after https://github.com/jump-dev/Pavito.jl/pull/36
    "cont_solver" => cont_solver,
    MOI.Silent() => true
)
