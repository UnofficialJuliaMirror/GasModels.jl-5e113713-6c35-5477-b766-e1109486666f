######################################################################################
# Constraints associated witn cutting planes on the direction variables
######################################################################################

" Template: Constraints for ensuring that at least one direction is set to take flow away from a junction (typically used on source nodes) "
function constraint_source_flow(gm::GenericGasModel{T}, n::Int, i) where T <: AbstractMIForms
    f_branches    = ref(gm,n,:f_connections,i)
    t_branches    = ref(gm,n,:t_connections,i)
    constraint_source_flow(gm, n, i, f_branches, t_branches)
end
constraint_source_flow(gm::GenericGasModel, i::Int) = constraint_source_flow(gm, gm.cnw, i)

" Template: Constraints for ensuring that at least one direction is set to take flow away from a junction (typically used on source nodes) "
function constraint_source_flow_ne(gm::GenericGasModel{T}, n::Int, i) where T <: AbstractMIForms
    f_branches       = ref(gm,n,:f_connections,i)
    t_branches       = ref(gm,n,:t_connections,i)
    f_branches_ne    = ref(gm,n,:f_ne_connections,i)
    t_branches_ne    = ref(gm,n,:t_ne_connections,i)
    constraint_source_flow_ne(gm, n, i, f_branches, t_branches, f_branches_ne, t_branches_ne)
end
constraint_source_flow_ne(gm::GenericGasModel, i::Int) = constraint_source_flow_ne(gm, gm.cnw, i)

" Template: Constraints for ensuring that at least one direction is set to take flow away from a junction (typically used on sink nodes) "
function constraint_sink_flow(gm::GenericGasModel{T}, n::Int, i) where T <: AbstractMIForms
    f_branches    = ref(gm,n,:f_connections,i)
    t_branches    = ref(gm,n,:t_connections,i)
    constraint_sink_flow(gm, n, i, f_branches, t_branches)
end
constraint_sink_flow(gm::GenericGasModel, i::Int) = constraint_sink_flow(gm, gm.cnw, i)

" Template: Constraints for ensuring that at least one direction is set to take flow away from a junction (typically used on sink nodes) "
function constraint_sink_flow_ne(gm::GenericGasModel{T}, n::Int, i) where T <: AbstractMIForms
    f_branches       = ref(gm,n,:f_connections,i)
    t_branches       = ref(gm,n,:t_connections,i)
    f_branches_ne    = ref(gm,n,:f_ne_connections,i)
    t_branches_ne    = ref(gm,n,:t_ne_connections,i)
    constraint_sink_flow_ne(gm, n, i, f_branches, t_branches, f_branches_ne, t_branches_ne)
end
constraint_sink_flow_ne(gm::GenericGasModel, i::Int) = constraint_sink_flow_ne(gm, gm.cnw, i)

" Template: Constraints to ensure that flow is the same direction through a node with degree 2 and no production or consumption "
function constraint_conserve_flow(gm::GenericGasModel{T}, n::Int, idx) where T <: AbstractMIForms
    f_pipes          = ref(gm,n,:f_pipes,idx)
    t_pipes          = ref(gm,n,:t_pipes,idx)
    f_compressors    = ref(gm,n,:f_compressors,idx)
    t_compressors    = ref(gm,n,:t_compressors,idx)
    f_resistors      = ref(gm,n,:f_resistors,idx)
    t_resistors      = ref(gm,n,:t_resistors,idx)
    f_short_pipes    = ref(gm,n,:f_short_pipes,idx)
    t_short_pipes    = ref(gm,n,:t_short_pipes,idx)
    f_valves         = ref(gm,n,:f_valves,idx)
    t_valves         = ref(gm,n,:t_valves,idx)
    f_control_valves = ref(gm,n,:f_control_valves,idx)
    t_control_valves = ref(gm,n,:t_control_valves,idx)

    constraint_conserve_flow(gm, n, idx, f_pipes, t_pipes, f_compressors, t_compressors, f_resistors, t_resistors, f_short_pipes, t_short_pipes, f_valves, t_valves, f_control_valves, t_control_valves)


#    connections = ref(gm,n,:connection)
#    junction_connections = ref(gm,n,:junction_connections,idx)

#    first = nothing
#    last = nothing

#    for i in junction_connections
#        connection = connections[i]
#        other = (connection["f_junction"] == idx) ? connection["t_junction"] :  connection["f_junction"]

#        if first == nothing
#            first = other
#        elseif first != other
#            if last != nothing && last != other
#                error(LOGGER, string("Error: adding a degree 2 constraint to a node with degree > 2: Junction ", idx))
#            end
#            last = other
#        end
#    end

#    yp_first = filter(i -> connections[i]["f_junction"] == first, junction_connections)
#    yn_first = filter(i -> connections[i]["t_junction"] == first, junction_connections)
#    yp_last  = filter(i -> connections[i]["t_junction"] == last,  junction_connections)
#    yn_last  = filter(i -> connections[i]["f_junction"] == last,  junction_connections)

#    constraint_conserve_flow(gm, n, idx, yp_first, yn_first, yp_last, yn_last)
end
constraint_conserve_flow(gm::GenericGasModel, i::Int) = constraint_conserve_flow(gm, gm.cnw, i)

" Template: Constraints to ensure that flow is the same direction through a node with degree 2 and no production or consumption "
function constraint_conserve_flow_ne(gm::GenericGasModel{T}, n::Int, idx) where T <: AbstractMIForms
#    f_pipes          = ref(gm,n,:f_pipes,idx)
#    t_pipes          = ref(gm,n,:t_pipes,idx)
#    f_compressors    = ref(gm,n,:f_compressors,idx)
#    t_compressors    = ref(gm,n,:t_compressors,idx)
#    f_resistors      = ref(gm,n,:f_resistors,idx)
#    t_resistors      = ref(gm,n,:t_resistors,idx)
#    f_short_pipes    = ref(gm,n,:f_short_pipes,idx)
#    t_short_pipes    = ref(gm,n,:t_short_pipes,idx)
#    f_valves         = ref(gm,n,:f_valves,idx)
#    t_valves         = ref(gm,n,:t_valves,idx)
#    f_control_valves = ref(gm,n,:f_control_valves,idx)
#    t_control_valves = ref(gm,n,:t_control_valves,idx)
#    f_ne_pipes       = ref(gm,n,:f_ne_pipes,idx)
#    t_ne_pipes       = ref(gm,n,:t_ne_pipes,idx)
#    f_ne_compressors = ref(gm,n,:f_ne_compressors,idx)
#    t_ne_compressors = ref(gm,n,:t_ne_compressors,idx)

#    constraint_conserve_flow_ne(gm, n, idx, f_pipes, t_pipes, f_compressors, t_compressors, f_resistors,
#                                    t_resistors, f_short_pipes, t_short_pipes, f_valves, t_valves, f_control_valves,
#                                    t_control_valves, f_ne_pipes, t_ne_pipes, f_ne_compressors, t_ne_compressors)


    connections = ref(gm,n,:connection)
    ne_connections = ref(gm,n,:ne_connection)
    junction_connections = ref(gm,n,:junction_connections,idx)
    junction_ne_connections = ref(gm,n,:junction_ne_connections,idx)

    first = nothing
    last = nothing

    for i in junction_connections
        connection = connections[i]
        other = (connection["f_junction"] == idx) ?  connection["t_junction"] : connection["f_junction"]

        if first == nothing
            first = other
        elseif first != other
            if last != nothing && last != other
                error(LOGGER, string("Error: adding a degree 2 constraint to a node with degree > 2: Junction ", idx))
            end
            last = other
        end
    end

    for i in junction_ne_connections
        connection = ne_connections[i]
        other = (connection["f_junction"] == idx) ? connection["t_junction"] : connection["f_junction"]

        if first == nothing
            first = other
        elseif first != other
            if last != nothing && last != other
                error(LOGGER, string("Error: adding a degree 2 constraint to a node with degree > 2: Junction ", idx))
            end
            last = other
        end
    end

    yp_first = [
        filter(i -> connections[i]["f_junction"] == first, junction_connections);
        filter(i -> ne_connections[i]["f_junction"] == first, junction_ne_connections)
    ]
    yn_first = [
        filter(i -> connections[i]["t_junction"] == first, junction_connections);
        filter(i -> ne_connections[i]["t_junction"] == first, junction_ne_connections)
    ]
    yp_last = [
        filter(i -> connections[i]["t_junction"] == last, junction_connections);
        filter(i -> ne_connections[i]["t_junction"] == last, junction_ne_connections)
    ]
    yn_last = [
        filter(i -> connections[i]["f_junction"] == last, junction_connections);
        filter(i -> ne_connections[i]["f_junction"] == last, junction_ne_connections)
    ]

    constraint_conserve_flow_ne(gm, n, idx, yp_first, yn_first, yp_last, yn_last)
end
constraint_conserve_flow_ne(gm::GenericGasModel, i::Int) = constraint_conserve_flow_ne(gm, gm.cnw, i)

" Template: Constraints which ensure that parallel lines have flow in the same direction "
function constraint_parallel_flow(gm::GenericGasModel{T}, n::Int, idx) where T <: AbstractMIForms
    connection = ref(gm,n,:connection,idx)
    connections = ref(gm,n,:connection)

    i = min(connection["f_junction"], connection["t_junction"])
    j = max(connection["f_junction"], connection["t_junction"])

    parallel_connections = ref(gm,n,:parallel_connections,(i,j))

    f_connections = filter(i -> connections[i]["f_junction"] == connection["f_junction"], parallel_connections)
    t_connections = filter(i -> connections[i]["f_junction"] != connection["f_junction"], parallel_connections)

    if length(parallel_connections) <= 1
        return nothing
    end

    constraint_parallel_flow(gm, n, idx, i, j, f_connections, t_connections)
end
constraint_parallel_flow(gm::GenericGasModel, i::Int) = constraint_parallel_flow(gm, gm.cnw, i)

" Template: Constraints which ensure that parallel lines have flow in the same direction "
function constraint_parallel_flow_ne(gm::GenericGasModel{T}, n::Int, idx) where T <: AbstractMIForms
    connection = haskey(ref(gm,n,:connection), idx) ? ref(gm,n,:connection)[idx] : ref(gm,n,:ne_connection)[idx]
    connections = ref(gm,n,:connection)
    ne_connections = ref(gm,n,:ne_connection)

    i = min(connection["f_junction"], connection["t_junction"])
    j = max(connection["f_junction"], connection["t_junction"])

    all_parallel_connections = ref(gm,n,:parallel_ne_connections, (i,j))
    parallel_connections = ref(gm,n,:parallel_connections, (i,j))

    if length(all_parallel_connections) <= 1
        return nothing
    end

    f_connections = filter(i -> connections[i]["f_junction"] == connection["f_junction"], intersect(all_parallel_connections, parallel_connections))
    t_connections = filter(i -> connections[i]["f_junction"] != connection["f_junction"], intersect(all_parallel_connections, parallel_connections))
    f_connections_ne = filter(i -> ne_connections[i]["f_junction"] == connection["f_junction"], setdiff(all_parallel_connections, parallel_connections))
    t_connections_ne = filter(i -> ne_connections[i]["f_junction"] != connection["f_junction"], setdiff(all_parallel_connections, parallel_connections))

    constraint_parallel_flow_ne(gm, n, idx, i, j, f_connections, t_connections, f_connections_ne, t_connections_ne)
end
constraint_parallel_flow_ne(gm::GenericGasModel, i::Int) = constraint_parallel_flow_ne(gm, gm.cnw, i)
