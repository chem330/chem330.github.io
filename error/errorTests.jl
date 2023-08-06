function check_input_sf(X, glassware; debouce = 2)
	try
		sleep(debouce)
		if glassware == "beaker"
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
