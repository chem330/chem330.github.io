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

# ╔═╡ ad8c8370-4121-47df-804f-ebb6b88f85e4
using Statistics

# ╔═╡ 60885571-b9e0-4c11-8b38-86bb648186d8
using PlutoUI; PlutoUI.TableOfContents()

# ╔═╡ 6163cfd2-5986-450a-83c3-838acbd53bb3
# Do not edit this cell!!!
begin
	using HTTP
	r = HTTP.request("GET", "https://raw.githubusercontent.com/chem330/chem330.github.io/main/error/errorTests.jl")
	eval(Meta.parse(String(r.body)))
end;

# ╔═╡ d3862a49-f246-4b71-b358-189c4296141a
html"<button onclick='present()'>Toggle Single Page Mode</button>"

# ╔═╡ 15856b2e-b43b-41ed-ba9f-8a66120fb31b
md"""

# Introduction

In this lab, you will examine the uncertainty associated with different ways of delivering a specified volume of liquid.  You will do this by measuring deionized water using four methods: (1) a beaker, (2) a graduated cylinder, (3) a volumetric glass pipette, and (4) a mechanical pipette. Each of these will be compared against an analytical balance.   As a final exercise, you will choose one of these methods to use to determine the identity (based on density) of an unknown liquid with the **smallest possible uncertainty**.  To obtain a bigger dataset for analysis, we will compile the data and determine statistics at the class level.

In this lab, you will determine the mean and standard deviation of your group's data (we will look at additional statistics on the class-level data later).

The **mean** ($\mu$) is defined as:

$$\overline{X} = \frac {\sum_{i=1}^n X_i} {n}$$

Here, $X_i$ is the $i$th measurement and $n$ is the total number of obsrevations.

The *standard deviation* ($S$) is defined as:

$$s = \sqrt{\frac {\sum_{i = 1}^{n} (X_i - \overline{X})^{2}} {n - 1}}$$

These values can be calculated manually, but the [Statistics](https://docs.julialang.org/en/v1/stdlib/Statistics/) package for Julia provides functions that will calculate them for you; they are `mean()` and `std()`.  You can find more about these by using the *Live Docs* feature in the bottom right of the page.
"""

# ╔═╡ 013ce92f-8dea-46f6-a01f-7b043c40225d
md"# What to Turn In"

# ╔═╡ d388c298-172d-424e-83b8-4d9d17244cfd
md"""

When you have completed this notebook, you should:

1. Click the "Export Final Data" button below.
2. Click the export button at the top of the page (to the right of the filename) and choose Static HTML.
3. Upload **three** files to Canvas.
   1. Your static HTML file (probably in your web browser's download folder, .html extenstion)	
   2. Your final dataset (found in your notebook working directory, .CSV extenstion)
   3. Your Notebook code file (found in your notebook working directory, .jl extension)

"""

# ╔═╡ 41d37600-4d1f-4cad-bbfa-95ef8c17c727
@bind savefinaldat Button("Export Final Data 💾")

# ╔═╡ 7eb9009b-d8bb-434b-a4ba-54194857dbf2
md"""
**NOTE:** The code you write is saved automatically, but the answers you put into the text boxes will default to 0.00 everytime you re-open the notebook.  Make sure you export your work before closing the notebook!
"""

# ╔═╡ 6e105c71-32c9-427b-bb02-b4ab04e24765
md"# Methods and Calculations"

# ╔═╡ 49a5987e-6104-4873-b3ea-e8644a4b3a21
md"This loads the Statistics package."

# ╔═╡ 3ff2734a-2785-4a78-9ea3-87f3b264b3e9
md"## Part 1: Beakers"

# ╔═╡ eb1b6135-e733-4391-af43-f8d7ab519d3e
md"""

Write your methods here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ c13c4fe8-346e-11ee-0b45-e9a54dd8538a
beaker_masses = [ missing, missing, missing, missing, missing ]

# ╔═╡ de8ef3c6-2cb3-4c8d-823c-6e2b6de7c47e
check_input_sf(beaker_masses, "beaker")

# ╔═╡ ed4f1809-29e4-4b5d-8145-5327d97f316e
md"### Mean"

# ╔═╡ a52d8cdc-6ee0-4e1f-b439-dcbea5eba032
md"Calculate the mean of the masses in the cell below.  You can do this manually with the formula above, or use the `mean()` function [for example `mean(beaker_masses)`]."

# ╔═╡ 0ff710f8-e05c-4760-8146-a03bd31be00f
beaker_mean = mean(beaker_masses)

# ╔═╡ 8f4b8587-0d33-4bea-9746-c766bccf782a
md"""
Enter your **mean** here to the correct number of significant digits.  If your answer is correct, the box below will turn green."

$(@bind beaker_mean_final TextField(default = "0.00"))
"""

# ╔═╡ 44684706-3a54-4e51-8e69-ff4699868c78


# ╔═╡ 574806d7-4d56-43c8-8fe8-d10d0e0195e7
check_answer_errorLab(beaker_mean_final, mean(beaker_masses), 1000, "mean")

# ╔═╡ 3f3a60b7-ea28-4406-a821-c24f3f6e199b
md"### Standard Deviation"

# ╔═╡ 5980a68a-1808-48bf-b58e-47d05e283d88
md"Calculate the standard deviation of the masses in the cell below.  You can do this manually with the formula above, or use the `std()` function [for example `std(beaker_masses)`]."

# ╔═╡ 0537e522-b404-4d57-987f-d37f89735d2e
beaker_sd = std(beaker_masses)

# ╔═╡ 642e3a42-c305-406e-a94f-fb5406ac0983
md"""
Enter your **standard deviation** here to the correct number of significant digits:

$(@bind beaker_sd_final TextField(default = "0.00"))
"""

# ╔═╡ 636f627f-d3ee-4fd5-b52c-f023484736c2
check_answer_errorLab(beaker_sd_final, std(beaker_masses), 10, "standard deviation")

# ╔═╡ b4734832-7f36-4fe9-8a3b-3dc3fc65362a
md"## Part 2: Graduated Cylinders"

# ╔═╡ 34dd890b-5609-4803-89a9-84d9f3f66bc7
md"""

Write your methods here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ bb1dce14-3e33-4762-a58f-95b76ac13e35
cylinder_masses =  [ missing, missing, missing, missing, missing ]

# ╔═╡ 2a221c37-6fbd-4f5d-95c0-70af4b5e8d89
check_input_sf(cylinder_masses, "cylinder")

# ╔═╡ 06285717-20f9-49e6-93d1-be1c80ca3dcb
md"### Mean"

# ╔═╡ 7090fb0d-56ea-44f5-9bb0-ec50843f3c53


# ╔═╡ 5005ea04-ec00-4204-a7d7-38cc2d026dbe
md"""
Enter your **standard deviation** here to the correct number of significant digits:

$(@bind cyl_mean_final TextField(default = "0.00"))
"""

# ╔═╡ 2cf45f5a-10d4-4610-8836-73478d9692dc
check_answer_errorLab(cyl_mean_final, mean(cylinder_masses), 10000, "mean")

# ╔═╡ c7f27f8e-5390-4f55-8e33-5511e10aff01
md"### Standard Deviation"

# ╔═╡ 3785be0d-62ba-4476-a988-3676bbdf6fa0


# ╔═╡ 0c26f35e-bb46-4bff-a180-3b5be1452d76
md"""
Enter your **standard deviation** here to the correct number of significant digits:

$(@bind cyl_sd_final TextField(default = "0.00"))
"""

# ╔═╡ 446bc90e-a6f9-4f77-9741-565ab1dabb6e
check_answer_errorLab(cyl_sd_final, std(cylinder_masses), 100, "standard deviation")

# ╔═╡ bcdab602-2673-45f3-85d5-67a7f5badc65
md"## Part 3: Volumetric Pipette"

# ╔═╡ 65deaea8-3e8a-490d-b6df-5cdbecb69603
md"""

Write your methods here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ 3c9eb120-dbd2-494c-97b4-44369a6794be
pipette_masses =  [ missing, missing, missing, missing, missing ]

# ╔═╡ 771d7504-6a1b-4f95-8b95-42ddfb09c439
check_input_sf(pipette_masses, "volumetric pipette")

# ╔═╡ 4db12e02-5183-4afd-83fd-0066a3feb993
md"### Mean"

# ╔═╡ 31de64ed-5b64-4a02-b64b-edf89e47e863


# ╔═╡ 073bfc04-74c7-456f-b7e0-b5d8f52802a7
md"""
Enter your **mean** here to the correct number of significant digits:

$(@bind pip_mean_final TextField(default = "0.00"))
"""

# ╔═╡ 4f86d103-4d0b-4e8e-8509-02b712cad593
check_answer_errorLab(pip_mean_final, mean(pipette_masses), 10000, "mean")

# ╔═╡ 03fe9ef5-6419-44e9-ae18-4391782c3098
md"### Standard Deviation"

# ╔═╡ b6f0349f-7e7b-4869-b49a-9f75be15dab1


# ╔═╡ aadd2e5f-093c-4476-9904-4fbcb6f28592
md"""
Enter your **standard deviation** in the box below to the correct number of significant digits:

$(@bind pip_sd_final TextField(default = "0.00"))
"""

# ╔═╡ de2eb273-702f-47fe-92ea-acc44436b9c4
check_answer_errorLab(pip_sd_final, std(pipette_masses), 100, "standard deviation")

# ╔═╡ ffc5067b-89fd-4c90-92d5-1a68e0ee0548
md"## Part 4: Mechanical Pipette"

# ╔═╡ b09bc8c8-09c2-4f94-a17a-92a1d3abf182
md"""

Write your methods here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ 8ca4d6ad-bdd7-4ee8-a0d7-9baecb407061
mechanical_masses =  [ missing, missing, missing, missing, missing ]

# ╔═╡ 016eb596-2422-4dda-a22a-fd6224d92688
check_input_sf(mechanical_masses, "mechanical pipette")

# ╔═╡ 0faae04f-e6c4-496c-8933-61b77e021d79
md"### Mean"

# ╔═╡ ce911378-aadf-4bfe-a644-1242ae4a2ca2


# ╔═╡ 8ea90b55-4ce4-4195-878b-4676927a33ec
md"""
Enter your **mean** here to the correct number of significant digits:

$(@bind mech_mean_final TextField(default = "0.00"))
"""

# ╔═╡ 47c211e9-70a2-4a17-bc14-af92e5cce02e
check_answer_errorLab(pip_mean_final, mean(pipette_masses), 1000, "mean")

# ╔═╡ efea170a-6c84-462c-b519-3bcb0b4702ae
md"### Standard Deviation"

# ╔═╡ 8653b826-04de-4c5b-8c97-d14a4c54977b


# ╔═╡ bc7b17f6-8070-49d9-8d9a-9b766ee77e5e
md"""
Enter your **standard deviation** in the box below to the correct number of significant digits:

$(@bind mech_sd_final TextField(default = "0.00"))
"""

# ╔═╡ 7de78c4e-457f-40ad-8a06-ccb7dc6a9030
check_answer_errorLab(mech_sd_final, std(mechanical_masses), 1000, "standard deviation")

# ╔═╡ 4fc78cf4-c0e6-46bf-b2e0-a836d0d64a04
md"## Part 5: Determination of an Unknown Liquid"

# ╔═╡ 1b8dc9ef-d49c-4633-af4f-a354db862522
md"""

Write your methods here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ 9e24ec51-218a-4052-81f2-425ebc446136
md"Select the unknown solution analyzed with the dropdown below:"

# ╔═╡ f751e40c-880f-4f74-94fa-7d1cd4114a32
@bind unk Select(["Unknown A", "Unknown B"])

# ╔═╡ 2ba6507a-8bde-41b3-a65f-e8e397f97224
unknown_masses =  [ missing, missing, missing, missing, missing ]

# ╔═╡ 1e957906-1491-45ee-afa8-38e510e4c53e
md"### Mean"

# ╔═╡ 8dfa038e-89b9-4692-8ddc-dd6e8283307e


# ╔═╡ b8eda92a-d1c6-46f8-99b1-fdfbabfcba05
md"""
Enter your **standard deviation** here to the correct number of significant digits:

$(@bind unk_mean_final TextField(default = "0.00"))
"""

# ╔═╡ e89f202d-d4cf-47f5-8066-94ffad6142f9
check_answer_errorLab(unk_mean_final, mean(unknown_masses), 10000, "mean")

# ╔═╡ 0ebcb4a7-d008-417e-81a3-cebfd00ac991
md"### Standard Deviation"

# ╔═╡ bdaf95d4-6a8b-4de6-b78b-2accdbba712b


# ╔═╡ 9057b784-91a3-44e3-a333-6ede09b8b954
md"""
Enter your **standard deviation** here to the correct number of significant digits:

$(@bind unk_sd_final TextField(default = "0.00"))
"""

# ╔═╡ 1adbf59c-a43b-41a9-805a-8c4f71eaea86
check_answer_errorLab(unk_sd_final, std(unknown_masses), 100, "standard deviation")

# ╔═╡ 74a5babe-163c-4da1-933e-4ea989ee5b9a
md"""
## Confidence Intervals
"""

# ╔═╡ 3eeb01d3-1dc1-4a0f-b70b-1d771d92fd6c
md"""
The confidence intervals for the class-level data will be calculated in a separate notebook.
"""

# ╔═╡ 25a9b35e-3984-4263-b5ee-f51c92151189
md"# Conclusions"

# ╔═╡ ab505d06-3005-41e5-b818-efb9d9ddf484
md"""
Write a conclusion in the box below.  Make sure to specifically answer the following questions in your conclusions.

1. Which had the smallest standard deviation, your data or the class data? Is that what you expected? Why or why not?
2. Discuss the magnitude of the random (indeterminate) error in measurements using the different methods for measuring volume.  Which method has the smallest random error?  Why?
3. Do you suspect any systematic error in this experiment? Why? What could be done to correct it?
4. What was the identity of your unknown liquid? How do you know?  Is your result *significant*?
"""

# ╔═╡ d3b861f4-4a67-4be9-823f-7cae385f0297
md"""

Write your conclusion here using Markdown.  You can click the play button at the bottom right of this box when you are done to render the text and then click eyeball icon to the left to hide the code input box.

"""

# ╔═╡ a2596e0c-96d0-460a-ac79-a8b4d5495335


# ╔═╡ 73edfac2-cfab-42d0-89b3-14693958292f
# Do not edit this cell!!!
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

# ╔═╡ dbe1360c-4b71-43f6-ad9b-7a30b009769e
# Do not edit this cell!!!
begin
	savefinaldat
	dat = "Item\tMean\tSD\n"*"Beaker - 25 ml"*"\t"*string(beaker_mean_final)*"\t"*string(beaker_sd_final)*"\n"*"Grad. Cylinder"*"\t"*string(cyl_mean_final)*"\t"*string(cyl_sd_final)*"\n"*"Glass Pipette"*"\t"*string(pip_mean_final)*"\t"*string(pip_sd_final)*"\n"*"Mech Pipette"*"\t"*string(mech_mean_final)*"\t"*string(mech_sd_final)*"\n"*unk*"\t"*string(unk_mean_final)*"\t"*string(unk_sd_final)
	savepath = pwd()*"/errorLab_finalData.csv"
	open(savepath, "w") do datfile
		write(datfile, dat)
    end
end;

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
HTTP = "~1.9.14"
PlutoUI = "~0.7.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "cc81a03c0c0837d2005adbdad057892a44f62bba"

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

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "cb56ccdd481c0dd7f975ad2b3b62d9eda088f7e2"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.14"

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
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

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
# ╟─d3862a49-f246-4b71-b358-189c4296141a
# ╟─15856b2e-b43b-41ed-ba9f-8a66120fb31b
# ╟─013ce92f-8dea-46f6-a01f-7b043c40225d
# ╟─d388c298-172d-424e-83b8-4d9d17244cfd
# ╟─41d37600-4d1f-4cad-bbfa-95ef8c17c727
# ╟─7eb9009b-d8bb-434b-a4ba-54194857dbf2
# ╟─6e105c71-32c9-427b-bb02-b4ab04e24765
# ╟─49a5987e-6104-4873-b3ea-e8644a4b3a21
# ╠═ad8c8370-4121-47df-804f-ebb6b88f85e4
# ╟─3ff2734a-2785-4a78-9ea3-87f3b264b3e9
# ╠═eb1b6135-e733-4391-af43-f8d7ab519d3e
# ╠═c13c4fe8-346e-11ee-0b45-e9a54dd8538a
# ╟─de8ef3c6-2cb3-4c8d-823c-6e2b6de7c47e
# ╟─ed4f1809-29e4-4b5d-8145-5327d97f316e
# ╟─a52d8cdc-6ee0-4e1f-b439-dcbea5eba032
# ╠═0ff710f8-e05c-4760-8146-a03bd31be00f
# ╟─8f4b8587-0d33-4bea-9746-c766bccf782a
# ╠═44684706-3a54-4e51-8e69-ff4699868c78
# ╟─574806d7-4d56-43c8-8fe8-d10d0e0195e7
# ╟─3f3a60b7-ea28-4406-a821-c24f3f6e199b
# ╟─5980a68a-1808-48bf-b58e-47d05e283d88
# ╠═0537e522-b404-4d57-987f-d37f89735d2e
# ╟─642e3a42-c305-406e-a94f-fb5406ac0983
# ╟─636f627f-d3ee-4fd5-b52c-f023484736c2
# ╟─b4734832-7f36-4fe9-8a3b-3dc3fc65362a
# ╠═34dd890b-5609-4803-89a9-84d9f3f66bc7
# ╠═bb1dce14-3e33-4762-a58f-95b76ac13e35
# ╟─2a221c37-6fbd-4f5d-95c0-70af4b5e8d89
# ╟─06285717-20f9-49e6-93d1-be1c80ca3dcb
# ╠═7090fb0d-56ea-44f5-9bb0-ec50843f3c53
# ╟─5005ea04-ec00-4204-a7d7-38cc2d026dbe
# ╟─2cf45f5a-10d4-4610-8836-73478d9692dc
# ╟─c7f27f8e-5390-4f55-8e33-5511e10aff01
# ╠═3785be0d-62ba-4476-a988-3676bbdf6fa0
# ╟─0c26f35e-bb46-4bff-a180-3b5be1452d76
# ╟─446bc90e-a6f9-4f77-9741-565ab1dabb6e
# ╟─bcdab602-2673-45f3-85d5-67a7f5badc65
# ╠═65deaea8-3e8a-490d-b6df-5cdbecb69603
# ╠═3c9eb120-dbd2-494c-97b4-44369a6794be
# ╟─771d7504-6a1b-4f95-8b95-42ddfb09c439
# ╟─4db12e02-5183-4afd-83fd-0066a3feb993
# ╠═31de64ed-5b64-4a02-b64b-edf89e47e863
# ╟─073bfc04-74c7-456f-b7e0-b5d8f52802a7
# ╟─4f86d103-4d0b-4e8e-8509-02b712cad593
# ╟─03fe9ef5-6419-44e9-ae18-4391782c3098
# ╠═b6f0349f-7e7b-4869-b49a-9f75be15dab1
# ╟─aadd2e5f-093c-4476-9904-4fbcb6f28592
# ╟─de2eb273-702f-47fe-92ea-acc44436b9c4
# ╟─ffc5067b-89fd-4c90-92d5-1a68e0ee0548
# ╠═b09bc8c8-09c2-4f94-a17a-92a1d3abf182
# ╠═8ca4d6ad-bdd7-4ee8-a0d7-9baecb407061
# ╟─016eb596-2422-4dda-a22a-fd6224d92688
# ╟─0faae04f-e6c4-496c-8933-61b77e021d79
# ╠═ce911378-aadf-4bfe-a644-1242ae4a2ca2
# ╟─8ea90b55-4ce4-4195-878b-4676927a33ec
# ╟─47c211e9-70a2-4a17-bc14-af92e5cce02e
# ╟─efea170a-6c84-462c-b519-3bcb0b4702ae
# ╠═8653b826-04de-4c5b-8c97-d14a4c54977b
# ╟─bc7b17f6-8070-49d9-8d9a-9b766ee77e5e
# ╟─7de78c4e-457f-40ad-8a06-ccb7dc6a9030
# ╟─4fc78cf4-c0e6-46bf-b2e0-a836d0d64a04
# ╠═1b8dc9ef-d49c-4633-af4f-a354db862522
# ╟─9e24ec51-218a-4052-81f2-425ebc446136
# ╟─f751e40c-880f-4f74-94fa-7d1cd4114a32
# ╠═2ba6507a-8bde-41b3-a65f-e8e397f97224
# ╟─1e957906-1491-45ee-afa8-38e510e4c53e
# ╠═8dfa038e-89b9-4692-8ddc-dd6e8283307e
# ╟─b8eda92a-d1c6-46f8-99b1-fdfbabfcba05
# ╟─e89f202d-d4cf-47f5-8066-94ffad6142f9
# ╟─0ebcb4a7-d008-417e-81a3-cebfd00ac991
# ╠═bdaf95d4-6a8b-4de6-b78b-2accdbba712b
# ╟─9057b784-91a3-44e3-a333-6ede09b8b954
# ╟─1adbf59c-a43b-41a9-805a-8c4f71eaea86
# ╟─74a5babe-163c-4da1-933e-4ea989ee5b9a
# ╟─3eeb01d3-1dc1-4a0f-b70b-1d771d92fd6c
# ╟─25a9b35e-3984-4263-b5ee-f51c92151189
# ╟─ab505d06-3005-41e5-b818-efb9d9ddf484
# ╠═d3b861f4-4a67-4be9-823f-7cae385f0297
# ╟─a2596e0c-96d0-460a-ac79-a8b4d5495335
# ╟─60885571-b9e0-4c11-8b38-86bb648186d8
# ╟─6163cfd2-5986-450a-83c3-838acbd53bb3
# ╠═73edfac2-cfab-42d0-89b3-14693958292f
# ╠═dbe1360c-4b71-43f6-ad9b-7a30b009769e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
