"""
Loads a Grail json document and converts it into the GasModels data structure
"""
function parse_grail_file(network_file, time_series_file; time_point = 1)
    network_data = GasModels.parse_json(network_file)

    profile_data = GasModels.parse_json(time_series_file)
    assert(length(profile_data["time_points"]) >= time_point)

    g_nodes = Dict([(node["index"], node) for node in network_data["node"]])
    g_edges = Dict([(edge["index"], edge) for edge in network_data["edge"]])
    g_compressors = Dict([(compressor["index"], compressor) for compressor in network_data["compressor"]])

    #println(keys(g_nodes))
    #println(keys(g_edges))
    #println(keys(g_compressors))

    g_node_withdrawal = Dict{Int,Any}()
    for (i, withdrawal) in enumerate(profile_data["withdrawal"])
        # FOLLOW UP: is this node id or node index?
        junction_id = withdrawal["node_index"]
        withdrawal_value = withdrawal["withdrawal"][time_point]

        # FOLLOW UP: make sure this is the correct interperation
        if !haskey(g_node_withdrawal, junction_id)
            g_node_withdrawal[junction_id] = [withdrawal_value]
        else
            push!(g_node_withdrawal[junction_id], withdrawal_value)
        end
    end

    gm_junctions = Dict{String,Any}()
    gm_producers = Dict{String,Any}()
    gm_consumers = Dict{String,Any}()

    node_id_to_junction_id = Dict{Int,Int}()
    for (i, node) in g_nodes
        node_id_to_junction_id[node["index"]] = node["node"]

        gm_junction = Dict{String,Any}(
            "index" => node["node"],
            "pmax" => node["pmax"],
            "pmin" =>  node["pmin"],
            "latitude" => node["lat"],
            "longitude" => node["lon"],
            # other stuff from grail data format
            "qmax" => node["qmax"],
            "qmin" => node["qmin"],
            "isslack" => node["isslack"]
        )

        junction_index = "$(gm_junction["index"])"
        assert(!haskey(gm_junctions, junction_index))
        gm_junctions[junction_index] = gm_junction
    end

    println(length(gm_junctions))

    gm_connections = Dict{String,Any}()
    for (i, edge) in g_edges
        assert(edge["fr_node"] == node_id_to_junction_id[edge["f_id"]])
        assert(edge["to_node"] == node_id_to_junction_id[edge["t_id"]])

        gm_connection = Dict{String,Any}(
            "index" => edge["index"],
            "f_junction" => edge["fr_node"],
            "t_junction" =>  edge["to_node"],
            "length" => edge["length"],
            "diameter" => edge["diameter"],
            "resistance" => edge["friction_factor"],
            "type" => "pipe"
        )

        connection_index = "$(gm_connection["index"])"
        assert(!haskey(gm_connections, connection_index))
        gm_connections[connection_index] = gm_connection
    end

    println(length(gm_connections))


    max_junction_id = maximum([junction["index"] for (i,junction) in gm_junctions])
    junction_id_offset = trunc(Int, 10^ceil(log10(max_junction_id)))
    #println(max_junction_id)
    #println(junction_id_offset)

    compressor_offset = maximum(connection["index"] for (i,connection) in gm_connections)
    compressor_count = 1
    for (i, compressor) in g_compressors
        assert(compressor["node"] == node_id_to_junction_id[compressor["node_id"]])

        # prepare a new junction for the pipe-connecting compressor
        fr_junction = gm_junctions["$(compressor["node"])"]
        to_junction_index = junction_id_offset + fr_junction["index"]

        gm_junction = Dict{String,Any}(
            "index" => to_junction_index,
            "pmax" => fr_junction["pmax"],
            "pmin" =>  fr_junction["pmin"],
            "latitude" => fr_junction["latitude"],
            "longitude" => fr_junction["longitude"],
        )

        junction_index = "$(gm_junction["index"])"
        assert(!haskey(gm_junctions, junction_index))
        gm_junctions[junction_index] = gm_junction

        # update pipe to point to new junction
        pipe = gm_connections["$(compressor["edge_id"])"]
        assert(pipe["type"] == "pipe")
        assert(pipe["t_junction"] == compressor["node"] || pipe["f_junction"] == compressor["node"])
        
        # FOLLOW UP: this could be an indication of a compressor orientation issue
        if pipe["f_junction"] == compressor["node"]
            pipe["f_junction"] = to_junction_index
        else
            pipe["t_junction"] = to_junction_index
        end

        compressor_index = compressor_offset + compressor_count
        gm_connection = Dict{String,Any}(
            "index" => compressor_index,
            "f_junction" => compressor["node"],
            "t_junction" => to_junction_index,
            "c_ratio_max" => compressor["cmax"],
            "c_ratio_min" => compressor["cmin"],
            "type" => "compressor",
            # other stuff from grail data format
            "hpmax" => compressor["hpmax"]
        )

        connection_index = "$(gm_connection["index"])"
        assert(!haskey(gm_connections, connection_index))
        gm_connections[connection_index] = gm_connection

        compressor_count += 1
    end

    gm_network = Dict{String,Any}(
        "name" => split(network_file,'.')[1],
        "multinetwork" => false,
        "junction" => gm_junctions,
        "producer" => gm_producers,
        "consumer" => gm_consumers,
        "connection" => gm_connections
    )

    return gm_network
end

