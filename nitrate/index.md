+++
title = "Experiment 2: Standardization - Nitrate"
+++


Nitrate Determination
=========================

\toc

# Background

Nitrate-nitrogen may be present in small amounts in fresh domestic wastewater.  However, it is seldom found in influents to treatment plants because the nitrate serves as an oxygen source in the biologically unstable wastewater.  On the other hand, nitrate is often found in the effluents of biological treatment plants, because it represents the final form of nitrogen from the oxidation of organic nitrogen compounds.  Trickling-filter and activated sludge treatment plant effluents may contain from 0 to 50 mg/L nitrate, depending on the total nitrogen content of the influent, the degree of loading, and the temperature of the sewage.

Nitrate may also be found in river water, lake water, and most importantly in ground water.  The nitrate may originate from sewage, or in rural areas, it may be produced by fertilizer or barnyard runoff.  The U.S. Public Health Service designated safe limit for nitrate in water is 45 ppm nitrate or 10 ppm nitrate-nitrogen.  Nitrate in drinking water is particularly dangerous to small children, infants, and unborn fetuses.

This experiment uses commercially-available reagents, but is similar to [EPA method 353.3](https://www.nemi.gov/methods/method_summary/5251/).  More information can be found on the [EPA web archive](https://archive.epa.gov/water/archive/web/html/vms57.html).

## Absorption Spectroscopy (Colorimetric Method)

In this experiment, nitrate will be determined spectrophotometrically using the Vernier SpectroVis.  Spectrophometry is a commonly used method to determine aqueous anions.  The fundamentals of absorption spectrophotometry are shown below.  A light source shines light through a sample cell (a cuvette) and onto a detection system, which serves to convert the light into an electric signal (Figure 1).  The basic idea is that as the concentration of the colored complex increases in the cuvette, we would expect less light to be transmitted to the detection system.  Hence, we are interested in the absorption of light by the sample:

![Schematic of absorption spectroscopy](absorption_spectroscopy.png)

Methods that use visible light to detect the analyte are called **colorimetric** methods.

## Standardization

A series of solutions is prepared with a known amount of analyte (standards) and the absorbance is measured on the Vernier SpectroVis.  A graph is then prepared of absorbance (y-axis) versus concentration (x-axis).  This graph is called a standard curve or calibration curve.  The calibration curve will be used to develop a quantitative relationship between concentration and absorbance.  Then absorbance will be measured for the water samples, and the graph will be used to calculate the concentration of analyte in the samples.  A generalized example is shown below in Figure 2.

```julia:nitrate-fig2
using Plots # hide
scatter(0.5:1:5, [1, 3, 5, 7, 9] .+ rand(-0.2:0.1:0.2, 5), # hide
	legend = false, # hide
	markersize = 8, # hide
	border = :box, grid = false, # hide
	xtickfontsize=14, ytickfontsize=14, xguidefontsize=14, yguidefontsize=14 # hide
	) # hide
xlabel!("Concentration"); ylabel!("Signal") # hide
xlims!(0, 6); ylims!(0, 10) # hide
Plots.abline!(2, 0, color = 1, linewidth = 3, linestyle= :dash) # hide
savefig(joinpath(@OUTPUT, "nitrate-cal.svg")) # hide
```
\fig{nitrate-cal}

# Procedure

The notebook template for this lab can be found on [GitHub](https://raw.githubusercontent.com/chem330/chem330.github.io/main/nitrate/nitrate-notebook.jl).

## Standard Preparation

**A ~500-mg L$^{-1}$ NO$_3^-$ stock solution has been prepared for you.**

1. Prepare a ~10-ppm nitrate intermediate stock solution using the 500-ppm stock solution provided.  You will need about 50 ml of this solution.
2. Using your intermediate stock solution, prepare 5 standards with concentrations ranging from (approximately) 0--10 mg L$^{-1}$.  Make 25 mL of each solution, and remember that $C_1V_1 = C_2V_2$.

## Determination of Nitrate

### SpectroVis Usage

1. If you haven't already, download [Vernier Spectral Analysis](https://www.vernier.com/product/spectral-analysis/) and install it on your computer.
1. Open the Spectral Analysis software and expand the **Absorbance** mode menu.  From there, choose **Absorbance vs. Wavelength**.
1. Allow the lamp to automatically warm up for 90 seconds (do not skip). 
1. When the 90 seconds has passed, insert a cuvette containing your blank (DI water) into the spectrometer and click **Finish Calibration**.  (This step appears to set the integration time of the spectrophotometer -- it does not actually calibrate it or measure the sample.)
1. Leave the spectrometer turned in and warming up while you complete "Sample Color Development" below.

### Sample Color Development

The following procedure should be performed on each of your 5 calibration standards and each of your water samples.

1. Place 25 mL of each standard and sample into separate 50-mL beakers or Erlenmeyer flasks.
2. Create a blank with 25 mL of deionized water.
3. Add the contents of one NitraVer5 Nitrate reagent packet to each sample.  **Be careful!**  There is Cd metal in the reagent packet, so the contents of the reagent packet are toxic.  Wear gloves, goggles, and avoid inhaling the reagent powder.  Be careful about what you touch with your gloves.
4. Swirl each flask vigorously for 1 minute.  Wait at least 5 minutes, but no longer than 15 minutes before reading the absorbance of each sample.

### Determination of Nitrate

**Follow the guidelines listed directly below when measuring your solutions!**

   - Use a plastic pipette to transfer solutions, making sure not to transfer any of the particulate matter left from the NitraVer reaction!
   - Always work from lowest concentration to highest concentration to avoid cross-contamination!
   - Make sure to measure each standard once and each sample three times!
   - Use the same cuvette for all solutions and orient it the same way for each measurement!
   - Make sure to rinse the cuvette 3 times with DI water between each measurement!
   - Make sure to record the instrument parameters (measurement wavelength) and your measurements in your notebook!

1. Use a plastic pipette to transfer some of your blank into the cuvette and press **Collect** at the top of the Spectral Analysis window.  You should see a relatively flat line centered around 0.  If your line is not centered around 0 or has big features present, you need to re-do the blank measurement/Calibration (under the Settings menu).
2. When you are satisfied with your spectrum press **Stop**.  You can now use the **...** icon at the top of the tabular data to rename the spectrum if you want.
2. Repeat the above 2 steps for every standard, sample, blank, and QC (see "Determination of Nitrate" for additional instructions).
3. Once complete, select the wavelength of maximum absorbance $(\lambda_{max})$ by clicking on the spectrum with the mouse. (It is typically close to 500 nm for NitraVer.)
4. Record the absorbance values at $\lambda_{max}$ for all solutions.

1. After measuring the absorbance of the standards, make a plot of absorbance versus concentration as described by your instructor using Excel.  Add a trendline to your graph with the intercept set to zero and add the equation for the trendline and the $R^2$ value to your graph.  Label the $x$- and $y$-axes, including units for the concentration.  Use the equation of the trendline to determine the nitrate concentration in the samples.
   
## What to Turn In

1. Upload the .jl and .html versions of your completed notebook to the assignment for this experiment on Canvas.
