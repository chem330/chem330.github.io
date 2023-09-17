### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 533ca516-499e-11ee-3788-a54f32761e35
using PlutoUI, Plots, Statistics

# ╔═╡ dfab82be-e30e-4566-99ce-dee5e06fb69c
# Do not edit this cell!!!
begin
	using HTTP
	r = HTTP.request("GET", "https://raw.githubusercontent.com/chem330/chem330.github.io/main/hardness/hardness_tests.jl")
	eval(Meta.parse(String(r.body)))
	inst_stock_conc=setstockconc()
end;

# ╔═╡ 0dcb97bb-75de-40c8-92b4-085039b3c808
md"""
# Introduction
"""

# ╔═╡ ab44ebff-922a-4140-9dc1-36d6ab56cde5
md"""

*This lab is based on EPA method [130.2](https://www.nemi.gov/methods/method_summary/4684/) [Hardness, Total (mg/L as CaCO ) (Titrimetric,3
EDTA)]*

The goal of this lab is to determine the **hardness** of a water sample.  Hardness is not a measure of a specific species, but rather a combination of species.  Typically, hardness is considered to be made up of $\ce{Mg^2+}$ and $\ce{Ca^2+}$.

In this exercise, you will determine the hardness of a water sample by **colorimetric, complexometric titration** with a compound called EDTA.  This is a *complexometric* titration because EDTA is an organic molecule that binds calcium and magnesium ions in water to form a metal-organic "complex".  It is a *colorimetric* titration because we use an indicator dye to observe the **endpoint** of the titration (in this case we use commercial Calmagite, but eriochrome black can also be used); in this case, the solution will turn from purple to blue when all the magnesium and calcium ions have been bound to EDTA.

EDTA binds $\ce{Ca^2+}$ and $\ce{Mg^2+}$ according to the follwing reaction, in which $\ce{Y}$ represents EDTA and $\ce{M^2+}$ represents either calcium or magnesium ion:

$$\ce{M^{2+} + H2Y^{2-} <=> MY^{2-} + 2H^+}$$

Importantly, inspection of these reaction reveals that EDTA reacts in a 1:1 molar ratio with both ions considered to contribute to "hardness".

When the endpoint of the tiration is reached, EDTA and "hardness" exist in equal molar concentrations.  The endpoint is observed through the indicator, which changes color when bound to magnesium or calcium. When any calcium or magnesium is in solution it will bind to the indicator, causing it to appear blue.  But since EDTA binds those ions more strongly, it will remove them from the indicator as it's added to solution.  Once all the magnesium and calcium ions have been removed from the indicator it turns from blue to purple and eventually pink.  The endpoint occurs right as the solution turns from blue to a purple color, and this is the point that you should record in your notebook.  It is very easy to overshoot the endpoint, in which case the titration will have to be repeated.  You can adjust the slider below to observe a simulation of what the solution will look like as you progress through the titration.
"""

# ╔═╡ 8b4c0ed9-c4d8-4dd4-8468-3ef5f46f2d1e
md" **Amount of Titrant (EDTA) Added:** $(@bind titrant_added_demo Slider(0:0.01:0.8, default = 0))"

# ╔═╡ b619a54e-9b92-4978-b9dd-585b309ebeb9
md"$(round(titrant_added_demo*20, sigdigits = 3)) mL"

# ╔═╡ 1b058e01-742c-4146-a062-25092cb34f5f
begin
	p = plot(yaxis = false, xaxis = false, grid = false, legend = false)
	xlims!(0, 3); ylims!(-0.1, 3)
	
	plot!([1.25, 1.75, 1.75, 1.25], [0, 0, 0.8, 0.8], color = "#1F7FE0", fill = 0, fillalpha = 0.4, linewidth = 0)
	if titrant_added_demo >= 0.3
		plot!([1.25, 1.75, 1.75, 1.25], [0, 0, 0.8, 0.8], color = "#FC38A4", fill = 0, fillalpha = titrant_added_demo+0.075, linewidth = 0)
	end
	plot!([1.25, 1.25, 1.75, 1.75], [1, 0, 0, 1], color = :black, linewidth = 8)

	plot!([1, 1.1].+0.45, [1-titrant_added_demo, 1-titrant_added_demo].+1.5, color = :grey50, fill = -0.1 + 1.5, fillalpha = 0.5, linewidth = 0)
	plot!([1, 1, 1.05, 1.1, 1.1].+0.45, [1, 0, -0.1, 0, 1].+1.5, fill = 1, fillcolor = :white, color = :black, linewidth = 2)

	if titrant_added_demo < 0.3
		annotate!(1.9, 0.5, text("[EDTA] < [Mg²⁺] + [Ca²⁺]", 10, :left, color = "#1F7FE0"))
		annotate!(1.9, 0.25, text("Mg²⁺ and Ca²⁺ bound to \n indicator", 10, :left, color = "#1F7FE0"))
	elseif titrant_added_demo >= 0.3 && titrant_added_demo < 0.32
		annotate!(1.9, 0.5, text("[EDTA] = [Mg²⁺] + [Ca²⁺]", 10, :left, color = "#C792D5"))
	else
		annotate!(1.9, 0.5, text("[EDTA] > [Mg²⁺] + [Ca²⁺]", 10, :left, color = "#FC38A4"))
		annotate!(1.9, 0.25, text("Indicator free - too far!", 10, :left, color = "#FC38A4"))
	end
	annotate!(1.4, 2, text("Burette with \n EDTA Titrant", 8, :right, color = :grey60))
	annotate!(1.15, 0.5, text("Beaker with \n Titrand", 8, :right, color = :grey60))
end

# ╔═╡ ad68e314-7fad-4705-bd09-0ddd82678375
md"""
# Sample Preparation
"""

# ╔═╡ 24b500a2-52c2-4d3b-a286-6d660ee3216a
md"""
## Samples
"""

# ╔═╡ 9d718310-2556-45d2-a57b-a221a360dbbc
md"""
Enter your sample info, sample collection info, and sample prep steps here.


"""

# ╔═╡ 80749d9c-a8cf-4a00-94bc-ce6c7af38be5
md"""
## Titrant

"""

# ╔═╡ 7ba1fcdf-f376-485d-8b01-0432284735fe
md"""
Enter information about how you prepared the titrant here.


"""

# ╔═╡ f7dacd8f-7cd8-47e8-8fb1-835028bb908f
md"**Enter the mass of EDTA used in the cell below, in grams. Do not change name name of the variable (it should be `mass_edta`).**"

# ╔═╡ 41884798-2e11-4aa1-a875-34c5c421ab10
mass_edta = missing # g

# ╔═╡ 2f2f7f4c-99b3-4a49-ba0a-4de1eab58d44
md"**Enter the volume of the flask used to make the EDTA in the cell below, in liters. Do not change name name of the variable (it should be `volume_edta_flask`).**"

# ╔═╡ 4ef09457-6657-427e-a158-56c0954f2ceb
volume_edta_flask = missing # L

# ╔═╡ df38b3cf-699a-40c9-93dc-5524f868dc69
md"**Calculate the concentration of EDTA in the cell below.  Specify your result in moles per liter (M).**"

# ╔═╡ edf3278e-dba3-456d-8299-b88967a3768a


# ╔═╡ cabd8bf6-fe92-454f-9b86-18e35a2133e3
md"""
**Estimated EDTA Concentration:** $(@bind edta_conc_mass TextField(default = "0.00")) M
"""

# ╔═╡ a12b6946-4636-4c1b-95e9-d119b233f1b2
check_edta_conc(edta_conc_mass, mass_edta, volume_edta_flask)

# ╔═╡ 63817177-79c7-464f-b078-d9429dab2ef6
md"""
# Blank Determination
"""

# ╔═╡ 4cd476c7-9dae-4b6a-8e11-e1a8c073faf1
blank_volumes = [ missing, missing, missing ]

# ╔═╡ 65a16182-b3ec-4a7c-89d8-1864ae6b0a16
md"""
Calculate the average blank volume in the cell below.  Remember there is a `mean()` function that can do this calculation.

You may want to save the result to a variable.  For example, if you write `b_vol = mean(blank_volumes)` it would store the mean as the variable `b_vol`.  Then, you could use that in calculations, such as `1-b_vol`, for example.  Julia will substitute `b_vol` for the value you have stored in it.
"""

# ╔═╡ 962e28a4-4c4b-4d95-bad6-4c0227e68c18


# ╔═╡ d9cb80cb-ad76-4a59-b292-1be91c6b4969
md"**Enter the average blank volume in the box below.**"

# ╔═╡ 011cec10-281f-423d-92c2-02edbf5604a7
md"""
**Average Blank Volume:** $(@bind blank_vol TextField(default = "0.00")) mL
"""

# ╔═╡ de80157a-94bb-45dd-97d2-d6832439a0e4
check_input_sf([parse(Float64, blank_vol)], "burette")

# ╔═╡ d875d4fa-69d2-414e-9b66-eb8fcb3e5a6e
md"""

# EDTA Standardization

"""

# ╔═╡ 28aea002-c733-46b8-b13f-1b95b84b628f
md"""
### Endpoint Estimation - Calculation
"""

# ╔═╡ 5fc1bd79-33e4-4cb1-9836-7f497ecb1c39
md"**Enter the normality of the stock solution in the cell below.   Do not change the name of the variable (it should be `stock_concentration`).**"

# ╔═╡ 3c5782dd-c136-4577-a620-550ce5dede64
stock_concentration = missing

# ╔═╡ 17b7f094-22c6-4beb-b127-3b8fe8b3f849
md"**Enter the volume of the stock solution used the in cell below in milliliters. Do not change the name of the variable (it should be `stock_volume`).**"

# ╔═╡ de6ff0fb-e93c-4e04-bf7a-41363f085287
stock_volume = missing

# ╔═╡ 66718893-3f53-46e2-8dd7-166830ff8daa
md"""

Now, use the amount of EDTA added to estimate how much CaCO3 you will need to reach the endpoint.

"""

# ╔═╡ df08032a-f18d-4035-a20b-e23db0a3bb68
md"To do this, **calculate the amount (moles) of $\ce{Ca^2+}$ in your primary standard in the cell below. Give your answer in millimoles (mmol).**"

# ╔═╡ 3149d270-6a25-4cca-9b3a-9bdb7c5fbd70


# ╔═╡ 0ff1f065-d550-45d7-bd93-1fd146dd2d37
md"""
**Ca²⁺ Amount:** $(@bind ca_amnt TextField(default = "0.00")) mmoles
"""

# ╔═╡ 60037b11-934f-419d-adac-697246ae88a6
check_ca_amount(ca_amnt, stock_volume, inst_stock_conc)

# ╔═╡ dfa67404-191b-41d3-a94a-3e3472fbe74c
md"**Now calculate how many mL of EDTA are required to react with this amount of $\ce{Ca^2+}$**"

# ╔═╡ f01d1468-6828-4bbb-b43c-2353ce35d03c


# ╔═╡ 70b0ec84-b832-4c6a-b587-25858d533674
md"""
**Required Volume of EDTA:** $(@bind edta_vol_needed_std TextField(default = "0.00")) mL
"""

# ╔═╡ 8f6ee904-9efb-4add-83bc-d71c43b279a3
check_edta_volume_needed(edta_vol_needed_std, inst_stock_conc, stock_volume, mass_edta, volume_edta_flask)

# ╔═╡ 4f80fc16-78bd-4c20-8745-9e568948f296
md"""
### Standardization

**Enter the starting volume and endpoint for your three replicates in the arrays below.**
"""

# ╔═╡ 90e412f2-8472-4f93-a0c4-643e3a7267f9
starting_volumes_std = [ missing, missing, missing ] # ml

# ╔═╡ 7e628816-2fa3-40b8-aea5-6ed504914984
endpoints_std = [missing, missing, missing] # ml

# ╔═╡ 0721ebf7-89ee-4765-be84-cf001854dffd
if all(.!ismissing.(starting_volumes_std))
	check_input_sf(starting_volumes_std, "burette") 
end

# ╔═╡ 679d496c-6f5c-4322-b6ad-f2d0c366751e
if all(.!ismissing.(endpoints_std))
	check_input_sf(endpoints_std, "burette") 
end

# ╔═╡ c6e57815-f65e-47c8-b8fb-a067755d66a1
md"""
### EDTA Concentration - Average

**Calculate the average EDTA concentration below.  You may add additional cells if needed.  Enter you final answer in the input box below, in mmol/L.**
"""

# ╔═╡ af07da1e-b9e7-440e-8afb-24ea0b6f037d


# ╔═╡ b1af2cd8-b41a-4f5f-a1ef-28dd38563fd9
md"""
**EDTA Concentration:** $(@bind edta_standard_conc TextField(default = "0.00")) M

"""

# ╔═╡ 42af4aed-4f7e-4052-ac7c-857e966c7c87
check_edta_std_conc(edta_standard_conc, inst_stock_conc, stock_volume,  starting_volumes_std, endpoints_std, blank_vol)

# ╔═╡ d76fd365-5655-4314-9873-409c3c65be8d
md"""

# Drinking Water Titration

"""

# ╔═╡ 793e2b55-5b2b-4ee5-a19f-0b278d84db24
md"""
## Endpoint Estimation - Quick Titration
"""

# ╔═╡ f928c7d7-4191-4169-8e64-cdda8bb643a2
md"""
It can save a lot of time to do a quick initial titration to estimate the endpoint.  To do this, add 1-2 mL at a time and record the volume at which the solution changes color.  **This step should take no more than 2-3 minutes!**
"""

# ╔═╡ 4578ddb1-4d6c-462d-a801-0fb4bd602f8d
md"""
**Titrant Starting Volume:** $(@bind edta_start_q TextField(default = "0.00")) mL

**Endpoint Volume:** $(@bind endpoint_q TextField(default = "0.00")) mL
"""

# ╔═╡ ed85ac6b-d1a2-4688-8ac4-3293f1dd1cb2
begin
	diff_q = abs(parse(Float64, endpoint_q) - parse(Float64, edta_start_q))
	if diff_q > 3 && diff_q < 20
		Markdown.MD(Markdown.Admonition("correct", "Seems about right!", [md"Your volumes seem to be in the right ballpark -- you can subtract these values to figure out how much titrant you will need to add for your final titrations and speed up your work.  In other words, when you are doing your final titrations you should be able roughly $(floor(diff_q) - 2) mL in one go.  Then you need to slow down and add only ~0.1 mL at a time to read the endpoint accurately."]))
	elseif diff_q == 0
	
	else
		Markdown.MD(Markdown.Admonition("warning", "Something seems unusual...", [md"Your volumes seem either very low or very high.  You may need to dilute your sample less or more to get the best precision."]))
	end
end

# ╔═╡ 2e1d8757-faba-479c-8687-3fd0f7ef8344
md"""
## Final Titrations
"""

# ╔═╡ 529ecdc2-f822-47d6-a8ab-337619346cab
md"### Sample 1"

# ╔═╡ 62104a86-5675-4180-bcf6-9b68d6589372
water_volume = [ missing, missing, missing ]

# ╔═╡ 35221e1e-4373-4078-98ee-3fd3a6ddf911
starting_volumes = [ missing, missing, missing ]

# ╔═╡ c36311fb-d01f-4a47-88fc-ab3b4cf1d8b9
endpoints = [ missing, missing, missing ]

# ╔═╡ 47ad7d8f-b590-433d-98c9-72c243cb8214
if all(.!ismissing.(starting_volumes))
	check_input_sf(starting_volumes, "burette") 
end

# ╔═╡ 40bc05c0-5622-4149-943c-6c5739fff534
if all(.!ismissing.(endpoints))
	check_input_sf(endpoints, "burette") 
end

# ╔═╡ 9bbda8a8-7ed3-407a-aebc-ae4d2d21e6d1
md"### Sample 2"

# ╔═╡ dfc14892-f48e-44f1-bc66-c1f60b5d2ebe
water_volume_s2 = [ missing, missing, missing ]

# ╔═╡ d215bbbe-8bc2-44c0-85d9-cfe4383061cd
starting_volumes_s2 = [ missing, missing, missing ]

# ╔═╡ 7c57df57-4595-4937-ae0e-7db2d8312897
endpoints_s2 = [ missing, missing, missing ]

# ╔═╡ d78edaf8-e526-47e4-b336-87762943daad


# ╔═╡ 0a3e5e4f-796d-4deb-a1ef-01af01bfff8c


# ╔═╡ 72b7176d-349d-4f1e-bbad-1d822ad0338a
md"## Water Hardness Result"

# ╔═╡ 664e0bcd-a9ce-4cda-9c4a-55336868a838
md"""
**Calculate the hardness of your water sample in the cell below.  Enter your result in the box below in mg/L CaCO₃.**
"""

# ╔═╡ 4025c24c-d134-4ac1-a1a7-02580f401b1b


# ╔═╡ 8be5bbc9-92e5-4398-86b7-ab4788633d28


# ╔═╡ db10e70f-3fe9-42b4-a886-171eedd05ecc
md"""
**Hardness of Sample 1:** $(@bind final_mean_hardness TextField(default = "0.00")) mg/L CaCO₃

"""

# ╔═╡ 2dbca923-7c36-4c3f-97f2-8f5ce034a537
md"""
**Hardness of Sample 2:** $(@bind final_mean_hardness_2 TextField(default = "0.00")) mg/L CaCO₃

"""

# ╔═╡ 10887f16-8060-400a-ab0b-4047d65517fa
check_hardness(final_mean_hardness, starting_volumes, endpoints, blank_vol, inst_stock_conc, stock_volume, water_volume)

# ╔═╡ 3f5a4b8b-f628-43bd-bd2a-b8ddf99e9a8a
md"""
**Add your results to the graph below as a barplot.  Include a y-error bar that represents the standard deviation of the sample.**

The command to add at bar to the plot is:

	bar!([s1_data, s2_data], color = "your_color", yerr = [s1_error, s2_error])

I suggest you also add the argument `label = false` to avoid adding an entry in the legend.

You can the color names in the [documentation for Colors.jl](http://juliagraphics.github.io/Colors.jl/stable/namedcolors/)!  (These are all built-in to Julia.)  Or, if you want additional colors, you can load the package [NamedColors.jl](https://github.com/JuliaGraphics/NamedColors.jl) and use many more colors, such as the [XKCD colors](https://xkcd.com/color/rgb/) or [Crayola colors](https://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors)! If you want to use NamedColors.jl, add `NamedColors` to the first cell at the top of the notebook where packages are loaded.

Once you've added your data, change the labels on the x-axis to reflect to collection locations of your samples.

"""

# ╔═╡ 1b856ce5-7e99-42b6-bc90-eb2f456a8324
md"""
**Y-axis Limit:** $(@bind yu Slider(0:10:500, default = 325))
**Draw Hardness Levels:** $(@bind drawlevels CheckBox(default = true))
"""

# ╔═╡ 5025a932-6296-41c2-a230-a8117b22da0c
md"""
# Conclusions

Write a 1-2 paragraph conclusion in the cell below.  Make sure to fully summarize your results, including any key numbers.  If possible, put your results into perspective by relating to other sources.  In particular, answer the following question(s):

1. Is your water hard or soft?  What are the broader implications of this finding?
1. EPA method 130.2 specifies a precision (as standard deviation) for this method of approximately 3 mg/L CaCO₃ for samples below 300 mg/L CaCO₃.  Did you achieve this precision?  Specify the exact value of your standard deviation in addition to saying whether or not it is close to the EPA values.

"""

# ╔═╡ de422319-fcbc-400b-aa17-9ac31d2afc39
md"""

"""

# ╔═╡ ca1f6c8c-f74f-4124-bb9b-1d5786b78bf5
PlutoUI.TableOfContents()

# ╔═╡ f7e2c6ea-1b8d-46e0-8f90-357c308f9848
begin
	# this cell sets up the plot for hardness
	# do not alter this cell!
	bp = plot(ylims=(0, yu), border = :box, grid = false, xticks = false, )
	ylabel!("Hardness (mg/L CaCO₃)")
	# plot!(twinx(), yminorticks = 0:20:500, ylims = (0, 500))

	if drawlevels
		hline!([1000], fill = 0, linewidth = 0, color = :navajowhite, label = "Very Hard")
		hline!([300], fill = 150, color = :antiquewhite, linedwidth = 0, label = "Hard")
		hline!([150], fill = 5, color = :ivory1, linedwidth = 0, label = "Moderately Hard")
		hline!([50], fill = 0, color = :honeydew2, linedwidth = 0, label = "soft")

	end
	plot!(yminorticks = 0:20:500)
	xlims!(0, 4)
end;

# ╔═╡ 5217fa57-31c1-48e9-82b2-0fbf032f58a2
begin
	bp # leave this line alone - it prints a plot template for you to start with
	# add your data to the plot using at barplot command

		
	
	# once you've added your data bars, you can change the labels to match yours:
	xticks!([1, 2], ["Sample 1", "Sample 2"])
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
HTTP = "~1.9.14"
Plots = "~1.38.17"
PlutoUI = "~0.7.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "76051ab2df85ec44e12a825071ce509bfeed884b"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "d9a8f86737b665e15a9641ecbac64deef9ce6724"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.23.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "e460f044ca8b99be31d35fe54fc33a5c33dd8ed7"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.9.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "5372dbbf8f0bdb8c700db5367132925c0771ef7e"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "d73afa4a2bb9de56077242d98cf763074ab9a970"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.9"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1596bab77f4f073a14c62424283e7ebff3072eca"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.9+1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "cb56ccdd481c0dd7f975ad2b3b62d9eda088f7e2"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.14"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "a03c77519ab45eb9a34d3cfe2ca223d79c064323"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "bbb5c2115d63c2f1451cb70e5ef75e8fe4707019"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.22+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "364898e8f13f7eaaceec55fd3d08680498c0aa6e"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.4.2+3"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "c60ec5c62180f27efea3ba2908480f8055e17cee"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "b7a5e99f24892b6824a954199a45e9ffcc1c70f0"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "a72d22c7e13fe2de562feda8645aa134712a87ee"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.17.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cf2c7de82431ca6f39250d2fc4aacd0daa1675c0"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╠═533ca516-499e-11ee-3788-a54f32761e35
# ╟─0dcb97bb-75de-40c8-92b4-085039b3c808
# ╟─ab44ebff-922a-4140-9dc1-36d6ab56cde5
# ╟─8b4c0ed9-c4d8-4dd4-8468-3ef5f46f2d1e
# ╟─b619a54e-9b92-4978-b9dd-585b309ebeb9
# ╟─1b058e01-742c-4146-a062-25092cb34f5f
# ╟─ad68e314-7fad-4705-bd09-0ddd82678375
# ╟─24b500a2-52c2-4d3b-a286-6d660ee3216a
# ╠═9d718310-2556-45d2-a57b-a221a360dbbc
# ╟─80749d9c-a8cf-4a00-94bc-ce6c7af38be5
# ╠═7ba1fcdf-f376-485d-8b01-0432284735fe
# ╟─f7dacd8f-7cd8-47e8-8fb1-835028bb908f
# ╠═41884798-2e11-4aa1-a875-34c5c421ab10
# ╟─2f2f7f4c-99b3-4a49-ba0a-4de1eab58d44
# ╠═4ef09457-6657-427e-a158-56c0954f2ceb
# ╟─df38b3cf-699a-40c9-93dc-5524f868dc69
# ╠═edf3278e-dba3-456d-8299-b88967a3768a
# ╟─cabd8bf6-fe92-454f-9b86-18e35a2133e3
# ╟─a12b6946-4636-4c1b-95e9-d119b233f1b2
# ╟─63817177-79c7-464f-b078-d9429dab2ef6
# ╠═4cd476c7-9dae-4b6a-8e11-e1a8c073faf1
# ╟─65a16182-b3ec-4a7c-89d8-1864ae6b0a16
# ╠═962e28a4-4c4b-4d95-bad6-4c0227e68c18
# ╟─d9cb80cb-ad76-4a59-b292-1be91c6b4969
# ╟─011cec10-281f-423d-92c2-02edbf5604a7
# ╟─de80157a-94bb-45dd-97d2-d6832439a0e4
# ╟─d875d4fa-69d2-414e-9b66-eb8fcb3e5a6e
# ╟─28aea002-c733-46b8-b13f-1b95b84b628f
# ╟─5fc1bd79-33e4-4cb1-9836-7f497ecb1c39
# ╠═3c5782dd-c136-4577-a620-550ce5dede64
# ╟─17b7f094-22c6-4beb-b127-3b8fe8b3f849
# ╠═de6ff0fb-e93c-4e04-bf7a-41363f085287
# ╟─66718893-3f53-46e2-8dd7-166830ff8daa
# ╟─df08032a-f18d-4035-a20b-e23db0a3bb68
# ╠═3149d270-6a25-4cca-9b3a-9bdb7c5fbd70
# ╟─0ff1f065-d550-45d7-bd93-1fd146dd2d37
# ╟─60037b11-934f-419d-adac-697246ae88a6
# ╟─dfa67404-191b-41d3-a94a-3e3472fbe74c
# ╠═f01d1468-6828-4bbb-b43c-2353ce35d03c
# ╟─70b0ec84-b832-4c6a-b587-25858d533674
# ╟─8f6ee904-9efb-4add-83bc-d71c43b279a3
# ╟─4f80fc16-78bd-4c20-8745-9e568948f296
# ╠═90e412f2-8472-4f93-a0c4-643e3a7267f9
# ╠═7e628816-2fa3-40b8-aea5-6ed504914984
# ╟─0721ebf7-89ee-4765-be84-cf001854dffd
# ╟─679d496c-6f5c-4322-b6ad-f2d0c366751e
# ╟─c6e57815-f65e-47c8-b8fb-a067755d66a1
# ╠═af07da1e-b9e7-440e-8afb-24ea0b6f037d
# ╟─b1af2cd8-b41a-4f5f-a1ef-28dd38563fd9
# ╟─42af4aed-4f7e-4052-ac7c-857e966c7c87
# ╟─d76fd365-5655-4314-9873-409c3c65be8d
# ╟─793e2b55-5b2b-4ee5-a19f-0b278d84db24
# ╟─f928c7d7-4191-4169-8e64-cdda8bb643a2
# ╟─4578ddb1-4d6c-462d-a801-0fb4bd602f8d
# ╟─ed85ac6b-d1a2-4688-8ac4-3293f1dd1cb2
# ╟─2e1d8757-faba-479c-8687-3fd0f7ef8344
# ╟─529ecdc2-f822-47d6-a8ab-337619346cab
# ╠═62104a86-5675-4180-bcf6-9b68d6589372
# ╠═35221e1e-4373-4078-98ee-3fd3a6ddf911
# ╠═c36311fb-d01f-4a47-88fc-ab3b4cf1d8b9
# ╟─47ad7d8f-b590-433d-98c9-72c243cb8214
# ╟─40bc05c0-5622-4149-943c-6c5739fff534
# ╟─9bbda8a8-7ed3-407a-aebc-ae4d2d21e6d1
# ╠═dfc14892-f48e-44f1-bc66-c1f60b5d2ebe
# ╠═d215bbbe-8bc2-44c0-85d9-cfe4383061cd
# ╠═7c57df57-4595-4937-ae0e-7db2d8312897
# ╟─d78edaf8-e526-47e4-b336-87762943daad
# ╟─0a3e5e4f-796d-4deb-a1ef-01af01bfff8c
# ╟─72b7176d-349d-4f1e-bbad-1d822ad0338a
# ╟─664e0bcd-a9ce-4cda-9c4a-55336868a838
# ╠═4025c24c-d134-4ac1-a1a7-02580f401b1b
# ╠═8be5bbc9-92e5-4398-86b7-ab4788633d28
# ╟─db10e70f-3fe9-42b4-a886-171eedd05ecc
# ╟─2dbca923-7c36-4c3f-97f2-8f5ce034a537
# ╟─10887f16-8060-400a-ab0b-4047d65517fa
# ╟─3f5a4b8b-f628-43bd-bd2a-b8ddf99e9a8a
# ╟─1b856ce5-7e99-42b6-bc90-eb2f456a8324
# ╠═5217fa57-31c1-48e9-82b2-0fbf032f58a2
# ╟─5025a932-6296-41c2-a230-a8117b22da0c
# ╠═de422319-fcbc-400b-aa17-9ac31d2afc39
# ╟─ca1f6c8c-f74f-4124-bb9b-1d5786b78bf5
# ╟─dfab82be-e30e-4566-99ce-dee5e06fb69c
# ╟─f7e2c6ea-1b8d-46e0-8f90-357c308f9848
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
