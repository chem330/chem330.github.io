# This file was generated, do not modify it. # hide
using Plots # hide
scatter(0.5:1:5, [1, 3, 5, 7, 9] .+ rand(-0.2:0.1:0.2, 5), # hide
	legend = false, # hide
	markersize = 8, # hide
	border = :box, grid = false, # hide
	xtickfontsize=14, ytickfontsize=14, xguidefontsize=14, yguidefontsize=14 # hide
	) # hide
xlabel!("Concentration"); ylabel!("Signal") # hide
xlims!(0, 6); ylims!(0, 10) # hide
Plots.abline!(2, 0, color = 1, linewidth = 3, linestyle= :dash) # hide
savefig(joinpath(@OUTPUT, "phosphate-cal.svg")) # hide