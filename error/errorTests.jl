[
function check_input_sf(X, glassware; balanceType = nothing, debouce = 2)
	try
		sleep(debouce)
		if glassware == "balance" && balanceType == "A"
			sig = 6
		elseif glassware == "balance" && balanceType == "choose one..."
			Markdown.MD(Markdown.Admonition("danger", "Choose the correct balance!", [md"There are several types of balances in use.  Yours should be marked with an A or B.  Make sure to choose the correct one from the dropdown."]))	
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
	
		if any(.!(ismissing.(X))) && all(length.(string.(X)) .!= sig+1)
		Markdown.MD(Markdown.Admonition("danger", "Heads Up!", [md"Remember to record all known digits plus one uncertain digit for all measurements!"]))
		end
	
	catch
			"Error"
	end
end

function check_answer_errorLab(X, μ, sig, param; debounce = 2)
	try
		sleep(debounce)
		ans = parse(Float64, X)
		sig = Int(log10(sig))
		if ans == round(μ, sigdigits = sig) && X != "0.00"
			Markdown.MD(Markdown.Admonition("correct", "Got it!", [md"That is the correct $(param)!"]));
		elseif round(ans, sigdigits = sig) == round(μ, sigdigits = sig) && X != "0.00"
			Markdown.MD(Markdown.Admonition("hint", "Hint", [md"Check the number of significant digits. Remember to always report all known digits plus one uncertain digit."]));
		else
			Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [md"Your $(param) isn't correct."]))
		end
	catch
		Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [md"Your $(param) isn't correct."]))
	end	
end
]
