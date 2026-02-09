
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 5 Lab
Confidence Intervals and Revision
 
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

use "/Users/daliaavellovega/Library/CloudStorage/OneDrive-UniversityofEdinburgh/02 PhD Admin/Teaching/Tutoring/Into to Stats/WEEK 2/WEEK 3/ADRC_S_modified2.dta"

***********************************************************************************************

//#1.	Confidence intervals for means
/*
Stata has a built-in command to calculate confidence intervals for means and proportions, that is simply called ci. As you progress in the course, you will also realise that Stata builds confidence intervals by default whenever conducting any form of statistical inference. For today, however, we focus on ci, to build confidence intervals around the means and proportions of individual variables.

Let's start with age, our "favourite" interval variable in the ADRC_S dataset.

As we know, we can obtain summary statistics for age by typing
*/
sum age

//### Q1) What is the sample mean of age? What is the sample standard deviation? What is the sample size?
/*
Write down the values of the mean, standard deviation and sample size for age. From just these three values, you can manually obtain a confidence interval, using the formula:

**The confidence interval equals the sample mean, plus or minus the Z-score multiplied by the standard error of the mean.**


We know that Z is 1.96 for 95% confidence intervals, and 2.58 for 99% confidence intervals.

For a 95% confidence interval, plugging in the values of x ̅ , s_x, and N for age gives us:

**The 95% confidence interval equals 38.8, plus or minus 1.96 multiplied by the quantity 23.92 divided by the square root of 5048.**

Remember, we can use Stata as a calculator to obtain the standard error
*/

display sqrt(5048)
display 23.92/71.05

*95% C.I. =38.8 ±1.96(0.3367)
*And then to calculate the CI:

display 1.96*0.3367
display 38.8-0.66 // lower bound of the CI
display 38.8+0.66 // upper bound of the CI

*Our 95% confidence interval for age is [38.14 ; 39.46]
*Of course, we do not need to do the calculations ourselves if using software, which will give us much more accurate values. We can obtain the 95% CI for age in one line of code by typing:

ci mean age

//### Q2) Interpret the 95% confidence interval for age

*Something useful to know is also how to change the confidence level, which is set to 95% by default. For a 99% confidence interval, we can type:
ci mean age, level(99)

*And for an 80% confidence interval we type:
ci mean age, level(80)


//### Q3) Which of the above confidence intervals (95%, 99%, or 80%) gives the most accurate (or close to the truth) statement about the true mean of age in the population? 


//### Q4) What are the advantages and disadvantages of increasing the confidence level?


//### Q5) Now using your own code, obtain a 97% confidence interval for the mean of working hours in the population. Report the interval and interpret the results.


//#2.	Confidence intervals for proportions
*Similar to means, Stata can obtain confidence intervals for proportions. In week 2, we generated a binary variable called workstat, taking value 1 if someone is working and 0 if not. 
*If you saved your dataset, you should have workstat among your variables already. If you don't, use can generate it again using the following code from week 2:

codebook econstat, tab(13)
recode econstat (-9 -8 =.) (1/3 = 1) (4/11 = 0), gen(workstat)

tab workstat
tab econstat workstat

label var workstat "working status"
label define worklab 0 "not working" 1"working"
label values workstat worklab



//### Q6) Based on workstat, what is the proportion of people working in the sample? What command did you use to obtain it?

*Let's generate a 95% confidence interval for the proportion working in the UK population:

ci proportion workstat
*This is simply done by specifying "proportion" after ci.


//### Q7) Interpret the 95% confidence interval for the proportion working.

*That's it for this exercise. If you have extra time, feel free to use it to revise any material you feel less comfortable with (or, if everything is clear, just explore Stata on your own!). As usual, we save a new version of our dataset. 

save "ADRC_S_modified.dta", replace

*************************************************************************************************************
*************************************************************************************************************
//# 	REVISION: Self-study revision questions

*Below are some questions you may find useful to think about while revising. Note, these are completely optional, and solutions will not be provided as the answers are already given in the lecture slides and assignments for the last five weeks. 

//### 1.	What is the difference between relational and univariate questions?


//### 2.	What is the difference between observational designs and experiments?


//### 3.	Why do we need to convert non-valid answers such as -8 "did not respond" into missing data (.) in Stata?


//### 4.	What's the difference between continuous and discrete variables? What about the difference between nominal and ordinal?


//### 5.	What is an effective way of visualising distributions for interval level variables?


//### 6.	When the distribution of a variable is skewed to the right (i.e., has outliers with large positive values), what is the relationship between the mean and the median?


//### 7.	Why should we worry about outliers?


//### 8.	What kind of information do cumulative percentages give us?


//### 9.	What kind of plots can we use to understand associations between any two interval-level variables?


//### 10.	Why are convenience samples usually not representative?


//### 11.	What is the theoretical distribution of a variable?


//### 12.	What are the main uses of Z scores?


//### 13.	What is a sampling distribution?


//### 14.	What does the Central Limit Theorem say?


//### 15.	When we have data on the entire population of interest, do we still need confidence intervals for the variables? Why/why not?


