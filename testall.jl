using Pkg

packagelist = [
"FinEtools", 
"FinEtoolsAcoustics", 
"FinEtoolsHeatDiff", 
"FinEtoolsDeforLinear", 
"FinEtoolsMeshing", 
"FinEtoolsVoxelMesher", 
"FinEtoolsDeforNonlinear"
]
testfolder = "./tests"

if basename(pwd()) != "FinEtoolsTestAll.jl"
	@error "Need to be in FinEtoolsTestAll.jl"
end

rm(testfolder, force=true, recursive=true)
mkpath(testfolder)
cd(testfolder)
run(`"pwd"`)

for p in packagelist
	run(`git clone https://github.com/PetrKryslUCSD/$(p).jl.git`)
	cd("$(p).jl")
	run(`"pwd"`)
	Pkg.activate(".")      
	Pkg.instantiate()                              
	try
		Pkg.test()
	catch
		@error "Some tests failed?"
	end
	cd("..")
end

cd("..")
