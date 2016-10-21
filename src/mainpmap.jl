function mainpmap(argin)
    seed = argin[1]
    N    = argin[2]
    srand(seed)
    b=[2; 3]
    Z=[ones(N) randn(N)]
    y=Z*b+randn(N)
    m = Model( solver=NLoptSolver(algorithm=:LD_SLSQP))
    @variable(m, x[ i = 1 : size(Z)[2] ]  )
    @NLobjective(m, Min, sum{(y[i]- sum{ Z[i,j]*x[j], j=1:size(Z)[2]})^2, i=1:size(Z)[1]})
    solve(m)
    #println("beta= ",getvalue(x))
    #println("objective= ",getobjectivevalue(m))
    return getvalue(x), getobjectivevalue(m)
end
