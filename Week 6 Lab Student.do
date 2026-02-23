
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 6 Lab
T-Tests
•	one sample t-test
•   two sample t-test
•   further practice

 
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



***********************************************************************************************

//#	Introduction
/*

In this week's lecture we learned about statistical inference through hypothesis testing. We now know how to make conclusions about population parameters (means and proportions) based on sample statistics. 

Before proceeding, make sure the following concepts are clear to you:

	null and alternative hypotheses
	types of error (1 and 2) in hypothesis testing
	p-values
	statistical significance

Today's exercises will focus on 
--single-sample and 
--two-sample t-tests,
 which are hypothesis testing procedures for continuous variables, based on the Student's t distribution.

Note that, even when you have very large samples, it is always a good idea to use the Student's t (rather than the Normal) distribution for your test procedures (t-scores and test statistics for deriving p-values). This is because, whenever you work with sample data (such as the ADRC_S), the population standard deviation σ is unknown, and we need to make adjustments to the assumed shape of the sampling distribution of the mean. 

Moreover, for large enough samples (N > 500), probabilities under Student's t distribution are equivalent to Z-scores from the Standard Normal distribution.

*/

***********************************************************************************************
//#1.	One-sample t-tests

*T-tests are appropriate for comparing means of CONTINUOUS variables. In a one-sample t-test, you compare the mean of a continuous variable against some known value (such as a target or hypothesis you have about the true population parameter).

*In this example, suppose we want to test whether it is true that individuals working full-time in the UK population work on average for 35 hours per week (the UK government's definition of the minimum threshold for full-time work), or not.

*The variable workmode tells us whether an individual works full-time, part-time, or other. Using your own Stata syntax, check the coding of this variable.


//### Q1) What type of variable is workmode? What value of workmode corresponds to working full time?

*As we know from previous exercises, the variable workhours measures the number of weekly working hours for people in the ADRC_S sample. 
* In order to answer our research question (which refers to working hours among individuals working full-time only), it is helpful to generate a new variable with the following characteristics:
// For individuals working full-time, it takes the same value as workhours
// For everyone else, it missing (= .)

*We will call this variable workhrs_ft. Here is how we generate it:
gen workhrs_ft = workhours
replace workhrs_ft = . if workmode!=1
label var workhrs_ft "working hours for FT workers"

Using any of the commands you have learned in previous weeks, answer the following questions:

//### Q2. How many observations have valid cases for workhrs_ft?

//### Q3. What is the maximum number of working hours among those working full-time? What is the minimum?

//### Q4. Find the sample mean and standard deviation for workhrs_ft.

//### Q5. Visualise the sample distribution of workhrs_ft.


* Now that we know the sample characteristics of workhrs_ft, we can proceed to test our hypothesis that working hours among full-time workers are no different from 35 per week.

//### Q6. State the null and alternative hypotheses for this test, both formally (i.e., in maths language) and in your own words.


*Now that we have our hypotheses, we can proceed to conduct a one-sample t-test. Stata's command for doing so is ttest. Let's first explore this command by typing:

help ttest

*For the one-sample t-test that working hours among FT workers are exactly 35 per week, the relevant syntax is:

ttest workhrs_ft == 35

/*This gives us the following output:

One-sample t test
------------------------------------------------------------------------------------------------------------------------
Variable   |     Obs        Mean             Std. err.     Std. dev.        [95% conf. interval]
---------+--------------------------------------------------------------------------------------------------------------
workhr~t |   1,543    42.86649     .299925    11.78137    42.27819     43.4548
------------------------------------------------------------------------------------------------------------------------
    mean = mean(workhrs_ft)                                       t =  26.2282
H0: mean = 35                                    Degrees of freedom =     1542

    Ha: mean < 35               Ha: mean != 35                 Ha: mean > 35
 Pr(T < t) = 1.0000         Pr(|T| > |t|) = 0.0000          Pr(T > t) = 0.0000
 
 Let's go through the output together. 
	
	* Within the table, Stata gives us the sample characteristics (that we already know) as well as the 95% confidence interval for the mean working hours. We interpret this as: "we are 95% confident that, in the UK population, the mean of working hours is between 42.28 and 43.45".
	* Below the table, Stata gives us the degrees of freedom for the test, which we know to be N-1. In this case, N = 1543 and d.f. = 1542
	* At the bottom, Stata gives us three alternatives against which the null is tested, with respective p-values. The two-sided alternative is reported in the middle, and the p-value is indicated by Pr⁡(|T|>|t|).
	* The p-value for the two-sided alternative (H_A:mean!=35) is 0.0000. However, we know that p-values are never really zero (due to the asymptotic properties of the sampling mean distribution). As such, we should report this p-value as p < 0.00001.

*/

//### Q7. What is the conclusion of the test? Interpret this result.

***********************************************************************************************

//#2.	Two-sample t-tests

*Let's now move on to two-sample t-tests, of the type we have already seen in the lecture for this week. In the two-sample case, the mean of a continuous variable is compared between two sub-samples, which are defined by the values of another variable. 

*We are interested in testing whether, among full-time workers, there are differences in average working hours between those who are married and those who are not.

*Variable marstat is a nominal variable identifying individuals' marital status. By using codebook or fre, we can see that the corresponding value for the category "married" is 1.

*From marstat, we can generate a binary variable that identifies the two groups for our two-sample t-test (married vs. not married): let's call this variable married.

recode marstat (1 = 1) (2/7 = 0), gen(married)
label var married "whether married or not"
label define yn 0 "no" 1 "yes"
label values married yn
codebook married

*We want to test whether the values of workhrs_ft differ between married (married = 1) and non-married (married = 0) full-time workers.

*First of all, let's check out the distribution of workhrs_ft conditional on being married:

hist workhrs_ft if married == 1
*and conditional being not married
hist workhrs_ft if married == 0

*We can also get Stata to summarize the variable workhrs_ft separately by the values of married. This is done using:

bysort married: sum workhrs_ft


//### Q8. Based on the output from the last few commands, describe the differences in mean working hours between the two samples.


*Moving on from the descriptive statistics, we now wish to test for whether there are likely to be differences in working hours between married and non-married people in the population of full-time workers.

//### Q9. State the null and alternative hypotheses for this test, both formally and in plain language.

*We can conduct a two-sample t-test in Stata by typing:

ttest workhrs_ft, by(married)

*This gives us the following output: 
/*

Two-sample t test with equal variances
-------------------------------------------------------------------------------------------------------
   Group     |     Obs        Mean          Std. err.       Std. dev.      [95% conf. interval]
---------+---------------------------------------------------------------------------------------------
       0         |     648     41.4429    .4678796    11.91027    40.52416    42.36165
       1         |     895    43.89721    .3872452    11.58504   43.13719    44.65722
---------+-------------------------------------------------------------------------------------------------
Combined |   1,543    42.86649     .299925    11.78137    42.27819     43.4548
---------+-------------------------------------------------------------------------------------------------
    diff |                        -2.454305    .6046599                         -3.640349   -1.268262
-----------------------------------------------------------------------------------------------------------
    diff = mean(0) - mean(1)                                        t =  -4.0590
H0: diff = 0                                     Degrees of freedom =     1541

    Ha: diff < 0                      Ha: diff != 0                 Ha: diff > 0
 Pr(T < t) = 0.0000         Pr(|T| > |t|) = 0.0001          Pr(T > t) = 1.0000

 
 The last (bottom) row of the table reports the statistics of interest for the difference between the two means. The difference between the sample means is equal to -2.45, indicating that the married group tends to work on average around 2 and half hours more than the non-married group.

The t-statistic is reported right beneath the table, on the right-hand side (t = -4.059), along with the degrees of freedom (which are equal to N-2 for two-sample tests).
As usual, we test the null against the two-tailed alternative (reported in the middle as H_A:diff!=0).


*/


//### Q10. What is the p-value for the test of the null against the two-tailed alternative?

//### Q11. What conclusion can we draw from this p-value? Do we reject or fail to reject the null hypothesis? Give a substantive interpretation of the result.

***********************************************************************************************  

//##2.1 Testing for the equality of variances

*As you may have noticed, the t-test performed above assumes that the variance of workhrs_ft is the same across the two samples (married and non-married). This is stated at the top of the output ("Two-sample t-test with equal variances").

*The assumption of equal variances may, however, be a little restrictive. In the example of mean face-to-face interactions among care-home residents and community dwellers that we saw in the lecture, the two samples' standard deviations were clearly different (and therefore, so were their variances).

*Before performing any two-sample t-test, we can actually test for whether the two samples in question have equal variances with respect to the variable of interest. This is called the Levene test for equality of variances. It can be performed in Stata by typing:

robvar workhrs_ft, by(married)

/* You get information on the means for married and non-married, standard deviations and frequencies. Below the table, you find the Levene test in the first line (W0). The information of importance here is whether the difference in variances is statistically significant or not. If it is significant, it means that the variances of married and non-married are unequal and you will have to account for this when running your t-test. 


 whether     |   Summary of working hours for FT workers
 married or  |               
        not      |        Mean            Std. dev.         Freq.
------------+----------------------------------------------------
          0       |   41.442901    11.91027           648
          1       |   43.897207    11.585039         895
------------+----------------------------------------------------
      Total    |   42.866494    11.781366         1,543

W0  =  3.41005534   df(1, 1541)     Pr > F = 0.0649919

W50 =  0.26329021   df(1, 1541)     Pr > F = 0.60794224

W10 =  2.34564291   df(1, 1541)     Pr > F = 0.12583897



The p-value for the relevant test (the Levene test indicated by W0) is p = 0.065.

This gives some evidence against the null hypothesis that the variance of working hours is equal between married and non-married people in the population of FT workers. In other words, the chance of rejecting a true null under this test is 6.5%. 

Since we prefer to be safe than sorry, given this evidence that the two variances are likely to be different in the population of full-time workers, we decide to assume non-equal variances and re-do our two-sample t-test. This is done in Stata by adding the unequal option.

*/

ttest workhrs_ft, by(married) unequal

*As you can see from the new output, some things have changed from the previous version of the test. The most important thing to notice is that the standard error for the difference in means is slightly larger, to account for the additional uncertainty. However, you can still interpret the output of this test with unequal variances exactly like we did for the previous version with equal variances.


//### Q12. What is the conclusion from the output of this test? Interpret the findings about the differences in working hours between married and non-married people in the population of UK full-time workers.



***********************************************************************************************

//#3.	Further Practice

* In week 4, when we learned about assessing the extent to which a variable's distributions resembles a Normal curve, we worked with the variable head_inc, which measures the usual gross weekly income of the household head.   

* Having found the shape of head_inc to be very far from a Normal distribution, we generated its natural logarithm, log_inc, which gets somewhat closer to being normally distributed.

* The code for generating log_inc (in case you don't have this variable in your dataset), was:

gen log_inc = ln(head_inc)
label var log_inc "log of hh head income"

*Check how he distribution of log_inc (from week 4) looks like this in the sample

* In your own time, and using any Stata syntax that you think is appropriate, answer the following questions about log_inc.


//### Q13. Describe the sample characteristics of log_inc in terms of effective sample size (i.e., number of valid cases), mean, and standard deviation.

//###  Q14. Suppose the government has a target for average gross weekly incomes of £215. The natural logarithm of 215 is ln⁡(215)=5.37. Using this information and the variable log_inc, conduct a one-sample t-test for whether the government is on target. Remember to clearly state the null and alternative hypotheses, make a decision about the null hypothesis, and interpret your result substantively.

//### Q15. Does the mean log(income) of household heads differ between men and women? Conduct a two-sample t-test for this research question. As usual, clearly state the null and alternative hypotheses, make a decision about the null, and interpret your result.


*When you're done, remember to save your work (including your do-file)!

save "ADRC_S_modified.dta", replace



