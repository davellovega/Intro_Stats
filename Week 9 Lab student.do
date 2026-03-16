
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 9 Lab
Simple linear regression
•	Fitting a line through a scatter plot in Stata
•	Linear regression with an interval-level independent variable
•	Linear regression with categorical independent variables

 
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

***********************************************************************************************
***********************************************************************************************
/*
Laboratory Simple linear regression

This week's lecture gave you an introduction to linear regression, including the intuition behind the "line of best fit", the derivation and interpretation of the coefficients and the R-squared, and inference on the coefficient β. In linear regression, the dependent variable y needs to be interval-level, while the independent variable x can be of any type. 
*/

//# 1.	1.	Fitting a line through a scatter plot

*In week 8 you learned how to make scatter plots for two interval level variables. Remember, the independent variable goes on the x-axis and the dependent variable goes on the y-axis. The way you identify the dependent and independent variable depends on the research question at hand. Start by answering the following questions:

*Suppose I have a theory that people who work more weekly hours tend to live in households with higher incomes. In particular, I am interested in studying whether the income of the household head depends, at least in part, upon the number of weekly working hours. 



//###Q1) What is the dependent variable, and what is the independent variable? Find appropriate measures of both variables in the ADRC_S dataset.







//### Q2) Using a scatterplot, describe the association between income and working hours.







*We will now summarise the association between income and weekly working hours by fitting a line through the scatterplot. The following command is an extension of the twoway command, which allows you to overlay multiple graphs. The first graph, which we already know, is a scatter plot (scatter). The second is a line of best fit (lfit). 

*Note that, for this part of the assignment, I will use the log of household head income instead of its raw values, given that the assumptions behind linear regression include bivariate normality.

twoway scatter log_inc workhours || lfit log_inc workhours  


//### Q3) What does the line of best fit suggest about the association between weekly working hours and log of income?









***********************************************************************************************
//# 2.	Linear regression with interval-level independent variable

/*Next, we fit a linear regression model to quantify the correspondence between working hours and income. In Stata, regress is the relevant command. Just like in the scatterplot and line of best fit, the dependent variable always comes first in the command. So the command is: 

regress dependent_variable independent_variable. 

In our case:*/

regress log_inc workhours


* Interpretation:

***	There is a positive (but small) linear association between working hours and the income of the household head (in logarithm). Specifically, each extra weekly working hour is associated with a 0.006 increase in the log of income (since the exponential of 0.006 is 1.006, we can also say that each extra weekly working hour is associated with a £1.006 increase in income).

*** The association is statistically significant (p<0.001): in the population, we are 95% confident that each extra working hour is associated with an increase in log income by [0.0035 ; 0.0086].
* People who work 0 hours appear to have, on average, log incomes of 5.41 (this is given by the intercept or "_cons" in Stata.

*** As expected from the scatter plot, the model only explains little of the total variation in log income. The variation explained by the model is 1.21% (R-squared = 0.0121).


//### Q4) Based on the regression output, write down the regression equation, substituting α and β with the coefficients obtained from the model.






//## Further practice

* Now imagine we suspect that the association between working hours and log of income may differ by sex (male or female). Using the following command, we obtain graphs by variable sex:

twoway scatter log_inc workhours, by(sex) || lfit log_inc workhours, by(sex)


//### Q5) Based on the two lines, does the association between log of income and working hours appear to differ by sex?







//### Q6) Fit a simple linear regression of log of income on working hours, for men only (hint: use if sex==1). Comment on the results.







//### Q7) Fit a simple linear regression of log of income on working hours, for women only (hint: use if sex==2). Comment on the results.








***********************************************************************************************
//# 3.	Linear regression with categorical independent variables

*Linear regression easily accommodates any type of categorical independent variable x (binary, nominal, or ordinal). However, the interpretation is a little different. For this example, we will go back to the same variables used in week 7 when learning about two-sample t-tests and ANOVA. 

*Specifically, we want to know whether working hours among full-time workers (measured by the variable 

*The two new variables are coded as follows (from codebook). For how to generate them, refer to the Stata code from week 6 (workhrs_ft) and week 7 (mstat):


*Let's start from differences in working hours by marital status. 

//### Q8) Using any command of your choice, describe the differences in mean working hours among full-time workers for the three categories of marital status.









*Since mstat has three categories, until now, we would have relied on ANOVA to test for any differences in mean working hours in the population. However, as you remember, ANOVA had the disadvantage that it did not make it possible to find which differences in means across categories were significant (because it is a global test of significance). 
*Simple linear regression solves this problem. Just type:

regress workhrs_ft i.mstat

*Note that, in this command, we told Stata that mstat is categorical by specifying an i. before mstat. This is very important! Otherwise, Stata will just treat the categorical variable as if it was continuous, making it impossible to interpret the results.

*Interpretation:
***	_cons = 43.52: the value of y when x=0 is 43.52. We know x does not take value 0 in this case, but we can see that one of the categories of mstat (the first, "married or cohabiting") is excluded from the model output. This is taken to be the "baseline" category. When x is categorical, the intercept α indicates the mean of y (working hours) when x is at its baseline category. Therefore, people who are married or cohabiting work on average 43.52 hours.

***	The coefficient on "single" is -2.78. This tells us the difference in means between the baseline (married) and the "single" category. This difference is statistically significant (p < 0.001), so we conclude that in the population of full-time workers single people work, on average, around 2.78 less than the married. 

***	The coefficient on "no longer married" is -1.23. This tells us the difference in means between the baseline (married) and the "no longer married" category. This difference is not statistically significant (p = 0.244), so we fail to reject the null that, in the population, the mean working hours of married and no longer married people are different.

***	R-squared = 0.0087. The model explains 0.87% of the total variation in working hours.


* You can now interpret simple linear regression models with interval and categorical independent variables. For some further practice of the categorical x case, answer the following question:

//### Q9) What is the association between working hours for full-time workers and sex? Answer this question using a regression model, and carefully interpret your results.









**
*As usual, remember to save your work!



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

recode marstat (2 7 = 1) (3 = 2) (4/6 = 3), gen(mstat)
label define mstat 1"married or cohabiting" 2"single (never married)" 3"no longer married", modify
label values mstat mstat
label var mstat "marital status (3 categories)"


