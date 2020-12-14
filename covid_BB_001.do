
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

**Aggregated outputpath

*MAC OS
local outputpath "/Users/kernrocke/OneDrive - The University of the West Indies/Manuscripts/COVID Barbados"

*-------------------------------------------------------------------------------

*Open log file to store results
log using "`logpath'/Log/covid_BB_001.log",  replace

*-------------------------------------------------------------------------------

*Load in csv data export from redcap
import delimited record_id redcap_survey_identifier participant_informat_v_0 ///
				 consent participant_informat_v_1 covid19_impact_on_so_v_2 age ///
				 residence_status gender what_is_your_relationship ///
				 i_currently_live_in i_normally_live_in residence_restrictions ///
				 what_is_your_highest_level what_is_the_ethnicity_that ///
				 do_you_normally_attend_fai restrictions_worship ///
				 i_was_unable_to_continue_b before_covid_employment ///
				 during_covid_employment if_you_have_been_asked_to ///
				 if_you_have_been_asked_to_2 how_much_do_you_make ///
				 did_your_household_income did_you_lose_your_job_or_c ///
				 the_main_income_earner_bre what_has_been_your_househo ///
				 what_has_been_your_househo_2 home_owning_status ///
				 are_you_the_parent_or_guar___1 are_you_the_parent_or_guar___2 ///
				 are_you_the_parent_or_guar___3 are_you_the_parent_or_guar___4 ///
				 are_you_the_parent_or_guar___5 are_you_the_parent_or_guar___6 ///
				 are_you_the_parent_or_guar___7 are_you_the_parent_or_guar___8 ///
				 how_many_children_are_in_y how_many_persons_are_there ///
				 has_the_impacts_pof_covid how_long_would_you_be_able ///
				 are_you_currently_caring_f are_you_an_essential_worke ///
				 do_you_feel_like_you_are_a was_your_ability_to_secure ///
				 reasons_disruptions___1 reasons_disruptions___2 ///
				 reasons_disruptions___3 reasons_disruptions___4 ///
				 reasons_disruptions___5 reasons_disruptions___6 ///
				 reasons_disruptions___7 reasons_disruptions___8 ///
				 reasons_disruptions___9 reasons_disruptions___10 ///
				 reasons_disruptions___11 how_do_you_expect_your_liv ///
				 would_you_say_that_in_gene now_thinking_about_your_ph ///
				 now_thinking_about_your_ph_2 do_ypu_think_that_poor_phy ///
				 are_you_limited what_is_the_major_impairme ///
				 were_this_issues_exacerbat i_feel_tense_or_wound_up ///
				 i_get_a_sort_of_frightened frightened_2 ///
				 i_feel_restless_as_i_have worrying_thoughts_go_throu ///
				 feel_panic feel_ease feel_sloweddown ///
				 i_still_enjoy_the_things_i lost_interest_appearance ///
				 i_can_laugh_and_see_the_fu i_look_forward_with_enjoym ///
				 i_feel_cheerful i_can_enjoy_a_good_book_or ///
				 covid19_impact_on_so_v_3 using "`datapath'/Data/EvaluatingTheImpactO_DATA_NOHDRS_2020-12-13_0105.csv", varnames(nonames)
				 
label data "EvaluatingTheImpactO_DATA_NOHDRS_2020-12-13_0105.csv"

label define consent_ 0 "No, I do not wish to continue with this survey" 1 "Yes, I would like to continue with this survey" 
label define participant_informat_v_1_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define age_ 1 "18-24" 2 "24-34" 3 "35-44" 4 "45-54" 5 "55-64" 6 "65-74" 7 "75-84" 8 "85+" 
label define residence_status_ 1 "I am a citizen or perminant residant" 2 "I work or study in Barbados" 3 "I am a visitor" 
label define gender_ 1 "Male" 2 "Female" 3 "Transmale" 4 "Transfemale" 5 "Non-binary" 6 "Gender neutral" 7 "Other" 
label define what_is_your_relationship_ 1 "Single" 2 "Married" 3 "Common-law" 4 "Widowed" 5 "Divorced" 6 "In a partnership" 7 "Other" 
label define i_currently_live_in_ 1 "St. Lucy" 2 "St. Peter" 3 "St. Andrew" 4 "Christ Church" 5 "St. George" 6 "St. Phillip" 7 "St. James" 8 "St. Michael" 9 "St. Joseph" 10 "St. Thomas" 11 "St. John" 
label define i_normally_live_in_ 1 "St. Lucy" 2 "St. Peter" 3 "St. Andrew" 4 "Christ Church" 5 "St. George" 6 "St. Phillip" 7 "St. James" 8 "St. Michael" 9 "St. Joseph" 10 "St. Thomas" 11 "St. John" 
label define residence_restrictions_ 1 "St. Lucy" 2 "St. Peter" 3 "St. Andrew" 4 "Christ Church" 5 "St. George" 6 "St. Phillip" 7 "St. James" 8 "St. Michael" 9 "St. Joseph" 10 "St. Thomas" 11 "St. John" 
label define what_is_your_highest_level_ 1 "Primary (Elementary)" 2 "Secondary (High)" 3 "Tertiary (Degrees, Diplomas)" 
label define what_is_the_ethnicity_that_ 1 "African (Black)" 2 "Asian (Indian, Chinese)" 3 "Mixed" 4 "Other (i.e. Caucasian (White))" 
label define do_you_normally_attend_fai_ 1 "Yes" 0 "No" 
label define restrictions_worship_ 1 "I was unable to continue" 2 "I attended online sessions" 3 "I engaged in personal worship" 4 "Other" 
label define i_was_unable_to_continue_b_ 1 "There were no alternatives (online sessions)" 2 "There were online sessions, I did not want to attend because I did not know how to join" 3 "There were online sessions, I could not attend because I did not have access to the internet or a device" 4 "Other" 
label define before_covid_employment_ 1 "I was employed part time (20 hours or less weekly)" 2 "I was employed full time (40 hours or more weekly)" 3 "I was self employed" 4 "I was a full time student" 5 "I was unemployed" 6 "Retired" 7 "Other" 
label define during_covid_employment_ 1 "I am employed part time (20 hours or less weekly)" 2 "I am employed full time (40 hours or more weekly)" 3 "I am self employed" 4 "I am a full time student" 5 "I am unemployed" 6 "Retired" 7 "Other" 
label define if_you_have_been_asked_to_ 1 "Yes" 2 "No" 3 "Not applicable" 
label define if_you_have_been_asked_to_2_ 1 "Yes" 2 "No" 3 "Not applicable" 
label define how_much_do_you_make_ 1 "Less than $1,000BDS" 2 "$1,000BDS - $2,000BDS" 3 "$2,001BDS - $3,000BDS" 4 "$3,001BDS - $5,000BDS" 5 "$5,001BDS - $10,000BDS" 6 "More than $10,000BDS" 
label define did_your_household_income_ 1 "Decreased working hours or decreased salaries / revenues." 2 "Increased working hours or increased salaries / revenues." 3 "Resorted to secondary / alternative source of income to maintain income levels" 4 "No change" 
label define did_you_lose_your_job_or_c_ 1 "Yes" 2 "No" 
label define the_main_income_earner_bre_ 1 "Myself" 3 "My mother" 2 "My father" 4 "My spouse / partner" 5 "My sibling" 6 "Other family member" 7 "Non family member" 
label define what_has_been_your_househo_ 1 "Salaried work with regular income" 2 "Daily / casual labour" 3 "Own business / trade" 4 "Petty trade / selling on street" 5 "Remittances from abroad" 6 "Support from families and friends" 7 "Government assistance / social safety nets" 8 "Assistance from UN/NGO/charity" 9 "Other" 
label define what_has_been_your_househo_2_ 1 "Salaried work with regular income" 2 "Daily / casual labour" 3 "Own business / trade" 4 "Petty trade / selling on street" 5 "Remittances from abroad" 6 "Support from families and friends" 7 "Government assistance / social safety nets" 8 "Assistance from UN/NGO/charity" 9 "Other" 
label define home_owning_status_ 1 "I am a home owner" 2 "I am renting" 3 "I live rent free" 4 "Other" 
label define are_you_the_parent_or_guar___1_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___2_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___3_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___4_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___5_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___6_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___7_ 0 "Unchecked" 1 "Checked" 
label define are_you_the_parent_or_guar___8_ 0 "Unchecked" 1 "Checked" 
label define has_the_impacts_pof_covid_ 1 "Yes" 0 "No" 
label define how_long_would_you_be_able_ 1 "Less than 3 months" 2 "3 months - 6 months" 3 "7 months - 1 year" 4 "More than 1 year" 
label define are_you_currently_caring_f_ 1 "Yes" 0 "No" 
label define are_you_an_essential_worke_ 1 "Yes" 0 "No" 
label define do_you_feel_like_you_are_a_ 1 "Yes" 0 "No" 
label define was_your_ability_to_secure_ 1 "Yes" 0 "No" 
label define reasons_disruptions___1_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___2_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___3_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___4_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___5_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___6_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___7_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___8_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___9_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___10_ 0 "Unchecked" 1 "Checked" 
label define reasons_disruptions___11_ 0 "Unchecked" 1 "Checked" 
label define how_do_you_expect_your_liv_ 1 "Little to no impact" 2 "Some impact" 3 "Moderate impact" 4 "Moderate to severe impact" 5 "Severe impact" 
label define would_you_say_that_in_gene_ 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 
label define now_thinking_about_your_ph_ 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor" 
label define now_thinking_about_your_ph_2_ 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor" 
label define do_ypu_think_that_poor_phy_ 1 "Yes" 0 "No" 
label define are_you_limited_ 1 "Yes" 2 "No" 3 "Not sure" 4 "Prefer not to say" 
label define what_is_the_major_impairme_ 1 "Hypertension" 2 "Diabetes" 3 "Heart Disease" 4 "Cancer" 5 "Asthma" 6 "Chronic Kidney / Renal Disease" 7 "Sight / Hearing Challenges" 8 "Other" 
label define were_this_issues_exacerbat_ 1 "Yes" 0 "No" 
label define i_feel_tense_or_wound_up_ 0 "Not at all" 1 "From time to time occasionally" 2 "Alot of the time" 3 "Most of the time" 
label define i_get_a_sort_of_frightened_ 0 "Not at all" 1 "Occasionally" 2 "Quite often" 3 "Very often" 
label define frightened_2_ 0 "Not at all" 1 "A little, but it does not worry me" 2 "Yes, but not to badly" 3 "Definitely and quite badly" 
label define i_feel_restless_as_i_have_ 0 "Not at all" 1 "Not very much" 2 "Quite a lot" 4 "Very much indeed" 
label define worrying_thoughts_go_throu_ 0 "Only occasionally" 1 "From time to time but not too often" 2 "A lot of the time" 3 "A great deal of the time" 
label define feel_panic_ 0 "Not at all" 1 "Not very often" 2 "Quite often" 3 "Very often indeed" 
label define feel_ease_ 0 "Definitely" 1 "Usually" 2 "Not often" 3 "Not at all" 
label define feel_sloweddown_ 0 "Not at all" 1 "Sometimes" 2 "Very often" 3 "Nearly all the time" 
label define i_still_enjoy_the_things_i_ 0 "Definitely as much" 1 "Not quite so much" 2 "Only a little" 3 "Hardly at all" 
label define lost_interest_appearance_ 0 "I take just as much care as ever" 1 "I may not take quite as much care" 2 "I dont take as much care as I should" 3 "Definitely" 
label define i_can_laugh_and_see_the_fu_ 0 "As much as I always could" 1 "Not quite so much now" 2 "Definitely not so much now" 3 "Not at all" 
label define i_look_forward_with_enjoym_ 0 "As much as I ever did" 1 "Rather less than I used to" 2 "Definitely less than I used to" 3 "Hardly at all" 
label define i_feel_cheerful_ 0 "Most of the times" 1 "Sometimes" 2 "Not often" 3 "Not at all" 
label define i_can_enjoy_a_good_book_or_ 0 "Often" 1 "Sometimes" 2 "Not often" 3 "Very seldom" 
label define covid19_impact_on_so_v_3_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 

label values consent consent_
label values participant_informat_v_1 participant_informat_v_1_
label values age age_
label values residence_status residence_status_
label values gender gender_
label values what_is_your_relationship what_is_your_relationship_
label values i_currently_live_in i_currently_live_in_
label values i_normally_live_in i_normally_live_in_
label values residence_restrictions residence_restrictions_
label values what_is_your_highest_level what_is_your_highest_level_
label values what_is_the_ethnicity_that what_is_the_ethnicity_that_
label values do_you_normally_attend_fai do_you_normally_attend_fai_
label values restrictions_worship restrictions_worship_
label values i_was_unable_to_continue_b i_was_unable_to_continue_b_
label values before_covid_employment before_covid_employment_
label values during_covid_employment during_covid_employment_
label values if_you_have_been_asked_to if_you_have_been_asked_to_
label values if_you_have_been_asked_to_2 if_you_have_been_asked_to_2_
label values how_much_do_you_make how_much_do_you_make_
label values did_your_household_income did_your_household_income_
label values did_you_lose_your_job_or_c did_you_lose_your_job_or_c_
label values the_main_income_earner_bre the_main_income_earner_bre_
label values what_has_been_your_househo what_has_been_your_househo_
label values what_has_been_your_househo_2 what_has_been_your_househo_2_
label values home_owning_status home_owning_status_
label values are_you_the_parent_or_guar___1 are_you_the_parent_or_guar___1_
label values are_you_the_parent_or_guar___2 are_you_the_parent_or_guar___2_
label values are_you_the_parent_or_guar___3 are_you_the_parent_or_guar___3_
label values are_you_the_parent_or_guar___4 are_you_the_parent_or_guar___4_
label values are_you_the_parent_or_guar___5 are_you_the_parent_or_guar___5_
label values are_you_the_parent_or_guar___6 are_you_the_parent_or_guar___6_
label values are_you_the_parent_or_guar___7 are_you_the_parent_or_guar___7_
label values are_you_the_parent_or_guar___8 are_you_the_parent_or_guar___8_
label values has_the_impacts_pof_covid has_the_impacts_pof_covid_
label values how_long_would_you_be_able how_long_would_you_be_able_
label values are_you_currently_caring_f are_you_currently_caring_f_
label values are_you_an_essential_worke are_you_an_essential_worke_
label values do_you_feel_like_you_are_a do_you_feel_like_you_are_a_
label values was_your_ability_to_secure was_your_ability_to_secure_
label values reasons_disruptions___1 reasons_disruptions___1_
label values reasons_disruptions___2 reasons_disruptions___2_
label values reasons_disruptions___3 reasons_disruptions___3_
label values reasons_disruptions___4 reasons_disruptions___4_
label values reasons_disruptions___5 reasons_disruptions___5_
label values reasons_disruptions___6 reasons_disruptions___6_
label values reasons_disruptions___7 reasons_disruptions___7_
label values reasons_disruptions___8 reasons_disruptions___8_
label values reasons_disruptions___9 reasons_disruptions___9_
label values reasons_disruptions___10 reasons_disruptions___10_
label values reasons_disruptions___11 reasons_disruptions___11_
label values how_do_you_expect_your_liv how_do_you_expect_your_liv_
label values would_you_say_that_in_gene would_you_say_that_in_gene_
label values now_thinking_about_your_ph now_thinking_about_your_ph_
label values now_thinking_about_your_ph_2 now_thinking_about_your_ph_2_
label values do_ypu_think_that_poor_phy do_ypu_think_that_poor_phy_
label values are_you_limited are_you_limited_
label values what_is_the_major_impairme what_is_the_major_impairme_
label values were_this_issues_exacerbat were_this_issues_exacerbat_
label values i_feel_tense_or_wound_up i_feel_tense_or_wound_up_
label values i_get_a_sort_of_frightened i_get_a_sort_of_frightened_
label values frightened_2 frightened_2_
label values i_feel_restless_as_i_have i_feel_restless_as_i_have_
label values worrying_thoughts_go_throu worrying_thoughts_go_throu_
label values feel_panic feel_panic_
label values feel_ease feel_ease_
label values feel_sloweddown feel_sloweddown_
label values i_still_enjoy_the_things_i i_still_enjoy_the_things_i_
label values lost_interest_appearance lost_interest_appearance_
label values i_can_laugh_and_see_the_fu i_can_laugh_and_see_the_fu_
label values i_look_forward_with_enjoym i_look_forward_with_enjoym_
label values i_feel_cheerful i_feel_cheerful_
label values i_can_enjoy_a_good_book_or i_can_enjoy_a_good_book_or_
label values covid19_impact_on_so_v_3 covid19_impact_on_so_v_3_



label variable record_id "Record ID"
label variable redcap_survey_identifier "Survey Identifier"
label variable participant_informat_v_0 "Survey Timestamp"
label variable consent "You are invited to take part in this survey, supported by the Faculty of Social Sciences, University of the West Indies, Cave Hill Campus, Barbados.  Your responses will provide important insights.   If you have previously completed the survey, please do not do so a second time.  When completing the questionnaire, if you want to go to the previous page, DO NOT click on the backward arrow on your browser. This will cause your answers to be lost.  Instead, scroll to the bottom page and press the previous button.   Would you like to continue with this survey?"
label variable participant_informat_v_1 "Complete?"
label variable covid19_impact_on_so_v_2 "Survey Timestamp"
label variable age "What is your age? "
label variable residence_status "What is your residence status in Barbados?"
label variable gender "What is your gender? "
label variable what_is_your_relationship "What is your relationship status?"
label variable i_currently_live_in "I currently live in"
label variable i_normally_live_in "I normally live in"
label variable residence_restrictions "During the restrictions, lockdowns, and curfews, I lived in?"
label variable what_is_your_highest_level "What is your highest level of education? "
label variable what_is_the_ethnicity_that "What is the ethnicity that best describes you?"
label variable do_you_normally_attend_fai "Do you normally attend faith based meetings (i.e. church, mosque, Kingdom Hall)?"
label variable restrictions_worship "Places of worship were temporaily closed during the restriction, lockdowns and curfews. How did this affect your worship? "
label variable i_was_unable_to_continue_b "I was unable to continue because"
label variable before_covid_employment "Before the COVID-19 related restrictions, curfews and lockdowns, which statement applied  to you?  "
label variable during_covid_employment "Which of these statements currently apply  to you?  "
label variable if_you_have_been_asked_to "If you have been asked to work from home, do you have all the necessary resources at home? "
label variable if_you_have_been_asked_to_2 "If you have been asked to study from home, do you have all the necessary resources at home? "
label variable how_much_do_you_make "Currently, how much do you make monthly ? (What is your monthly income ?)"
label variable did_your_household_income "Did your household income change during the pandemic? "
label variable did_you_lose_your_job_or_c "Did you lose your job or close your business due to COVID-19?"
label variable the_main_income_earner_bre "The main income earner (bread winner) in my household is"
label variable what_has_been_your_househo "What has been your households main income sources before the pandemic? "
label variable what_has_been_your_househo_2 "What has been your households main income sources since the onset of the pandemic? "
label variable home_owning_status "Home owning status"
label variable are_you_the_parent_or_guar___1 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=Less than 1 year old)"
label variable are_you_the_parent_or_guar___2 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=1 year to 3 years)"
label variable are_you_the_parent_or_guar___3 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=4 years to 5 years)"
label variable are_you_the_parent_or_guar___4 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=6 years to 10 years)"
label variable are_you_the_parent_or_guar___5 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=11 years to 14 years)"
label variable are_you_the_parent_or_guar___6 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=15 years to 18 years)"
label variable are_you_the_parent_or_guar___7 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=More than 18 years)"
label variable are_you_the_parent_or_guar___8 "Are you the parent or guardian of an infant or child? (click all that applies) (choice=Not applicable, I do not have children)"
label variable how_many_children_are_in_y "How many children are in your household?"
label variable how_many_persons_are_there "How many persons are there in your household, including yourself?"
label variable has_the_impacts_pof_covid "Due to COVID-19, has your savings been depleted or decreased? "
label variable how_long_would_you_be_able "How long would you be able to pay your bills, based on your savings? "
label variable are_you_currently_caring_f "Are you currently caring for an elder (family or friend) or person living with a non-communicable disease? "
label variable are_you_an_essential_worke "Are you an essential worker? "
label variable do_you_feel_like_you_are_a "Do you feel like you are at a higher risk of contracting COVID?"
label variable was_your_ability_to_secure "Was your ability to secure necessities affected ?   "
label variable reasons_disruptions___1 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Reduced demand for goods / services)"
label variable reasons_disruptions___2 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=No market to sell products)"
label variable reasons_disruptions___3 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Transport limitations (i.e. no means of getting to food stores))"
label variable reasons_disruptions___4 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Decreased food importation)"
label variable reasons_disruptions___5 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Movement restrictions (e.g. curfews))"
label variable reasons_disruptions___6 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Means of securing necessities were unavailable)"
label variable reasons_disruptions___7 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Necessities were too expensive or inaccessible)"
label variable reasons_disruptions___8 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Concern about leaving the house due to outbreak)"
label variable reasons_disruptions___9 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Adult members of the household were unwell)"
label variable reasons_disruptions___10 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Increased demand for goods / services by others)"
label variable reasons_disruptions___11 "What were the main reasons for the disruptions to securing the things you need?  (Please select all that apply)  (choice=Other)"
label variable how_do_you_expect_your_liv "How do you expect your livelihood to be impacted  in the future as a result of disruptions from COVID-19? "
label variable would_you_say_that_in_gene "Would you say that in general your health has been?"
label variable now_thinking_about_your_ph "Now thinking about your physical health, which includes physical illness and injury, how has your physical health been?  "
label variable now_thinking_about_your_ph_2 "Now thinking about your mental health, which includes stress, depression, and problems with emotions, how has your mental health been? "
label variable do_ypu_think_that_poor_phy "Do you think that poor physical or mental health have kept you from doing your usual activities, such as self-care, work, or recreation  "
label variable are_you_limited "Are you limited in any way in any activities because of any impairment or health problem?"
label variable what_is_the_major_impairme "What is the major impairment or health problem that limits your activities? Complications from ..."
label variable were_this_issues_exacerbat "Have these problems exacerbated (increased) since the pandemic?"
label variable i_feel_tense_or_wound_up "I feel tense or wound up"
label variable i_get_a_sort_of_frightened "I get a sort of frightened feeling like butterflies in the stomach:"
label variable frightened_2 "I get a sort of frightened feeling as if something awful is about to happen:"
label variable i_feel_restless_as_i_have "I feel restless as I have to be on the move:"
label variable worrying_thoughts_go_throu "Worrying thoughts go through my mind:"
label variable feel_panic "I get sudden feelings of panic:"
label variable feel_ease "I can sit at ease and feel relaxed: "
label variable feel_sloweddown "I feel as if I am slowed down:"
label variable i_still_enjoy_the_things_i "I still enjoy the things I used to enjoy:"
label variable lost_interest_appearance "I have lost interest in my appearance: "
label variable i_can_laugh_and_see_the_fu "I can laugh and see the funny side of things:"
label variable i_look_forward_with_enjoym "I look forward with enjoyment to things:"
label variable i_feel_cheerful "I  feel cheerful: "
label variable i_can_enjoy_a_good_book_or "I can enjoy a good book or radio or TV program:"
label variable covid19_impact_on_so_v_3 "Complete?"

order record_id redcap_survey_identifier participant_informat_v_0 consent participant_informat_v_1 covid19_impact_on_so_v_2 age residence_status gender what_is_your_relationship i_currently_live_in i_normally_live_in residence_restrictions what_is_your_highest_level what_is_the_ethnicity_that do_you_normally_attend_fai restrictions_worship i_was_unable_to_continue_b before_covid_employment during_covid_employment if_you_have_been_asked_to if_you_have_been_asked_to_2 how_much_do_you_make did_your_household_income did_you_lose_your_job_or_c the_main_income_earner_bre what_has_been_your_househo what_has_been_your_househo_2 home_owning_status are_you_the_parent_or_guar___1 are_you_the_parent_or_guar___2 are_you_the_parent_or_guar___3 are_you_the_parent_or_guar___4 are_you_the_parent_or_guar___5 are_you_the_parent_or_guar___6 are_you_the_parent_or_guar___7 are_you_the_parent_or_guar___8 how_many_children_are_in_y how_many_persons_are_there has_the_impacts_pof_covid how_long_would_you_be_able are_you_currently_caring_f are_you_an_essential_worke do_you_feel_like_you_are_a was_your_ability_to_secure reasons_disruptions___1 reasons_disruptions___2 reasons_disruptions___3 reasons_disruptions___4 reasons_disruptions___5 reasons_disruptions___6 reasons_disruptions___7 reasons_disruptions___8 reasons_disruptions___9 reasons_disruptions___10 reasons_disruptions___11 how_do_you_expect_your_liv would_you_say_that_in_gene now_thinking_about_your_ph now_thinking_about_your_ph_2 do_ypu_think_that_poor_phy are_you_limited what_is_the_major_impairme were_this_issues_exacerbat i_feel_tense_or_wound_up i_get_a_sort_of_frightened frightened_2 i_feel_restless_as_i_have worrying_thoughts_go_throu feel_panic feel_ease feel_sloweddown i_still_enjoy_the_things_i lost_interest_appearance i_can_laugh_and_see_the_fu i_look_forward_with_enjoym i_feel_cheerful i_can_enjoy_a_good_book_or covid19_impact_on_so_v_3 
set more off
describe

*Save dataset
save "`datapath'/Data/Covid_Evaulating_Impact_002.dta", replace

*Export dataset with value labels for EA
export excel using "`datapath'/Data/covid_project_labels_EA.xlsx", firstrow(variables) replace



