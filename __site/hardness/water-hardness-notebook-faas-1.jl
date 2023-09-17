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

# ╔═╡ fa3a07ee-556c-11ee-0961-bfb0756f3d78
using PlutoUI, PlutoTeachingTools; PlutoUI.TableOfContents()

# ╔═╡ d0e7217b-0a86-4ad7-a5d4-5dd57337f6ff
# Do not edit this cell!!!
begin
	using HTTP
	r = HTTP.request("GET", "https://raw.githubusercontent.com/chem330/chem330.github.io/main/hardness/hardness_tests_fass.jl")
	eval(Meta.parse(String(r.body)))
	inst_stock_concs=setstockconcs()
end;

# ╔═╡ c93ac5b6-f5c2-4be8-b4c6-92c87aeef79d
ChooseDisplayMode()

# ╔═╡ 8d0a5f33-613f-4807-88a3-9b3459ce3f58
md"""
# Introduction
"""

# ╔═╡ d0e6b4a5-c78b-41c8-ae7d-6da9fbc94437
# write a brief introduction here

# ╔═╡ a75a6577-5e9a-4a7d-b0f1-28d99d8dd251
md"""
# Materials and Methods

This section should include **detailed** information about how you collected, processed, and analyzed the samples.  A stranger should be able to reproduce your experiment *extactly* using only the information in this section.

"""

# ╔═╡ d032e1ab-965a-4921-a6ee-6d5bf89df3d5
md"""
## Sample Information and Pre-treatment
"""

# ╔═╡ 34bf9086-8046-43c0-b3f5-423634c7f3cb
# enter information about the samples here

# ╔═╡ 450ec491-6aad-4208-bcf0-7e4e988ccaf5
md"""
## Standard Creation


"""

# ╔═╡ 460bc0a6-00ec-4f28-81bb-f9257c946394
md"""
A stock solution was prepared by the instructor by dissolving **0.5860 g Mg** filings in a minimum of 1:1 trace-metals grade nitric acid.  This was added to approximately 500 ml of deionized water in a **1-L volumetric flask**, to which **1.2770 g of $\ce{CaCO3}$** were added and allowed to dissolve.  After dissolution, the flask was placed in a sonicator on degas mode for approximately 2 minutes to ensure all $\ce{CO2}$ was released from solution.  Finally, the flask was brought to volume with deionized water, the solution transferred to a 1-L polylpropylene flask and stored at 4°C until analysis. The stock was brought to room temperature prior to analysis.  All glassware was washed with Alconox detergent and warm water and then triple rinsed with deionized water prior to use. $\ce{CaCO3}$ was dried overnight in an oven and then stored in a dessicator until use.
"""

# ╔═╡ 0974b715-3464-4c10-85b9-fbae31171d94
# enter information about how you diluted the stock to create your standards here

# ╔═╡ feca0d24-9e39-4b26-9a22-41da1ec4ecb8
md"""
### Standard Calculations
"""

# ╔═╡ 07058482-6902-44d6-981b-2272fc9b3b17
md"When doing these calculations, recall that $C_1V1 = C_2V_2$."

# ╔═╡ 302b98a5-cf7f-4fd6-8bd1-a5fbb1c84183
md"""
**Stock Mg Concentration (mg/L):** $(@bind stock_mg TextField(default = "0.00")) mg/L
"""

# ╔═╡ c2adede0-6173-461b-9b66-be237832ae55
md"""
**Stock Ca Concentration (mg/L):** $(@bind stock_ca TextField(default = "0.00")) mg/L
"""

# ╔═╡ 6771043e-9add-420b-97e5-b71ee43aee15


# ╔═╡ 1f4bb454-2e96-4c93-9345-74622d0d3292
vol_flask_sizes = [missing, missing, missing, missing, missing] # ml

# ╔═╡ a88d6707-7f0a-477b-a483-55538e97d7c8
pipette_sizes = [missing, missing, missing, missing, missing] # ml

# ╔═╡ a2242f35-d352-42ce-aa00-14054bcc4d74
std_concs_ca = missing

# ╔═╡ 048752fa-ea11-4e51-862f-fbb128e027fc
check_dilutions(std_concs_ca, inst_stock_concs.ca, vol_flask_sizes, pipette_sizes, species = "calcium")

# ╔═╡ f18c236a-f27b-4d84-aabd-d79d38171a4c
std_concs_mg = missing

# ╔═╡ 04da35a4-7f2f-43aa-aace-c671f2783c38
check_dilutions(std_concs_mg, inst_stock_concs.mg, vol_flask_sizes, pipette_sizes, species = "magnesium", a = 0.0001)

# ╔═╡ 4899256d-6f34-4a87-a88b-6e39c499f25f
la_amount = 1.00 # ml

# ╔═╡ 4e9431f9-676e-4630-8c9a-b57bf38636d8


# ╔═╡ 78679e07-9356-45dc-bd68-f025a0ecd153
sample_volumes = [missing, missing, missing, missing, missing]

# ╔═╡ ebe32ffa-b4ff-49f6-8ef4-0c2cad0f7d5a


# ╔═╡ ea6e804f-220c-41f0-93e9-d0db2a004929
final_std_concs_ca = missing

# ╔═╡ 95d0e0bc-ef59-4faa-bd4b-d2f6b2812d5a
check_dilutions(final_std_concs_ca, std_concs_ca, ones(5) .* 11, ones(5) .* 10, species = "final calcium", a = 0.001)

# ╔═╡ ba7f53d1-4bd7-437b-aad2-d53599b51454
final_std_concs_mg = missing

# ╔═╡ 44522e65-ebd5-4fa4-9084-003fbf3873c1
check_dilutions(final_std_concs_mg, std_concs_mg, ones(5) .* 11, ones(5) .* 10, species = "final magnesium", a = 0.001)

# ╔═╡ 973e69cd-e1f3-48f5-8c8d-0c3dc763f2d1
md"""
## Analysis via FAAS
"""

# ╔═╡ 946bca8e-0c1a-417d-b905-625cbfe9585d
# enter info about the FAAS here.  Also make sure you fill in the table below.

# ╔═╡ f42e74c3-ab6d-450b-94a4-853f2e8c08dd
md"""
| Parameter 	            | Value   	|
|:--------------------------|:---------:|
| Make and Model 			| 			|
| Fuel      				|    	 	|
| Fuel Flow Rate (ml/min)   | 			|
| Oxidant   				|        	|
| Oxidant Flow Rate (ml/min)|           |
| Element(s)				|        	|
| Wavelengths(s) (nm)		|           |
| Rinse Solution            |           |
| Rinse Frequency           |           |
| Read Delay (s)            |           |
"""

# ╔═╡ fc2ce937-b8f2-4704-8da0-5158e44c107f
md"""
# Results and Data Processing

The results will be analyzed in a separate file.
"""

# ╔═╡ 79e7574b-b1a3-4a8c-85a1-aa1ecb9ca964


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HTTP = "~1.9.15"
PlutoTeachingTools = "~0.2.13"
PlutoUI = "~0.7.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "bf2c6bc47a66698b2582a1ccf16de473950d280f"

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

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "a1296f0fe01a4c3f9bf0dc2934efbf4416f5db31"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "5372dbbf8f0bdb8c700db5367132925c0771ef7e"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "19e974eced1768fb46fd6020171f2cec06b1edb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.15"

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

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "81dc6aefcbe7421bd62cb6ca0e700779330acff8"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.25"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "0d097476b6c381ab7906460ef1ef1638fbce1d91"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.2"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "60168780555f3e663c536500aa790b6368adc02a"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.3.0"

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

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e78db7bd5c26fc5a6911b50a47ee302219157ea8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.10+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "542de5acb35585afcf202a6d3361b430bc1c3fbd"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.13"

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

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "1e597b93700fa4045d7189afa7c004e0584ea548"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

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

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─c93ac5b6-f5c2-4be8-b4c6-92c87aeef79d
# ╟─8d0a5f33-613f-4807-88a3-9b3459ce3f58
# ╠═d0e6b4a5-c78b-41c8-ae7d-6da9fbc94437
# ╟─a75a6577-5e9a-4a7d-b0f1-28d99d8dd251
# ╟─d032e1ab-965a-4921-a6ee-6d5bf89df3d5
# ╠═34bf9086-8046-43c0-b3f5-423634c7f3cb
# ╟─450ec491-6aad-4208-bcf0-7e4e988ccaf5
# ╟─460bc0a6-00ec-4f28-81bb-f9257c946394
# ╠═0974b715-3464-4c10-85b9-fbae31171d94
# ╟─feca0d24-9e39-4b26-9a22-41da1ec4ecb8
# ╟─07058482-6902-44d6-981b-2272fc9b3b17
# ╟─302b98a5-cf7f-4fd6-8bd1-a5fbb1c84183
# ╟─c2adede0-6173-461b-9b66-be237832ae55
# ╟─6771043e-9add-420b-97e5-b71ee43aee15
# ╠═1f4bb454-2e96-4c93-9345-74622d0d3292
# ╠═a88d6707-7f0a-477b-a483-55538e97d7c8
# ╠═a2242f35-d352-42ce-aa00-14054bcc4d74
# ╟─048752fa-ea11-4e51-862f-fbb128e027fc
# ╠═f18c236a-f27b-4d84-aabd-d79d38171a4c
# ╟─04da35a4-7f2f-43aa-aace-c671f2783c38
# ╠═4899256d-6f34-4a87-a88b-6e39c499f25f
# ╟─4e9431f9-676e-4630-8c9a-b57bf38636d8
# ╠═78679e07-9356-45dc-bd68-f025a0ecd153
# ╟─ebe32ffa-b4ff-49f6-8ef4-0c2cad0f7d5a
# ╠═ea6e804f-220c-41f0-93e9-d0db2a004929
# ╟─95d0e0bc-ef59-4faa-bd4b-d2f6b2812d5a
# ╠═ba7f53d1-4bd7-437b-aad2-d53599b51454
# ╟─44522e65-ebd5-4fa4-9084-003fbf3873c1
# ╟─973e69cd-e1f3-48f5-8c8d-0c3dc763f2d1
# ╠═946bca8e-0c1a-417d-b905-625cbfe9585d
# ╟─f42e74c3-ab6d-450b-94a4-853f2e8c08dd
# ╟─fc2ce937-b8f2-4704-8da0-5158e44c107f
# ╟─79e7574b-b1a3-4a8c-85a1-aa1ecb9ca964
# ╟─fa3a07ee-556c-11ee-0961-bfb0756f3d78
# ╟─d0e7217b-0a86-4ad7-a5d4-5dd57337f6ff
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
