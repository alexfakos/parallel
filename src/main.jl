#instructions 
# addprocs(3)
# include("main.jl")
# main(2,3000); #to compile
# main(2000,3000);#to test performance
@everywhere using JuMP, NLopt
@everywhere include("mainpmap.jl")
function main(max :: Int, N :: Int)
    argin = [ (i,N) for i=1:max]
    result = Array(Any,max)
    #Serial solution of the  problem
    serial = time()
    for i =1:max
        result[i] = mainpmap(argin[i])
    end
    println("Duration of the serial problem: ", time() - serial)
    #parallelized  problem
    parall = time()
    @sync begin
        presult = pmap( mainpmap, argin )
    end
    println("Duration of the parallelized problem: ", time() - parall)
    return result,presult
end
