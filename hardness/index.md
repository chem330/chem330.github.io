+++
title = "Water Hardness"
+++

Water Hardness
==================

\toc

# Background

Water "hardness" is not a single chemical species, but rather a character of the water that can result from the presence of several species, primarily magnesium and calcium.  The term "hard water" results from the fact that metal ions will precipitate soap molecules from water making it "hard" to get things clean.  Hard water can also cause problems in plumbing, especially in water heaters and boilers, by causing lime scale when the calcium precipitates out of solution as calcium carbonate upon heating; this is sometimes referred to as temporary hardness.  The convention for reporting hardness is to report it as milligrams of $\ce{CaCO3}$ per liter, as if all of the hardness were from calcium carbonate.  This allows hardness values to be compared from different locations, regardless of the ions that contribute to hardness, but requires that results be mathematically converted to $\ce{CaCO3}$ before they are reported.

Water hardness is usually determined by measuring the total amount of calcium and magnesium present, and there are several techniques by which this can be done. Hardness is often determined by titration using an indicator that reacts with calcium and magnesium.  Another method of determining hardness is to quantitatively measure the concentrations of magnesium and calcium present using instrumental methods such as inductively coupled plasma mass spectrometry (ICP-MS) or flame atomic absorption spectrophotometry (FAAS).  We will compare both methods on the same samples.

## EDTA Titration

We will titrate samples using ethylene diamine-N,N,N',N'-tetraacetic acid (EDTA).  EDTA is a chelating agent that can donate electrons, thereby forming a complex with metal ions.  The EDTA will complex first with the $\ce{Ca^2+}$ and then with the $\ce{Mg^2+}$.  We will use a colorimetric indicator to determine when all of the $\ce{Ca^2+}$ and $\ce{Mg^2+}$ have complexed with the EDTA (i.e. the endpoint).  We will use a solution of Calmagite for this.  As seen in the figure below, Calmagite has acidic OH groups that can bind $\ce{Ca^2+}$ and $\ce{Mg^2+}$, which will cause the solution to have a wine-red color.  However, EDTA will bind calcium and magnesium more strongly than Calmagite.  Once enough EDTA has been added to bind all the calcium and magnesium ions and they are no longer bound to Calmagite the solution will turn blue.  Near the endpoint, the solution will appear purple, so the endpoint is often observed  at the exact point the solution turns from purple to blue.

![Molecular structure of Calmagite](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Calmagite.png/1024px-Calmagite.png)

The EPA provides [method 130.2](https://www.nemi.gov/methods/method_summary/4684/) for determination of hardness by colorimetric titration, which will be followed here.

## Instrumental Methods

Hardness can also be determined by measuring the concentration of magnesium and calcium using instrumental methods such as inductively coupled plasma mass spectrometry (ICP-MS) or flame atomic absorption spectrophotometry (FAAS).

# Part 0: Sample Preparation

1. Collect a sample of tap water from wherever you usually get your drinking water.
2. According to EPA Method 130.2, "For drinking waters, surface waters, saline waters, and dilutions
thereof, no pretreatment steps are necessary."

# Part 1: EDTA Titration

## Prepare the EDTA Titrant

Prepare 500 mL of EDTA titrant by weighing 1.8615 g disodium ethylenediaminetetraacetate dehydrate, also called (ethylenedinitrilo)tetraacetic acid disodium salt (EDTA).  Carefully transfer the EDTA solid to a 500 mL volumetric flask, being careful not to spill any of your sample.  Dilute to 500 mL with distilled water, mixing well to dissolve the EDTA.  This is the solution you will use for the following titrations.

## Blank Determination

1. Measure approximately 50 mL of deionized water into a 250 mL flask.
2. Add 2.0 mL of the buffer solution.  The remainder of the titration must be completed within 15 	minutes of the time when the buffer is added.
3. Add 4 drops of Eriochrome Black T indicator solution.
4. Titrate using the EDTA titrant.  At the end point, the color should change from red to blue.
5. Repeat this procedure at least two additional times.
6. Average the volume of EDTA titrant used for the 3 blank determinations.  Subtract this volume 	from all future titrations.

## Standardize the EDTA Solution

Before using the EDTA to titrate water samples, we must know its exact concentration.  We will use a solution of calcium carbonate (1.00 mg $\ce{CaCO3}$/mL) as the primary standard to determine the exact concentration of EDTA solution.

1. Measure exactly 20.0 mL of the $\ce{CaCO3}$ standard solution into a 250 mL flask.  Add 	approximately 30 mL of deionized water to the flask.
2. Add 2.0 mL of the buffer solution.  The remainder of the titration must be completed within 15 	minutes of the time when the buffer is added.
3. Add 4 drops of Eriochrome Black T indicator solution.
4. Titrate using the EDTA titrant.  At the end point, the color should change from red to blue.
5. Repeat this procedure at least two additional times.
6. Use this data and the data from part A to calculate exactly how much EDTA titrant is needed to react with 1.00 mg of $\ce{CaCO3}$.  You will use this value in your calculations to determine the water 	hardness.

## Titrate Your Samples

### Freshwater or Tap Water

1. Measure exactly 50 mL of the water sample into a 250 mL flask.  
2. Add 2.0 mL of the buffer solution.  The remainder of the titration must be completed within 15 	minutes of the time when the buffer is added.
3. Add 4 drops of Eriochrome Black T indicator solution.
4. Titrate using the EDTA titrant.  At the end point the color should change from red to blue.
5. Repeat this procedure at least two additional times. 
6. Use this data and the data from parts A and B to calculate the hardness of your water sample in 	milligrams of $\ce{CaCO3}$ per liter. 

### Hard Water or Seawater

1. Measure exactly 5.0 mL of the ocean water sample into a 250 mL flask.  Dilute the ocean water 	1:10 by adding 45 mL of deionized water to the flask.  Because the ocean water has a 	significantly higher concentration of $\ce{Ca^2+}$ ions, this dilution will decrease the amount of EDTA titrant required to reach the endpoint.
2. Add 2.0 mL of the buffer solution.  The remainder of the titration must be completed within 15 	minutes of the time when the buffer is added.
3. Add 4 drops of Eriochrome Black T indicator solution.
4. Titrate using the EDTA titrant.  At the end point the color should change from red to blue.
5. Repeat this procedure at least two additional times.  
6. Use this data and the data from parts A and B to calculate the hardness of your water sample in 	mg $\ce{CaCO3}$ per L.  Make sure you take into account the 1:10 dilution of your ocean water sample.  (The hardness of the ocean water will actually be 10 times the value you calculate because of the 	10-fold dilution of the water sample.)

### What to Turn In - Part 1

1. Turn in your completed Pluto notebook as an HTML file.
2. Turn in your completed Pluto notebook as a .jl file.
3. Turn in a CSV file exported from Julia containing your data.

# Part 2: Flame Atomic Absorption

## Prepare your standards

## Prepare your samples

### Quality Control Sample

### Unknown Samples

## Analyze your samples

## What to Turn In - Part 2
