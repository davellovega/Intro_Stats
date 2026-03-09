
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 8 Lab
Chi-Square and Correlation coefficients
•	Associations between categorical variables (cross-tabs and chi-squares)
•	Associations between continuous variables (scatterplots and correlations)

 
Prepared by: Dalia Avello-Vega
*/

////////////////////////////////////////////////////////////////////////////////

//# Preparing the session:

cls
macro drop _all
clear all
set more off

//## Establishing Directory MacOC or Windows
/*
if "`c(os)'" == "MacOSX" { //This command returns the operating system
    global main "smb://chss.datastore.ed.ac.uk/chss/sps/users/davello" //Here you add the macOS pathname
}
else if "`c(os)'" == "Windows" {
    global main "M:/VIP Project/EFA_CFA" //Here you add the Windows pathname
}

//## Set working directory and open last week's version of the dataset

cd "$main" 
*/


////////////////////////////////////////////////////////////////////////////////
*QUICK NOTES:

Association / Categorical

**Chi-Square: 
// What for: Are these two categorical variables independent?

// How: It compares observed frequencies in a contingency table to expected frequencies (what you'd see if there were no association). A significant result means the variables are likely related, but it doesn't tell you how strongly.

// Interpretation: p value

**Cramér's V:
// What for: how strong is the relationship?

// How: since Chi-square is sensitive to sample size (large samples can make trivial associations significant), Cramér's V standardizes it into a effect size measure ranging from 0 (no association) to 1 (perfect association)

//Interpretation(roughly): 0.1 = weak, 0.3 = moderate, 0.5+ = strong.


Association / Continuous

** Scatterplots:
//What for: visualise the pattern of the association in a plot

//How: You can immediately see direction (positive/negative), form (linear/curved), strength, and outliers. 

//Interpretation: look for patterns



** Pearson's Correlation(r)
//What:  what is the strength and direction of the  (linear) relationship between these variables?

//Assumptions: both variables should be roughly normally distributed, the relationship should be linear, and outliers can distort it significantly.


** Spearman's Correlation (ρ)
//What A rank-based alternative to Pearson's. Instead of raw values, it correlates the ranks of the data
*Therefore:
*- Robust to outliers
*- Suitable for skewed distributions
*- Able to capture monotonic (not just linear) relationships
*- Appropriate when data is ordinal rather than truly interval


// Interpretation: Both coefficients are interpreted the same way — the logic is identical, the only difference is what they're measuring (raw values vs. ranks).

*Report:

* Direction (Positive (+): as one variable increases, the other tends to increase or Negative (−): as one variable increases, the other tends to decrease)

* Strength: A common rule of thumb (Cohen's conventions): 	
    0.00 to 0.09 = no association
	0.10 to 0.29 = weak association
	0.30 to 0.59 = moderate association
	0.60 to 1 = strong association

*Statistical Significance (p-value)


////////////////////////////////////////
/*
Connecting this  to T-Tests and ANOVA:

*All of these are tools to study relationships between variables — they just differ based on the type of variables involved.

RELATIONSHIP         |       INDEPENDENT VARIABLE     |   DEPENDENT VARIABLE         |           TOOL
Group differences               Categorical  (2 groups)                    Continuous                             TTest

Group differences             Categorical  (3 groups)                      Continuous                             Anova

Association                          Categorical                                        Categorical                        Chi2 
                                                                                                                                                    / Cramér's V

Association                         Continuous                                          Continuous                       Scatterplot /                                                                                                                                                      Pearson's /                                                                                                                                                       Spearman's


*T-tests and ANOVA are actually just a special case of studying association — they ask "does group membership relate to scores on a continuous variable?"

*What type of variables do I have? → that determines your tool, not the underlying logic, which is always the same: is there a meaningful, non-random relationship between these two variables?
*/






***********************************************************************************************
***********************************************************************************************
/*
Laboratory –Chi-square test and correlation coefficients

In this week's lecture we learned some statistical tools to study associations between two categorical variables, and between two interval variables. This week's lab will teach you the Stata commands you need to study these types of associations in the sample data as well as in the population of inference. We will cover:

•	Associations between categorical variables (cross-tabs and chi-square tests)
•	Associations between interval variables (scatterplots and correlations)

*/

//# 1.	Chi-square test

*The chi-square (χ^2) test is appropriate for testing associations between two categorical variables.
*In today's example, we aim to test for whether and how age group is associated with self-rated health among adults (people aged 20+) in the UK.
*In week 1, we generated variable health based on the ADRC_S variable ghealth. Variable health is simply a clone of ghealth (generated using clonevar) where invalid values (-9 and -8) are set to missing (.) . If you do not have this variable in your dataset already, make sure to generate it again before proceeding. It looks like this (from codebook):

codebook health

*For age group, we aim to generate a new variable with the following values:
*•	. (missing) : ages 0-19
*•	1 : "age 20-29"
*•	2 : "age 30-49"
*•	3 : "age 50-69"
*•	4 : "age 70+"

*We can use the following code to generate a new variable called agegroup (but you are welcome to use any alternative code you may prefer):

recode age (0/19 = .) (20/29 = 1) (30/49 = 2) (50/69 = 3) (70/max = 4), gen(agegroup)

label var agegroup "age group"
label define agegr 1 "age 20-29" 2 "age 30-49" 3 "age50-69" 4 "age 70+", modify
label values agegroup agegr

tab age agegroup, m


*The last line is just to check that the re-coding worked.
*Now that have both our variables, we can proceed to describing their univariate distributions. 

//###Q1) Produce a bar chart (using graph bar or graph hbar) for each of the two variables.

*Note that Stata can also produce graph bars over the values of two categorical variables. The following command makes the following graph, giving us an overview of the self-reported health status of different age groups in the sample. Specifically, it gives percentages in each health status separately by age group:


graph hbar, over(health) over (agegroup)asyvar




//### Q2) In studying the association between age group and health, which is the dependent variable? Which is the independent variable? Justify your answer.





//### Q3) Using tab, obtain a contingency table of health and agegroup. Based on your answer to Q2, decide whether row percentages or column percentages are more appropriate, and add them to the cross-tabulation.





//### Q4) Based on the bar chart above as well as your answer to Q3, are there differences in self-reported health by age group in the sample?





*We now want to study whether the differences detected in the sample are likely to be reflected in the population, using a chi-square test.

//###Q5) State the null and alternative hypotheses for this test

*The code to produce a chi-square test is very simple. Since the chi-square test is based on a contingency table, we can just ask Stata to add the chi-square test result to our cross-tabulation. This is done using:

tab health agegroup, chi2


*The output of this test gives us a chi-square test statistic of 251.33, and a p-value < 0.001.

//### Q6) What conclusion do you draw from this test? 


//## 1.1.	Cramer's V

/*The chi-square test above gives us an indication of the presence of an association between health and age group in the UK population, but it does not tell us anything about how "strong" this association is. Remember, from the lecture, that we can use Cramer's V statistic to understand the strength of the association between two categorical variables based on a contingency table. From the lecture, we know that:

Values of ϕ_c:

	0.00 to 0.09 = no association
	0.10 to 0.29 = weak association
	0.30 to 0.59 = moderate association
	0.60 to 1 = strong association

In Stata, to add Cramer's V statistic to the chi-square test, we add the option "V", which gives us a correlation strength measure between 0 (no association) and 1 (perfect association):*/

tab health agegroup, chi2 V

//### Q7) Based on the output, how strong is the statistical association between health and age group in the population?





***********************************************************************************************
//# 2.	Scatter plots and correlation coefficients

/*To conclude our study of bivariate tests for associations, we can now move on to associations between two interval-level variables (that is, discrete or continuous variables).
We are going to start by replicating the results from the lecture, where we studied the association between age of the respondent and income of the "head" of the household where the respondent lives in the ADRC_S dataset.
The relevant variables for age and household head income are age and head_inc (note: head_inc was generated in week 3).*/


//### Q8) Using sample descriptive statistics (including histograms), describe the distribution of age and head_inc. How far or close are they to a Normal distribution?

/*From our inspection, it seems safe to conclude that, while age looks ok (not normally distributed, but not terribly skewed), head_inc is very skewed. Given that the Pearson correlation coefficient assumes normality for both distributions, it seems appropriate to use a recoding of head_inc that more closely approximates normality: log_inc. We generated this variable in week 4 as the natural logarithm of head_inc.?*/

//### Q9) Make a histogram of log_inc including an overlay of the Normal curve

/*We are now ready to explore the association between the two variables. In this application, we assume that income is the dependent variable and age is the independent variable. This is appropriate as, while the income of your household may vary with your age, your age cannot depend on income.

Let's start with a scatter plot:*/

*Note that the order of the variables matters: the command needs to be "" twoway scatter y x" with the y-variable (which will go on the y-axis) followed by the x-variable (which will go on the x-axis).

twoway scatter log_inc age


//### Q10) Interpret the scatter plot. What does it suggest about the correlation between log income of the household head and age in the ADRC_S? Is it positive or negative? Is it strong or weak?

*Next, we want to quantify the value of the correlation using Pearson's correlation. There are two commands in Stata that produce a Pearson correlation. The first is correlate:

correlate log_inc age

*We can also add the option means to show us the sample means:
correlate log_inc age, means

*From the above output, the correlation is -0.1929. 

//### Q11) Interpret the value of this correlation. Is it what you expected from the scatter plot? 



*Now, let's make inference from the ADRC_S to the UK population. Specifically, we want to test against the null hypothesis that age and income of the household head are independent in the population. 
*For this purpose, we need a different command for Person correlations: pwcorr

pwcorr log_inc age, sig

*Note that I have specified the sig option to ask Stata to tell us about the statistical significance of this association in the population. The p-value is reported right under the relevant correlation coefficient in the output.

//### Q12) Is the association statistically significant? From this analysis, what do we conclude about the association between age and income in the UK population?


//## 2.1.	Spearman's correlation
*Finally, in the lecture, we learned about a different type of correlation which is based on ranks rather than actual values of the variables: the Spearman correlation coefficient. In Stata, this is easy to obtain:

spearman log_inc age

*This command gives you the Spearman's correlation coefficient (-0.2236) as well as its statistical significance. Given that this is not too different from the Pearson's coefficient, we conclude that the additional assumptions behind Pearson's (bivariate normality and homoscedasticity) were not severely violated in our data.

*Finally, we are going to look at how to approximate a Spearman coefficient by obtaining the Pearson correlation of two rank variables.
*We just need to generate the rank values of age and log_inc , using egen:

egen rank_age = rank(age)
egen rank_income = rank(log_inc)

*Check that you understand what this is doing, for example by typing

browse age rank_age

*The rank variable assigns each observation a value based on where it lies in the distribution of age. So for example, there are 59 people aged 0. These people will have the smallest value of rank_age in the dataset, which is equal to 30 (the mid-point of their ranks, between 0 and 59). 

*Now lets' correlate the two rank variables:

pwcorr rank_income rank_age

*Our approximation is not too different from the correlation obtained by applying Spearman's correlation to the raw data.

**
*As usual, remember to save your work

***********************************************************************************************

//### Recoding variables
gen workhrs_ft = workhours
replace workhrs_ft = . if workmode!=1
label var workhrs_ft "working hours for FT workers"


recode marstat (1 = 1) (2/7 = 0), gen(married)
label var married "whether married or not"
label values married yn
codebook married


clonevar head_inc = hoh_inc
replace head_inc = . if head_inc<0

clonevar health = ghealth
br health ghealth // to check that it worked
replace health = . if ghealth==-9
replace health = . if ghealth==-8
codebook health

gen log_inc = ln(head_inc)
label var log_inc "log of hh head income"

