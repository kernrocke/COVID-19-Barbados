

clear
capture log close
cls


**  GENERAL DO-FILE COMMENTS
**  Program:		covid_BB_001.do
**  Project:      	COVID-19 Barbados Project
**	Sub-Project:	SES and Well-Being in Barbados
**  Analyst:		Kern Rocke
**	Date Created:	13/12/2020
**	Date Modified: 	13/12/2020
**  Algorithm Task: Data managment and preliminary analysis


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150


*Setting working directory

*-------------------------------------------------------------------------------
** Dataset to encrypted location

*MAC OS
local datapath "/Users/kernrocke/OneDrive - The University of the West Indies/Manuscripts/COVID Barbados"

*-------------------------------------------------------------------------------

** Logfiles to unencrypted location

*MAC OS
local logpath "/Users/kernrocke/OneDrive - The University of the West Indies/Manuscripts/COVID Barbados"

*-------------------------------------------------------------------------------

**Aggregated output path

*MAC OS
local outputpath "/Users/kernrocke/OneDrive - The University of the West Indies/Manuscripts/COVID Barbados"

*-------------------------------------------------------------------------------

*Load in data
use "`datapath'/Data/Covid_Evaulating_Impact_002.dta", clear

/*
Data related to the evaluation was described using univariate analyses such as 
frequencies (n) and percentages (%) for categorical variables, while means and 
standard deviations were used to describe continuous variables. This evaluation 
used a  cross-sectional study design, which does not describe cause and effect 
relationships, however preliminary associations and correlations were done via 
the use of Pearson Chi Squared tests, Pearson Correlation tests and multivariate 
regressions. Associations of interest included ones between demographic and 
socioeconomic status with QoL and health status, livelihoods, and mental health. 
A p-value of <0.05 was considered statistically significant.

Additionally, all 14 variables within the HADS were coded numerically and 
reversed coded where relevant (Annex 3) and summed horizontally to determine 
the number of persons within the sample, categorised as clinically depressed 
(borderline cases and cases). The Cronbach's alpha was used to measure the 
internal consistency of the HADS, with a reliability coefficient of ³0.70 
denoting relatively high internal consistency. All data was analysed using 
Stata (version 15, StataCorp, College Station, TX, USA).

*/

*-------------------------------------------------------------------------------

*Income category
gen income_cat = .
replace income_cat = 1 if how_much_do_you_make == 1 | how_much_do_you_make == 2 // low income <2000
replace income_cat = 2 if how_much_do_you_make == 3 | how_much_do_you_make == 4 // middle income 2000-5000
replace income_cat = 3 if how_much_do_you_make == 5 | how_much_do_you_make == 6 // hight income >5000
label var income_cat "Monthly Income Categories"
label define income_cat 1"Low income" 2"Middle income" 3"High income"
label value income_cat income_cat

*Occupation (Employed and student)
gen occupation = .
replace occupation = 1 if during_covid_employment == 1 | during_covid_employment == 2 | during_covid_employment == 3
replace occupation = 2 if during_covid_employment == 4
label var occupation "Occupation"
label define occupation 1"Employed" 2"Student"
label value occupation occupation

*QOL score
egen QOL = rowtotal(would_you_say_that_in_gene now_thinking_about_your_ph now_thinking_about_your_ph_2)
label var QOL "Quality of Life Scores"

*MENTAL HEALTH

*Examine the internal consistency of the HADS scale

**Check for the level of missing data for HADS variables
misstable sum i_feel_restless_as_i_have - i_can_enjoy_a_good_book_or

**Create HADS score (Hospital Anxiety Depression Scale)
egen HADS = rowtotal(i_feel_restless_as_i_have - i_can_enjoy_a_good_book_or)
label var HADS "HADS"

sum HADS, detail
alpha i_feel_restless_as_i_have - i_can_enjoy_a_good_book_or, detail

*HADS category
gen HADS_cat = .
replace HADS_cat = 1 if HADS<=7 & HADS!=.
replace HADS_cat = 2 if HADS>=8 & HADS<=10 & HADS!=.
replace HADS_cat = 3 if HADS>=11 & HADS!=.

label var HADS_cat "HADS categories"
label define HADS_cat 1"Normal" 2"Borderline" 3"Case"
label value HADS_cat HADS_cat


cls
*-------------------------------------------------------------------------------
*Open log file to store results
log using "`logpath'/Log/covid_BB_001.log",  replace

*-------------------------------------------------------------------------------

*DEMOGRAPHICS (TABLE 1)
tab gender
tab age
tab residence_status
tab what_is_the_ethnicity_that 
tab do_you_normally_attend_fai
tab what_is_your_relationship
tab occupation

*-------------------------------------------------------------------------------

*SES (TABLE 2)
tab what_is_your_highest_level
tab how_much_do_you_make 
tab did_your_household_income 
tab the_main_income_earner_bre 
tab what_has_been_your_househo 
tab what_has_been_your_househo_2

*-------------------------------------------------------------------------------

*Quality of Life (TABLE 3)
tab would_you_say_that_in_gene 
tab now_thinking_about_your_ph 
tab now_thinking_about_your_ph_2 
tab do_ypu_think_that_poor_phy 
tab are_you_limited 
tab what_is_the_major_impairme 
tab were_this_issues_exacerbat

*-------------------------------------------------------------------------------

*Livelihood (TABLE 4)
tab was_your_ability_to_secure
mrtab reasons_disruptions___1 - how_do_you_expect_your_liv

*-------------------------------------------------------------------------------

*Mental Health (TABLE 5)
sum HADS
tab1 i_feel_restless_as_i_have - i_can_enjoy_a_good_book_or
tab HADS_cat

*-------------------------------------------------------------------------------

*Association between demographics and SES (TABLE 6)
**Income
tab gender income_cat, col chi2
tab age income_cat, col chi2
tab residence_status income_cat, col chi2
tab what_is_the_ethnicity_that income_cat, col chi2
tab do_you_normally_attend_fai income_cat, col chi2
tab what_is_your_relationship income_cat, col chi2

**Education
tab gender what_is_your_highest_level, col chi2
tab age what_is_your_highest_level, col chi2
tab residence_status what_is_your_highest_level, col chi2
tab what_is_the_ethnicity_that what_is_your_highest_level, col chi2
tab do_you_normally_attend_fai what_is_your_highest_level, col chi2
tab what_is_your_relationship what_is_your_highest_level, col chi2

*-------------------------------------------------------------------------------

*Associations between livelihoods and SES (TABLE 7)

**Income
tab was_your_ability_to_secure income_cat, col chi2

**Education
tab was_your_ability_to_secure what_is_your_highest_level, col chi2

*-------------------------------------------------------------------------------

*Associations between QOL and SES (TABLE 8)

**Income
tab would_you_say_that_in_gene income_cat, col chi2
tab now_thinking_about_your_ph income_cat, col chi2
tab now_thinking_about_your_ph_2 income_cat, col chi2
spearman QOL income_cat, stats(rho p)
oneway QOL income_cat, tab

**Education
tab would_you_say_that_in_gene what_is_your_highest_level, col chi2
tab now_thinking_about_your_ph what_is_your_highest_level, col chi2
tab now_thinking_about_your_ph_2 what_is_your_highest_level, col chi2
spearman QOL what_is_your_highest_level, stats(rho p)
oneway QOL what_is_your_highest_level, tab

*-------------------------------------------------------------------------------

*Associations between Mental Health and SES (Table 9)

**Income
tab HADS_cat income_cat, col chi2
spearman HADS income_cat, stats(rho p)
oneway HADS income_cat, tab

**Education
tab HADS_cat what_is_your_highest_level, col chi2
spearman HADS what_is_your_highest_level, stats(rho p)
oneway HADS what_is_your_highest_level, tab

*-------------------------------------------------------------------------------

*Close log file
log close

*-------------------------------------------------------------------------------

*Graph Preparations

tab i_normally_live_in, gen(normal_live_)
tab residence_restrictions, gen(lockdown_live_)
tab i_currently_live_in, gen(current_live_)

forval x = 1(1)11 {

gen move_lockdown_`x' = normal_live_`x' - lockdown_live_`x' 
recode move_lockdown_`x' (-1=1)
label define move_lockdown_`x' 0"Stayed" 1"Moved"
label value move_lockdown_`x' move_lockdown_`x'

gen current_new_`x' = normal_live_`x' - current_live_`x'
recode current_new_`x' (-1=1)
label value current_new_`x' move_lockdown_`x'

/*Convert to percentages
replace move_lockdown_`x' = move_lockdown_`x'*100
replace current_`x' = current_`x' *100
*/
}

egen move = rowtotal(move_lockdown_*)
recode move (2=1)
replace move = move*100

egen current = rowtotal(current_new_*)
recode current (2=1)
replace current = current*100

gen diff = before_covid_employment - during_covid_employment

gen new = .
sort diff
replace new = 1 in 2
replace new = 1 in 3
replace new = 1 in 4
replace new = 1 in 5
replace new = 1 in 6
replace new = 2 in 7
replace new = 1 in 8
replace new = 2 in 9
replace new = 2 in 10
replace new = 2 in 11
replace new = 3 in 12
replace new = 2 in 13
replace new = 2 in 14
sort diff during_covid_employment
replace new = 4 in 174
replace new = 4 in 175
replace new = 4 in 176
replace new = 4 in 177
replace new = 4 in 178
replace new = 4 in 179
replace new = 4 in 180
replace new = 4 in 181
replace new = 4 in 182
replace new = 4 in 183
replace new = 4 in 184
replace new = 4 in 185
replace new = 4 in 186
replace new = 4 in 187
replace new = 4 in 188
replace new = 3 in 189
replace new = 3 in 190
replace new = 3 in 191
replace new = 3 in 192
replace new = 3 in 193
replace new = 2 in 194
replace new = 4 in 195
replace new = 4 in 196
replace new = 3 in 197

gen still = .
replace still = 1 if diff == 0
replace still = 0 if diff!=. & diff!=0

gen unemploy = .
replace unemploy = 1 if new == 1
replace unemploy = 0 if new !=1 & diff !=.

gen self_employ = .
replace self_employ = 1 if new == 2
replace self_employ = 0 if new !=2 & diff !=.

gen full_employ = .
replace full_employ = 1 if new == 3
replace full_employ = 0 if new !=3 & diff !=.

gen part_employ = .
replace part_employ = 1 if new == 4
replace part_employ = 0 if new !=4 & diff !=.

*Convert to percentages
replace still = still*100
replace unemploy = unemploy*100
replace self_employ = self_employ*100
replace full_employ = full_employ*100
replace part_employ = part_employ*100

*Set graph font to Times New Roman"
graph set window fontface "Times New Roman"

*-------------------------------------------------------------------------------

**FIGURE 1
#delimit;

	graph hbar (mean) move current
	
	, 
	
	 over(i_normally_live_in)
	 plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
     graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
     bgcolor(white) 
	 
	 bar(1, bc(green*0.65) blw(vthin) blc(gs0))
	 bar(2, bc(blue*0.65) blw(vthin) blc(gs0))
	 
	 blabel(bar, format(%9.0f) pos(outside) size(small))
	 bargap(20)
	 
	 ylab(, nogrid )
	 ytitle("Percentage (%)", margin(t=0.5) size(medium)) 
	 
	 legend(size(medium)  cols(2)
				region(fcolor(gs16) lw(vthin) margin(l=2 r=2 t=2 b=2)) 
				order(1 2 )
				lab(1 "Moved during lockdown")
				lab(2 "Currently moved")
				
				)
				
	name(figure_1)
	
	;
#delimit cr

*Export graph
graph export "`outputpath'/Figures/figure_1.png", replace as(png)

*-------------------------------------------------------------------------------

**FIGURE 2
#delimit;
		
	graph hbar if occupation == 1 & if_you_have_been_asked_to !=3
	
	, 
	
	over(if_you_have_been_asked_to, relabel (1"Can work from home"
											 2"Unable to work from home"))

	plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
    graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
    bgcolor(white) 
	
    bar(1, bc(khaki*0.65) blw(vthin) blc(gs0))
	blabel(bar, format(%9.0f) pos(outside) size(small))
	
    ylab(20(10)70, nogrid )
	ytitle("Percentage (%)", margin(t=0.5) size(medium)) 
	yscale(range(20 70))
	
	title("Employed", c(black) size(medium))
	
	saving("`datapath'/Figures/figure2a", replace)
	name(figure2a)

	;
#delimit cr

*-------------------------------------------------------------------------------
#delimit;
		
	graph hbar if occupation == 2 
	
	, 
	
	over(if_you_have_been_asked_to_2, relabel (1"Can study from home"
											 2"Unable to study from home"))

	plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
    graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
    bgcolor(white) 
	
    bar(1, bc(khaki*0.65) blw(vthin) blc(gs0))
	blabel(bar, format(%9.0f) pos(outside) size(small))
	
    ylab(20(10)70, nogrid )
	ytitle("Percentage (%)", margin(t=0.5) size(medium)) 
	yscale(range(20 70))
	
	title("Students", c(black) size(medium))
	
	saving("`datapath'/Figures/figure2b", replace)
	name(figure2b)

	;
#delimit cr

*-------------------------------------------------------------------------------

#delimit;

		graph combine
		"`datapath'/Figures/figure2a"
		"`datapath'/Figures/figure2b"
		
		,
		
		plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
		graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
		
		name(figure_2)
			;
#delimit cr

*Export graph
graph export "`outputpath'/Figures/figure_2.png", replace as(png)

*-------------------------------------------------------------------------------

**FIGURE 3

#delimit; 
		graph bar (mean) still full_employ part_employ self_employ unemploy 
		if before_covid_employment !=7
		
		, 
		over(before_covid_employment, relabel (1"Part-time job"
											   2"Full-time job"
											   3"Self-employed"
											   4"Student"
											   5"Retired"))
											
	 plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
     graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
     bgcolor(white) 
	 
	 bar(1, bc(green*0.65) blw(vthin) blc(gs0))
	 bar(2, bc(blue*0.65) blw(vthin) blc(gs0))
	 bar(3, bc(brown*0.65) blw(vthin) blc(gs0))
	 bar(4, bc(teal*0.65) blw(vthin) blc(gs0))
	 bar(5, bc(red*0.65) blw(vthin) blc(gs0))
	 
	 blabel(bar, format(%9.0f) pos(outside) size(small))
	 bargap(20)
	 
	 ylab(, nogrid )
	 ytitle("Percentage (%)", margin(t=0.5) size(medium)) 
	 
	 legend(size(medium)  cols(2)
				region(fcolor(gs16) lw(vthin) margin(l=2 r=2 t=2 b=2)) 
				order(1 2 3 4 5)
				lab(1 "Same occupation")
				lab(2 "Full-time job")
				lab(3 "Part-time job")
				lab(4 "Self-employed")
				lab(5 "Unemployed")
				)
				
	name(figure_3)																																		 
;
#delimit cr																																			 

*Export graph
graph export "`outputpath'/Figures/figure_3.png", replace as(png)

*-------------------------------------------------------------------------------




