[
function setstockconcs()
  	nitrate_stock = 118.4 # mg/L
	qc = 7.696 # mg/L
  	return (n = nitrate_stock, qc = qc)
end
  
function check_dilutions(X, stock, vf, pip; species, a = 0.00001)
  if all(.!ismissing.(vf)) && all(.!ismissing.(pip)) && all(.!ismissing.(X))
    if all(isapprox.(X, stock .* pip ./ vf, atol = a)) || all(isapprox.(reverse(X), stock .* pip ./ vf, atol = a)) 
      Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your $(species) standard concentrations appear to be correct!"]))
    else
      Markdown.MD(Markdown.Admonition("danger", "This doesn't seem right...", [md"One or more of your $(species) standard concentrations is incorrect."]))
    end
  end
end

struct calPlot
	concentrations::Vector{Float64}
	signal::Vector{Float64}
	slope::Float64
	intercept::Float64
end

@recipe function f(r::calPlot)
	border --> :box
	grid --> false
	xlims --> (0, ceil(r.concentrations[end]*1.1))
	ylims --> (0, ceil(r.signal[end]*1.05, digits = 1))
	xminorticks --> true
	yminorticks --> true
	legend --> false
	color --> 1
	seriestype := :scatter
    # add a series line of best fit
    @series begin
        seriestype := :path
        primary := false
		color --> 1
        # return series data
        -1:0.1:(r.concentrations[end] * 1.5), r.slope .* (-1:0.1:(r.concentrations[end] * 1.5)) .+ r.intercept
    end
    # return data
    r.concentrations, r.signal
end

function check_conc(x, m, b) 
	(x - b) / m
end

function check_nitrate_n(no3)
	(no3/62) * (14)
end
]
