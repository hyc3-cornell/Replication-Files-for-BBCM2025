
**Determinants of Importer Launched Trade Disputes 
*Nancy Chau
*11.3.22
**********************************************

** The following reproduces Table 3 in BBCM_2025

clear all 
set more off

cd "C:\Users\hyc3\OneDrive - Cornell University\dell_backup\pctex_new\bbcm\offshoring_wto\oecd_data\replication

use "analysis_final0322.dta"

****************************************
**Table 3 
****************************************
estimates clear

label var imgrdvash "Domestic Content Share"

reghdfe tradedispute imgrdvash  if iso3cou~=iso3par, absorb(iso3cou#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "Yes"
estadd local iso3parfeyear "No"
estadd local iso3coufe "No"
estadd local iso3parfe "No"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "No"
estadd local scalepar "No"
estimates store m1

reghdfe tradedispute imgrdvash  i.iso3par if iso3cou~=iso3par, absorb(iso3cou#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "Yes"
estadd local iso3parfeyear "No"
estadd local iso3coufe "No"
estadd local iso3parfe "Yes"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "No"
estadd local scalepar "No"
estimates store m2

reghdfe tradedispute imgrdvash prodman_cou prodman_par i.iso3par if iso3cou~=iso3par, absorb(iso3cou#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "Yes"
estadd local iso3parfeyear "No"
estadd local iso3coufe "No"
estadd local iso3parfe "Yes"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "No"
estadd local scalepar "Yes"
estimates store m3

reghdfe tradedispute imgrdvash  i.year if iso3cou~=iso3par, absorb(iso3par#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "No"
estadd local iso3parfeyear "Yes"
estadd local iso3coufe "No"
estadd local iso3parfe "No"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "No"
estadd local scalepar "No"
estimates store m4

reghdfe tradedispute imgrdvash i.iso3cou  if iso3cou~=iso3par, absorb(iso3par#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "No"
estadd local iso3parfeyear "Yes"
estadd local iso3coufe "Yes"
estadd local iso3parfe "No"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "No"
estadd local scalepar "No"
estimates store m5

reghdfe tradedispute imgrdvash i.iso3cou prodman_cou prodman_par  if iso3cou~=iso3par, absorb(iso3par#year) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "No"
estadd local iso3parfeyear "Yes"
estadd local iso3coufe "Yes"
estadd local iso3parfe "No"
estadd local iso3pairfe "No"
estadd local year "No"
estadd local scalecou "Yes"
estadd local scalepar "No"
estimates store m6

reghdfe tradedispute imgrdvash i.year  if iso3cou~=iso3par, absorb(iso3pair) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "No"
estadd local iso3parfeyear "No"
estadd local iso3coufe "No"
estadd local iso3parfe "No"
estadd local iso3pairfe "Yes"
estadd local year "Yes"
estadd local scalecou "No"
estadd local scalepar "No"
estimates store m7

reghdfe tradedispute imgrdvash prodman_cou prodman_par i.year  if iso3cou~=iso3par, absorb(iso3pair) vce(robust)
estadd scalar myr2 = e(r2) 
estadd local iso3coufeyear "No"
estadd local iso3parfeyear "No"
estadd local iso3coufe "No"
estadd local iso3parfe "No"
estadd local iso3pairfe "Yes"
estadd local year "Yes"
estadd local scalecou "Yes"
estadd local scalepar "Yes"
estimates store m8
  
la var imgrdvash "Domestic Content Sh."


local coef_format "b(%9.4f) se(%9.4f) star(* .10 ** .05 *** .01)"
local tex_format " nonotes collabels(none)"
local tex_setting "label booktabs"
esttab m1 m2 m3 m4 m5 m6 m7 m8 using "tab3.tex",  replace keep(imgrdvash) ///
	scalars("iso3coufeyear Importer-year FE" "iso3parfeyear Exporter-year FE"  "iso3coufe Importer FE" "iso3parfe Exporter FE" "iso3pairfe Pair FE" "year Year FE" "scalecou Importer Manu. Prod" "scalepar Exporter Manu. Prod."  "myr2 R2" ) ///
	`coef_format' `tex_format' `tex_setting'
