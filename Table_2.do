
**Determinants of Importer Launched Trade Disputes 
*Nancy Chau
*11.3.22
**********************************************

** The following reproduces Table 2 in BBCM_2025

clear all 
set more off

cd "C:\Users\hyc3\OneDrive - Cornell University\dell_backup\pctex_new\bbcm\offshoring_wto\oecd_data\replication

use "analysis_final0322.dta"

** Capture Level and Growth Rate of the domestic content of imports -- ranking countries by manufacturing production in 1995-1997


* collapse data
drop if cou~=par
drop par prodman_par dispute_no start_year complainant respondent activedum activedum _merge* tradedispute contentdum5 contentdum3 contentdum10 iso3pair iso3par imgr imgrdva _merge_dva imgrdvash prod_par 
replace prodman_cou=. if year>=1998


bysort iso3cou: egen totalprodman_cou_1995_97 = sum (prodman_cou)
egen rankprodman_cou_1995_97=rank(prodman_cou) if year==1995
replace rankprodman_cou_1995=0 if rank==.
bysort cou: egen rank1produc_cou_1995_97 = total(rank)
drop rankpr
rename rank1produc_cou_1995_97 rankprodman_cou_1995
save "rankprodman_cou_1995_97.dta", replace

** Level and Growth domestic content of imports -- ranking countries by manufacturing production in 2016-18

clear all 

use "analysis_final0322.dta"

* collapse data
drop if cou~=par
drop par prodman_par dispute_no start_year complainant respondent activedum activedum _merge* tradedispute contentdum5 contentdum3 contentdum10 iso3pair iso3par imgr imgrdva _merge_dva imgrdvash prod_par 
replace prodman_cou=. if year<=2015


bysort iso3cou: egen totalprodman_cou_2016_18 = sum (prodman_cou)
egen rankprodman_cou_2016_18=rank(totalprodman_cou_2016_18) if year==2016
replace rankprodman_cou_2016_18=0 if rank==.
bysort cou: egen rank1produc_cou_2016_18 = total(rank)
drop rankpr
rename rank1produc_cou_2016_18 rankprodman_cou_2016_18

save "rankprodman_cou_2016_18.dta", replace


clear all 

*merge with rank data to summarize

use "analysis_final0322.dta"

merge m:1 cou year using "rankprodman_cou_1995_97.dta"
drop _merge

merge m:1 cou year using  "rankprodman_cou_2016_18.dta"
drop _merge

merge m:1 cou using "highincome_dum.dta"
drop _merge

estpost ttest imgrdvash if  year >= 2010 & par=="USA" & cou~="USA"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestusa

estpost ttest imgrdvash if  year >= 2010 & par=="JPN" & cou~="JPN"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestjpn 


estpost ttest imgrdvash if  year >= 2010 & par=="IND" & cou~="IND"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestind

estpost ttest imgrdvash if  year >= 2010 & par=="KOR" & cou~="KOR"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestkor

*Output Settings
*local coef_format "b(%9.3f star pvalue(p)) se(%9.3f) star(* .10 ** .05 *** .01)"
*local tex_format "nonotes collabels(none)"
*local tex_setting "label booktabs"
esttab ttestusa  ttestjpn ttestind ttestkor using "tabttest2.tex", replace  cells("mu_1(fmt(a3)) mu_2(fmt(a3)) p(fmt(3)) ")  ///
	mtitle("USA" "JPN" "IND" "KOR")
	`coef_format' `tex_format' `tex_setting' 

*cells("mu_1(fmt(a3)) mu_2(fmt(a3)) p_u(fmt(3)) b(fmt(3) star pvalue(p_u))")  ///


estpost ttest imgrdvash if  year >= 2010 & par=="RUS" & cou~="RUS"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestrus


estpost ttest imgrdvash if  year >= 2010 & par=="MEX" & cou~="MEX"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestmex

estpost ttest imgrdvash if  year >= 2010 & par=="BRA" & cou~="BRA"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestbra

estpost ttest imgrdvash if  year >= 2010 & par=="TWN" & cou~="TWN"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttesttwn


*Output Settings
*local coef_format "b(%9.3f) se(%9.3f) star(* .10 ** .05 *** .01)"
*local tex_format "nonotes collabels(none)"
*local tex_setting "label booktabs"
esttab ttestrus  ttestmex ttestbra ttesttwn using "tabttest2.tex", append    cells("mu_1(fmt(a3)) mu_2(fmt(a3)) p(fmt(3))")  ///
	mtitle("RUS"  "MEX" "BRA" "TWN")
	`coef_format' `tex_format' `tex_setting' 



estpost ttest imgrdvash if  year >= 2010 & par=="IDN" & cou~="IDN"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestidn


estpost ttest imgrdvash if  year >= 2010 & par=="CHN" & cou~="CHN"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestchn

estpost ttest imgrdvash if  year >= 2010 & par=="GBR" & cou~="GBR"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestgbr

estpost ttest imgrdvash if  year >= 2010 & par=="ESP" & cou~="ESP"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestesp


*Output Settings
*local coef_format "b(%9.3f) se(%9.3f) star(* .10 ** .05 *** .01)"
*local tex_format "nonotes collabels(none)"
*local tex_setting "label booktabs"
esttab ttestidn  ttestchn ttestgbr ttestesp using "tabttest2.tex", append    cells("mu_1(fmt(a3)) mu_2(fmt(a3)) p(fmt(3))")  ///
	mtitle("IDN" "CHN" "GBR" "ESP")
	`coef_format' `tex_format' `tex_setting' 


	
	
estpost ttest imgrdvash if  year >= 2010 & par=="DEU" & cou~="DEU"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestdeu

estpost ttest imgrdvash if  year >= 2010 & par=="ITA" & cou~="ITA"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestita


estpost ttest imgrdvash if  year >= 2010 & par=="FRA" & cou~="FRA"  & rankprodman_cou_2016_18> 51, by(highincome)
*esttab ., cells("mu_1 mu_2 p") 
estimates store ttestfra

*Output Settings
*local coef_format "b(%9.3f) se(%9.3f) star(* .10 ** .05 *** .01)"
*local tex_format "nonotes collabels(none)"
*local tex_setting "label booktabs"
esttab ttestdeu  ttestita ttestfra   using "tabttest2.tex", append    cells("mu_1(fmt(a3)) mu_2(fmt(a3)) p(fmt(3))")  ///
	mtitle("DEU" "ITA" "FRA" )
	`coef_format' `tex_format' `tex_setting' 
	
	