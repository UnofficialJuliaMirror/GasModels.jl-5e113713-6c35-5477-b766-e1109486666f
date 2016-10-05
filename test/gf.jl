# Check the full nonlinear model
@testset "test minlp gf" begin
    if minlp_solver != couenne_solver
        @testset "gaslib 40 case" begin
            result = run_gf("../test/data/gaslib-40.json", MINLPGasModel, minlp_solver)        
            println(result["status"])            
            @test result["status"] == :LocalOptimal || result["status"] == :Optimal
            @test isapprox(result["objective"], 0; atol = 1e-6)
        end
        @testset "gaslib 135 case" begin
            result = run_gf("../test/data/gaslib-135.json", MINLPGasModel, minlp_solver)        
            @test result["status"] == :LocalOptimal || result["status"] == :Optimal
            @test isapprox(result["objective"], 0; atol = 1e-6)
        end    
    end  
end


#Check the second order code model
@testset "test misocp gf" begin
    @testset "gaslib 40 case" begin
        result = run_gf("../test/data/gaslib-40.json", MISOCPGasModel, misocp_solver)
        @test result["status"] == :LocalOptimal || result["status"] == :Optimal
        @test isapprox(result["objective"], 0; atol = 1e-6)
    end      
        @testset "gaslib 135 case" begin
            result = run_gf("../test/data/gaslib-135.json", MISOCPGasModel, misocp_solver)
            @test result["status"] == :LocalOptimal || result["status"] == :Optimal
            @test isapprox(result["objective"], 0; atol = 1e-6)
        end
    if misocp_solver != pajarito_solver               
        @testset "gaslib 582 case" begin
            result = run_gf("../test/data/gaslib-582.json", MISOCPGasModel, misocp_solver)
            @test result["status"] == :LocalOptimal || result["status"] == :Optimal
            @test isapprox(result["objective"], 0; atol = 1e-6)
        end
    end    
end



