#!/usr/bin/julia
using Distributed

workervec = [("montecarlo@worker_1:22",1),]
#("sshuser@worker_2:22",1),("sshuser@worker_3:22",1),("sshuser@worker_4:22",1)]

addprocs(workervec; tunnel=true,exename=`/usr/local/julia/bin/julia`,dir=`/home/montecarlo/workdir/MonteCarlo`)

# are we all on the same dir?
@everywhere cd("/home/montecarlo/workdir/Montecarlo")
@everywhere println(pwd())

#@everywhere rm("/home/montecarlo/.julia"; recursive=true)
@everywhere begin
    using Pkg
    Pkg.update()
    Pkg.activate(".")
    Pkg.add("PyCall")
    Pkg.build("PyCall")
end
@everywhere using Distributed
@everywhere using PyCall
@everywhere socket = pyimport("socket")

println(workers())

@everywhere function printHello(data)
    println("Hi from node ",myid())
    print("my hostname is: ",socket.gethostname())
    println(" and the data is ", data)
end

printHello(2)

x = [@spawnat i printHello(i*10) for i in workers() ]

@spawnat 2 printHello(10)