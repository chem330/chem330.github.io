[
function setstockconc()
	0.02
end
function check_input_sf(X, glassware; balanceType = nothing, debouce = 2)
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
function check_edta_conc(check_string, mass, volume)
	if check_string != "0.00"
		if isapprox(parse(Float64, check_string), (mass / volume) * (1/(292.2438 + 22.989769 + 22.989769)), atol = 0.00005)
			Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your calculation is correct!"]))
		else
			Markdown.MD(Markdown.Admonition("danger", "This doesn't seem right...", [md"Something's wrong with your calculation."]))
		end
	else
		Markdown.MD(Markdown.Admonition("hint", "Here's a hint...", [md"Calculate the estimated EDTA concentration using the mass of EDTA your weighed out on the balance and the volume of the flask you put it in.  You will also need the molar mass of disodium EDTA (292.2438 g/mol) and sodium is 22.989769 g/mol."]))
	end
end
function check_ca_amount(check_string, stock_vol, stock_conc)
	if !ismissing(stock_vol) && check_string != "0.00"
		if isapprox(parse(Float64, check_string), stock_conc * stock_vol * 0.5, atol = 0.01)
			Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your calculation is correct!"]))
		else
			Markdown.MD(Markdown.Admonition("danger", "This doesn't seem right...", [md"Something's wrong with your calculation."]))
		end
	else
		Markdown.MD(Markdown.Admonition("hint", "Here's a hint...", [md"Calculate the amount of calcium present in the standard by converting from normality to molarity, and then from molarity to moles.  Remember that 1 mole of calcium ion is 2 equivalents."]))
	end
end
function check_edta_volume_needed(check_string, stock_conc, stock_vol, mass_edta, vol_edta_flask; atol = 0.005)
	if check_string != "0.00"
		if isapprox(parse(Float64, check_string), stock_conc * stock_vol * 0.5 * 1/((mass_edta / volume_edta_flask) * (1/(292.2438 + 22.989769 + 22.989769))), atol = atol) && check_string != "0.00"
			Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your calculation is correct.  You should be able to add almost this amount in one go.  When you get within 5 mL or so of the endpoint you will want to slow down!"]))
		elseif check_string == "0.00"
		else
			Markdown.MD(Markdown.Admonition("danger", "Something's not right...", [md"Your calculation is incorrect."]))
		end
	else
		Markdown.MD(Markdown.Admonition("hint", "Here's a hint...", [md"Calculate the required volume of EDTA needed.  Remember that for every mole of calcium ion present, one mole of EDTA is required.  Once you know this, you can use your estimated concentration of your EDTA to get an approximate volume requred."]))
	end
end
function check_edta_std_conc(check_string, stock_conc, stock_vol, starting_vols, endpts, blank_vol; atol = 0.00001)
	if check_string != "0.00"
		if isapprox(parse(Float64, check_string), mean((stock_conc * stock_vol * 0.5) ./ ((abs.(starting_vols .- endpts) .- parse(Float64, blank_vol)))), atol = 0.00001) && check_string != "0.00"
			Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your calculation is correct!"]))
		elseif check_string == "0.00"
		else
			Markdown.MD(Markdown.Admonition("danger", "Something's not right...", [md"Your calculation is incorrect."]))
		end
	else
		Markdown.MD(Markdown.Admonition("hint", "Here's a hint...", [md"Calculate the average concentration of the EDTA in molarity.  Remember that one mole of CaCO₃ is consumed for every mole of EDTA added, and that molarity has units of moles/L."]))
	end
end
function check_hardness(check_string, starting_vols, endpoints, blank_vol, stock_conc, stock_vol, water_vol)
	if check_string != "0.00"
		if isapprox(parse(Float64, check_string), mean((abs.(starting_volumes .- endpoints) .- parse(Float64, blank_vol)) .* (mean((inst_stock_conc * stock_volume * 0.5) ./ ((abs.(starting_volumes_std .- endpoints_std) .- parse(Float64, blank_vol)))) .* 1 ./ volume_water .* 100.09) .* 1000), atol = 0.1) && check_string != "0.00"
			Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your calculation is correct!"]))
		elseif check_string == "0.00"
		else
			Markdown.MD(Markdown.Admonition("danger", "Something's not right...", [md"Your hardness is incorrect."]))
		end
	else
	Markdown.MD(Markdown.Admonition("hint", "Here's a hint...", [md"Calculate the hardness of the sample.  Recall that one mole of 'hardness' is consumed for every mole of EDTA added.  You will also need the molar mass of CaCO₃, which is 100.09 g/mol."]))
	end
end						
]
