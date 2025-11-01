
**Determinants of Importer Launched Trade Disputes 
*Nancy Chau
*11.3.22
**********************************************

** The following reproduces Table 1 in BBCM_2025


clear all 
set more off

cd "C:\Users\hyc3\OneDrive - Cornell University\dell_backup\pctex_new\bbcm\offshoring_wto\oecd_data\replication

use "analysis_final0322.dta"

****************************************
**Table 1 Summary Statics
****************************************
estimates clear

format tradedispute imgrdvash contentdum* %9.3g
estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, statistics(mean sd N) 
estimates store s0


estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, by(contentdum1) statistics(mean sd N) 
estimates store s1

estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, by(contentdum3) statistics(mean sd N) 
estimates store s2

estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, by(contentdum5) statistics(mean sd N) 
estimates store s3

estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, by(contentdum7) statistics(mean sd N) 
estimates store s4

estpost tabstat tradedispute imgrdvash if iso3cou~=iso3par, by(contentdum10) statistics(mean sd N) 
estimates store s5

la var imgrdvash "Domestic Content Share"
la var tradedispute "Trade Dispute Incidence"


local coef_format "b(%9.4f) se(%9.4f) star(* .10 ** .05 *** .01)"
local tex_format " nonotes collabels(none)"
local tex_setting "label booktabs"
esttab s0 s1 s2 s3 s4 s5 using "tabsum1.tex", cells(tradedispute(fmt(4)) imgrdvash(fmt(4))) label replace 
