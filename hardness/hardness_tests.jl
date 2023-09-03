[
function check_input_sf(X, glassware; balanceType = nothing, debouce = 1)
	sleep(debouce)
	bur = false
	try
		if glassware == "balance" && balanceType == "A"
			sig = 6
		elseif glassware == "burette"  
			sig = -99
			bd = split.(string.(X), ".")
			nodecimals = ones(size(bd)[1])
			for i in 1:size(bd)[1]
				nodecimals[i] = length(bd[i][2])
			end
			if any(nodecimals .!= 2)
				bur = true
					else
				bur = false
			end
		elseif glassware == "balance" && balanceType == "B"
			sig = 5
		elseif glassware == "beaker"
			sig = 3
		elseif glassware == "cylinder"
			sig = 4
		elseif glassware == "volumetric pipette"
			sig = 4
		else 
			"Unrecognized glassware"
		end
	
		if any(X .!= 0) && any(length.(string.(X)) .!= sig+1) && bur != false
			Markdown.MD(Markdown.Admonition("warning", "Check your sig figs!", [md"Remember to record all known digits plus one uncertain digit for all measurements! $(bur)"]))
		end
	
	catch e
		println(e)
	end
end
]
