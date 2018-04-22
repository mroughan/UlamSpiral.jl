using UlamSpiral
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end
 
# write your own tests here
@testset "position function" begin
    @test UlamSpiral.position(1) == (0,0)
    @test UlamSpiral.position(10,10) == (0,0)
    @test UlamSpiral.position(10) == (2, -1)
    
    @test_throws DomainError UlamSpiral.position(0)
    @test_throws DomainError UlamSpiral.position(9, 10)
end

# 
# a present these tests are a bit trivial, because most of this
# is about plotting. Perhaps can use
#     https://github.com/JuliaPlots/VisualRegressionTests.jl
# to do this, but perhaps is overkill for a niche package like this.
#
