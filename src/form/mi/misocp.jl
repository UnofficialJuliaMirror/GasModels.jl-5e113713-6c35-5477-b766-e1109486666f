# Define MISOCP implementations of Gas Models

export
    MISOCPGasModel, StandardMISOCPForm

""
abstract type AbstractMISOCPForm <: AbstractGasFormulation end

""
abstract type StandardMISOCPForm <: AbstractMISOCPForm end

const MISOCPGasModel = GenericGasModel{StandardMISOCPForm} # the standard MISCOP model

"default MISOCP constructor"
MISOCPGasModel(data::Dict{String,Any}; kwargs...) = GenericGasModel(data, StandardMISOCPForm)

""
function variable_mass_flow(gm::GenericGasModel{T}, n::Int=gm.cnw; bounded::Bool = true) where T <: AbstractMISOCPForm
    max_flow = ref(gm,n,:max_mass_flow)
    resistance = Dict{Int, Float64}()

    for (i,pipe) in ref(gm,n,:pipe)
        resistance[i] = ref(gm, n, :w)[i]
    end

    for (i,pipe) in ref(gm,n,:resistor)
        resistance[i] = ref(gm, n, :w)[i]
    end

    if bounded
        gm.var[:nw][n][:l] = @variable(gm.model, [i in [collect(keys(gm.ref[:nw][n][:pipe])); collect(keys(gm.ref[:nw][n][:resistor])) ]], base_name="$(n)_l", lower_bound=0.0, upper_bound=1/resistance[i] * max_flow^2, start = getstart(gm.ref[:nw][n][:connection], i, "l_start", 0))
        gm.var[:nw][n][:f] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:connection])], base_name="$(n)_f", lower_bound=-max_flow, upper_bound=max_flow, start = getstart(gm.ref[:nw][n][:connection], i, "f_start", 0))
    else
        gm.var[:nw][n][:l] = @variable(gm.model, [i in [collect(keys(gm.ref[:nw][n][:pipe])); collect(keys(gm.ref[:nw][n][:resistor])) ]], base_name="$(n)_l", start = getstart(gm.ref[:nw][n][:connection], i, "l_start", 0))
        gm.var[:nw][n][:f] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:connection])], base_name="$(n)_f", start = getstart(gm.ref[:nw][n][:connection], i, "f_start", 0))
    end
end

""
function variable_mass_flow_ne(gm::GenericGasModel{T}, n::Int=gm.cnw; bounded::Bool = true) where T <: AbstractMISOCPForm
    max_flow = ref(gm,n,:max_mass_flow)
    resistance = Dict{Int, Float64}()

    for (i,pipe) in  ref(gm,n,:ne_pipe)
        resistance[i] = ref(gm,n,:w_ne)[i]#pipe_resistance(gm.data, pipe)
    end

    if bounded
        gm.var[:nw][n][:l_ne] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:ne_pipe])], base_name="$(n)_l_ne", lower_bound=0.0, upper_bound=1/resistance[i] * max_flow^2, start = getstart(gm.ref[:nw][n][:ne_connection], i, "l_start", 0))
        gm.var[:nw][n][:f_ne] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:ne_connection])], base_name="$(n)_f_ne", lower_bound=-max_flow, upper_bound=max_flow, start = getstart(gm.ref[:nw][n][:ne_connection], i, "f_start", 0))
    else
        gm.var[:nw][n][:l_ne] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:ne_pipe])], base_name="$(n)_l_ne", start = getstart(gm.ref[:nw][n][:ne_connection], i, "l_start", 0))
        gm.var[:nw][n][:f_ne] = @variable(gm.model, [i in keys(gm.ref[:nw][n][:ne_connection])], base_name="$(n)_f_ne", start = getstart(gm.ref[:nw][n][:ne_connection], i, "f_start", 0))
    end
end

" Weymouth equation for an undirected pipe "
function constraint_pipe_weymouth(gm::GenericGasModel{T}, n::Int, k, i, j, f_min, f_max, w, pd_min, pd_max) where T <: AbstractMISOCPForm
    y = var(gm,n,:y,k)
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    l  = var(gm,n,:l,k)
    f  = var(gm,n,:f,k)

   add_constraint(gm, n, :weymouth1, k, @constraint(gm.model, l >= pj - pi + pd_min*(2*y)))
   add_constraint(gm, n, :weymouth2, k, @constraint(gm.model, l >= pi - pj + pd_max*(2*y-2)))
   add_constraint(gm, n, :weymouth3, k, @constraint(gm.model, l <= pj - pi + pd_max*(2*y)))
   add_constraint(gm, n, :weymouth4, k, @constraint(gm.model, l <= pi - pj + pd_min*(2*y-2)))
   add_constraint(gm, n, :weymouth5, k, @constraint(gm.model, w*l >= f^2))

   add_constraint(gm, n, :weymouth6, k, @constraint(gm.model, w*l <= f_max * f + (1-y) * (abs(f_min*f_max) + f_min^2)))
   add_constraint(gm, n, :weymouth7, k, @constraint(gm.model, w*l <= f_min * f + y     * (abs(f_min*f_max) + f_max^2)))
end

" Weymouth equation for an undirected pipe "
function constraint_resistor_weymouth(gm::GenericGasModel{T}, n::Int, k, i, j, f_min, f_max, w, pd_min, pd_max) where T <: AbstractMISOCPForm
    y = var(gm,n,:y,k)
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    l  = var(gm,n,:l,k)
    f  = var(gm,n,:f,k)

   add_constraint(gm, n, :weymouth1, k, @constraint(gm.model, l >= pj - pi + pd_min*(2*y)))
   add_constraint(gm, n, :weymouth2, k, @constraint(gm.model, l >= pi - pj + pd_max*(2*y-2)))
   add_constraint(gm, n, :weymouth3, k, @constraint(gm.model, l <= pj - pi + pd_max*(2*y)))
   add_constraint(gm, n, :weymouth4, k, @constraint(gm.model, l <= pi - pj + pd_min*(2*y-2)))
   add_constraint(gm, n, :weymouth5, k, @constraint(gm.model, w*l >= f^2))

   add_constraint(gm, n, :weymouth6, k, @constraint(gm.model, w*l <= f_max * f + (1-y) * (abs(f_min*f_max) + f_min^2)))
   add_constraint(gm, n, :weymouth7, k, @constraint(gm.model, w*l <= f_min * f + y     * (abs(f_min*f_max) + f_max^2)))
end

"Weymouth equation with a pipe with one way flow"
function constraint_pipe_weymouth_directed(gm::GenericGasModel{T}, n::Int, k, i, j, w, f_min, f_max, direction) where T <: AbstractMISOCPForm
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    l  = var(gm,n,:l,k)
    f  = var(gm,n,:f,k)

    add_constraint(gm, n, :weymouth1, k, @constraint(gm.model, l == direction * (pi - pj)))
    add_constraint(gm, n, :weymouth5, k, @constraint(gm.model, w*l >= f^2))
    if (direction == 1)
        add_constraint(gm, n, :weymouth6, k, @constraint(gm.model, w*l <= f_max * f))
    else
        add_constraint(gm, n, :weymouth7, k, @constraint(gm.model, w*l <= f_min * f))
    end
end

"Weymouth equation with a resistor with one way flow"
function constraint_resistor_weymouth_directed(gm::GenericGasModel{T}, n::Int, k, i, j, w, f_min, f_max, direction) where T <: AbstractMISOCPForm
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    l  = var(gm,n,:l,k)
    f  = var(gm,n,:f,k)

    add_constraint(gm, n, :weymouth1, k, @constraint(gm.model, l == direction * (pi - pj)))
    add_constraint(gm, n, :weymouth5, k, @constraint(gm.model, w*l >= f^2))
    if (direction == 1)
        add_constraint(gm, n, :weymouth6, k, @constraint(gm.model, w*l <= f_max * f))
    else
        add_constraint(gm, n, :weymouth7, k, @constraint(gm.model, w*l <= f_min * f))
    end
end

"Weymouth equation for an undirected expansion pipe"
function constraint_pipe_weymouth_ne(gm::GenericGasModel{T},  n::Int, k, i, j, w, f_min, f_max, pd_min, pd_max) where T <: AbstractMISOCPForm
    y = var(gm,n,:y_ne,k)
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    zp = var(gm,n,:zp,k)
    l  = var(gm,n,:l_ne,k)
    f  = var(gm,n,:f_ne,k)

    add_constraint(gm, n, :weymouth_ne1, k,  @constraint(gm.model, l >= pj - pi + pd_min*(2*y)))
    add_constraint(gm, n, :weymouth_ne2, k,  @constraint(gm.model, l >= pi - pj + pd_max*(2*y-2)))
    add_constraint(gm, n, :weymouth_ne3, k,  @constraint(gm.model, l <= pj - pi + pd_max*(2*y)))
    add_constraint(gm, n, :weymouth_ne4, k,  @constraint(gm.model, l <= pi - pj + pd_min*(2*y-2)))
    add_constraint(gm, n, :weymouth_ne5, k,  @constraint(gm.model, zp*w*l >= f^2))

    add_constraint(gm, n, :weymouth_ne6, k, @constraint(gm.model, w*l <= f_max * f + (1-y) * (abs(f_min*f_max) + f_min^2) + (1-zp) * (abs(f_min*f_max) + f_min^2)))
    add_constraint(gm, n, :weymouth_ne7, k, @constraint(gm.model, w*l <= f_min * f + y     * (abs(f_min*f_max) + f_max^2) + (1-zp) * (abs(f_min*f_max) + f_max^2)))
end

"Weymouth equation for expansion pipes with undirected expansion pipes"
function constraint_pipe_weymouth_ne_directed(gm::GenericGasModel{T},  n::Int, k, i, j, w, pd_min, pd_max, f_min, f_max, direction) where T <:  AbstractMISOCPForm
    pi = var(gm,n,:p,i)
    pj = var(gm,n,:p,j)
    zp = var(gm,n,:zp,k)
    l  = var(gm,n,:l_ne,k)
    f  = var(gm,n,:f_ne,k)

    add_constraint(gm, n, :weymouth_ne1, k, @constraint(gm.model, l == direction * (pi - pj)))
    add_constraint(gm, n, :weymouth_ne5, k, @constraint(gm.model, zp*w*l >= f^2))
    if (direction == 1)
        add_constraint(gm, n, :weymouth_ne6, k, @constraint(gm.model, w*l <= f_max * f + (1-zp) * (abs(f_min*f_max) + f_min^2)))
    else
        add_constraint(gm, n, :weymouth_ne7, k, @constraint(gm.model, w*l <= f_min * f + (1-zp) * (abs(f_min*f_max) + f_max^2)))
    end

end