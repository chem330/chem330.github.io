+++
title = "Water Hardness"
+++

Water Hardness
==================

\toc

# Background

*This is a 2-week lab.*
 - *Week 1 notebook template:* [week 1 notebook template link](https://raw.githubusercontent.com/chem330/chem330.github.io/main/hardness/water-hardness-notebook.jl)

Water "hardness" is not a single chemical species, but rather a character of the water that can result from the presence of several species, primarily magnesium and calcium.  The term "hard water" results from the fact that metal ions will precipitate soap molecules from water making it "hard" to get things clean.  Hard water can also cause problems in plumbing, especially in water heaters and boilers, by causing lime scale when the calcium precipitates out of solution as calcium carbonate upon heating; this is sometimes referred to as temporary hardness.  The convention for reporting hardness is to report it as milligrams of $\ce{CaCO3}$ per liter, as if all of the hardness were from calcium carbonate.  This allows hardness values to be compared from different locations, regardless of the ions that contribute to hardness, but requires that results be mathematically converted to $\ce{CaCO3}$ before they are reported.

Water hardness is usually determined by measuring the total amount of calcium and magnesium present, and there are several techniques by which this can be done. Hardness is often determined by titration using an indicator that reacts with calcium and magnesium.  Another method of determining hardness is to quantitatively measure the concentrations of magnesium and calcium present using instrumental methods such as inductively coupled plasma mass spectrometry (ICP-MS) or flame atomic absorption spectrophotometry (FAAS).  We will compare both methods on the same samples.

## EDTA Titration (Week 1)

We will titrate samples using ethylene diamine-N,N,N',N'-tetraacetic acid (EDTA).  EDTA is a chelating agent that can donate electrons, thereby forming a complex with metal ions.  The EDTA will complex first with the $\ce{Ca^2+}$ and then with the $\ce{Mg^2+}$.  We will use a colorimetric indicator to determine when all of the $\ce{Ca^2+}$ and $\ce{Mg^2+}$ have complexed with the EDTA (i.e. the endpoint).  We will use a solution of Calmagite for this.  As seen in the figure below, Calmagite has acidic OH groups that can bind $\ce{Ca^2+}$ and $\ce{Mg^2+}$, which will cause the solution to have a wine-red color.  However, EDTA will bind calcium and magnesium more strongly than Calmagite.  Once enough EDTA has been added to bind all the calcium and magnesium ions and they are no longer bound to Calmagite the solution will turn blue.  Near the endpoint, the solution will appear purple, so the endpoint is often observed  at the exact point the solution turns from purple to blue.

![Molecular structure of Calmagite](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Calmagite.png/1024px-Calmagite.png)

The EPA provides [method 130.2](https://www.nemi.gov/methods/method_summary/4684/) for determination of hardness by colorimetric titration, which will be followed here.

## Instrumental Methods (Week 2)

Hardness can also be determined by measuring the concentration of magnesium and calcium using instrumental methods such as inductively coupled plasma mass spectrometry (ICP-MS) or flame atomic absorption spectrophotometry (FAAS).

# Part 0: Sample Preparation

You will need to prepare two separate samples: one for EDTA titration and one for analysis by flame atomic absorption.  Collect 1 L of tap water from wherever you usually get your drinking water and divide it into two 500-mL portions, one for each analysis.

## Sample for EDTA Titration

According to EPA Method 130.2, "For drinking waters, surface waters, saline waters, and dilutions thereof, no pretreatment steps are necessary."

## Sample for FAAS

1. Immediately upon collection, filter 500 mL of your sample through a 0.45 $\mu$m filter using a Millipore apparatus.
1. Use $\ce{HNO3}$ to acidify to the sample to pH < 2.
1. Store the sample at 4$^\circ$C until analysis (no longer than 2 weeks).

# Part 1: EDTA Titration

## Prepare the EDTA Titrant

Prepare 500 mL of EDTA titrant by weighing 1.8615 g disodium ethylenediaminetetraacetate dehydrate, also called (ethylenedinitrilo)tetraacetic acid disodium salt (EDTA).  Quantitatively transfer the EDTA solid to a 500 mL volumetric flask, being careful not to spill any of your sample.  Dilute to 500 mL with distilled water, mixing well to dissolve the EDTA.  This is the solution you will use for the following titrations.

## Blank Determination

1. Measure approximately 50 mL of deionized water into a suitable container for titration (i.e. a flask or beaker with sufficient volume to accept the titrant).
2. Add about 2 mL of odorless water hardness buffer solution (you can use a plastic pipette for this and be approximate).
3. Add about 5-6 drops of Calmagite indicator solution.
4. Titrate using the EDTA titrant.  At the end point, the color should change from red to blue.

\note{ It will likely only take **1-2 drops** to reach the end point, so go slowly with the blank!  }

5. Repeat this procedure at least two more times.
6. Average the volume of EDTA titrant used for the 3 blank determinations.  Subtract this volume from all future titrations.

## Standardize the EDTA Solution

Before using the EDTA to titrate water samples, we must know its exact concentration.  We will use a solution of calcium carbonate ($\ce{CaCO3}$) as a *primary standard* to determine the exact concentration of EDTA solution.  A stock solution of calcium carbonate will be provided in lab.

1. Measure *exactly* 10.00 mL of the $\ce{CaCO3}$ standard solution into a suitable container for titration.  Add approximately 30 mL of deionized water to the flask.
2. Add 2 mL of the buffer solution.
3. Add 5-6 drops of Calmagite indicator solution.
4. Titrate using your EDTA titrant.  At the end point, the color should change from red to blue.
5. Repeat this procedure at least two additional times.
6. Use these data and the data from part A to calculate exactly how much EDTA titrant is needed to react with 1.00 mg of $\ce{CaCO3}$.  You will use this value in your calculations to determine the water hardness.

## Titrate Your Samples

### Freshwater or Tap Water

*Most water samples can be titrated without dilution.  Try these steps first unless you are certain you are working with very hard water.*

1. Measure exactly 50 mL of the water sample into a suitable container for titration.  
2. Add 2.0 mL of the buffer solution plus 5-6 drops of indicator.
4. Titrate using the EDTA titrant.  At the end point the color should change from red to blue.
5. Repeat this procedure at least two additional times. 
6. Use this data and the data from parts A and B to calculate the hardness of your water sample in 	milligrams of $\ce{CaCO3}$ per liter. 

### Hard Water or Seawater

*Waters that are very hard or seawater may require dilution prior to tiration, and may also require a strong titrant.  Follow the steps below for such samples.*

1. Measure exactly 5.0 mL of hard water into a suitable container for titration.  Dilute 1:10 by adding 45 mL of deionized water to the flask.  Because the ocean water has a 	significantly higher concentration of $\ce{Ca^2+}$ ions, this dilution will decrease the amount of EDTA titrant required to reach the endpoint.
2. Add 2.0 mL of the buffer solution.  The remainder of the titration must be completed within 15 	minutes of the time when the buffer is added.
3. Add 4 drops of Calmagite indicator solution.
4. Titrate using the EDTA titrant.  At the end point the color should change from red to blue.
5. Repeat this procedure at least two additional times.  
6. Use this data and the data from parts A and B to calculate the hardness of your water sample in 	mg $\ce{CaCO3}$ per L.  Make sure you take into account the 1:10 dilution of your ocean water sample.  (The hardness of the ocean water will actually be 10 times the value you calculate because of the 	10-fold dilution of the water sample.)

## What to Turn In - Part 1

1. Turn in your completed Pluto notebook as an HTML file.
2. Turn in your completed Pluto notebook as a .jl file.

**Also make sure to place your acidified sample in the fridge for next week!**

# Part 2: Flame Atomic Absorption

## Prepare your standards

**Before Lab:** Calculate the expected $\ce{Mg^2+}$ and $\ce{Ca^2+}$ concentrations based on your titration results from the previous week.

\note{ If your expected concentrations are over 20 mg/L, you will need to dilute your sample prior to analysis.  The ideal range is about 5-10 mg/L. }

1. Prepare 5 standards that bracket the expected concentration (i.e. some should be lower and some should be higher).  Overall you will want to span about 1 order of magnitude in concentration.  Remember to factor in any dilutions you use!  You can use the stock provided and dilute it with deionized or ultrapure water to create your standards.

  \note{ When preparing your standards, be sure to use class A glassware and work with precision and accuracy! }

1. Place exactly 10.00 mL of your standards in **labeled** plastic 15-mL centrifuge tubes.  Make sure the tubes are labeled with your names and the concentrations of the standards!
1. Place exactly 10.00 ml of deionized water acidified to a pH < 2.
2. Add exactly 1.00 mL of lanthanum solution as a releasing agent to each tube.
   
   \note{ The releasing agent is expensive and we don't have a lot of it!  Only use the amount required! }

3. Cap your tubes and shake them to mix the releasing agent well.

## Prepare your samples

### Quality Control Sample

1. A *quality control* (QC) sample will be provided for you.
2. Place exactly 10.00 mL of the QC is a labeled plastic 15-mL centrifuge tube.  Make sure the tube is labeled with your names and the identity of the sample!
2. Add exactly 1.00 ml of lanthanum solution as a releasing agent.
3. Cap your tubes and shake them to mix the releasing agent well.

### Unknown Samples

You should analyze your filtered, acidified sample and your unfiltered sample.  We will test to see if there is a difference between the two.

\note{ If your samples are very soft you can run them without dilution.  If your samples are going to be above 10 mg/L for any analyte you should dilute them down to approximately 1-10 mg/L using deionized or ultrapure water. Make sure you keep track of the exact dilution you use! }

1. Place exactly 10.00 mL of your samples in **labeled** plastic 15-mL centrifuge tubes.  Make sure the tubes are labeled with your names and the identity of the samples!
2. Add exactly 1.00 ml of lanthanum solution as a releasing agent.
3. Cap your tubes and shake them to mix the releasing agent well.

## Analyze your samples

When your samples are ready for analysis, coordinate with your instructor to run them on the FAAS.

## What to Turn In - Part 2

1. Turn in your completed Pluto notebook as an HTML file.
2. Turn in your completed Pluto notebook as a .jl file.
3. A CSV file containing your data will be uploaded by your instructor.
