
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 6 Lab
T-test and ANOVA
•	Two sample tests
•	ANOVA

 
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


/*
***********************************************************************************************
Remember: 

NULL: "There is nothing going on here. Any difference you see is just random chance."


Difference between:

[ ONE SAMPLE t-test]         
 Purpose:    Compare 1 group mean to a known value /// "Does my sample match a target?" 
 Example: "Is avg height = 170cm?"
 Groups: 1
 Null: "The true average of my group is just the target value — nothing special about my sample."
 Statistic: t
 
  [ TWO SAMPLE t-test]   
 Purpose:    Compare means of 2 groups ///  "Are these two groups different from each other?"
 Example: "Do men and women differ in height?
 Groups: 2
 Null: "These two groups have the same average — any observed difference is just noise."
 Statistic: t
 
  [ ANOVA]     
 Purpose:    Compare means of 3+ groups ///  "Are any of these multiple groups different from each other?" (then post-hoc tests tell you which ones)
 Example: "Do 3 diet groups differ in weight loss?"
 Groups: 3+
 Null: "All groups have the same average — none of the groups are special."
 Statistic: F

 
 */
 



***********************************************************************************************
/*
Laboratory – T-test and ANOVA

In this week's lecture we learned about making statistical inference (from samples to populations) for the presence of associations between two variables. Today's lab exercises help you practice the two statistical techniques for associations that we covered in the lecture, namely:

•	Two-sample t-tests
•	ANOVA
*/

//# 1.	T-tests for associations
*Last week in the lab you learned how to conduct one-sample and two-sample t-tests in Stata, and to test for the equality of variances in the interval variable between the two groups defined by the binary variable using Levene's test.

* Using the commands you learned last week (as well as in previous weeks for descriptive sample statistics), answer the following research question. 

//## Q1) What is the association between weekly working hours and gender (male vs. female) in the UK population of full-time workers?


*In answering this question:
//### a)	Specify the dependent and independent variable. 

//### b)	Explain what type of association (if any) you expect to observe between gender and working hours among full-time workers. Justify your expectation.

//### c)	Describe each of the two variables in the ADRC_S subsample of full-time workers (tip: make sure you specify if workhrs!=. when tabulating variable sex).

//### d)	Describe difference in mean working hours by gender in the ADRC_S sample

 //### e)	Appropriately state the null and alternative hypotheses for the test

 //### f)	Carry out the test, specifying the correct option for equal/unequal variances

 //### g)	Interpret the results



//# 2.	One-way ANOVA

*One-way ANOVA (Analysis of Variance) is a statistical test based on a comparison of variances across more than two sub-groups in the sample, aimed at checking whether the means of an interval variable differ across of more than two subgroups in the population (defined by the categories of a categorical variable). 

*In today's example, just like we did last week, we will test the hypothesis that the mean number of weekly working hours is the same across groups defined by marital status. However, this time, our hypothesis is that there may be significant differences in working hours depending on whether someone is a) married and/or living together with their partner; b) single, that is, never married; or c) previously married, that is separated, widowed, or divorced.

*Without looking at the data, answer the following question:

//## Q2) Do you expect to observe significant differences in mean working hours in the population of full-time workers by marital status? Which of the three categories above do you expect to have the highest mean average working hours (among full-time workers), if any? Why? 


*Last week we generated a new variable called workhrs_ft, with the following characteristics:
*•	For individuals working full-time, it takes the same value as workhours
*•	For everyone else, it missing (= .)

*We will be using this variable as our dependent variable, and marital status as our independent variable.

*In our dataset, marital status is coded as follows: 
codebook marstat

/*
To test today's hypothesis, we need to generate a new variable with only three categories, as stated above. Specifically, we want to code a variable with the following characteristics:

Variable name: mstat
Variable label: "marital status (3 categories)"
Variable categories and corresponding value labels:
1 = "married or cohabiting"
2 = "single (never married)"
3 = "no longer married"
*/

//## Q3) Using your own code, generate the variable mstat described above. Do not forget to include variable and value labels.



//## Q4) Produce a cross-tabulation (contingency table) of marstat by mstat. Check that the correspondence of the categories is correct.



*Now using the following command, we check for differences in mean working hours in the sample across the values of mstat:
bysort mstat: sum workhrs_ft

*We can visualise differences in means using graph bar:
graph bar workhrs_ft, over(mstat)

*We can also visualise differences in medians and interquartile range using boxplots:
graph hbox workhrs_ft, over(mstat)


//## Q5) Based on the summary statistics, describe the differences in working hours by the three categories of marital status in the sample.




*We now have both of the variables we need, as well as descriptive sample statistics. The next step is to conduct a hypothesis test for differences in mean working hours in the population of full-time workers, using ANOVA. 



//## Q6) State the null and alternative hypotheses for this test.
*In Stata, this is done by typing:

oneway workhrs_ft mstat, tabulate

/*The command gives us the following output:


  RECODE of |
    marstat |                  Summary of working hours for FT   workers
   (marital |             
    status) |                 Mean                                 Std. dev.             Freq.
------------+------------------------------------
          1 |                     43.516275                       11.730156         1,106
          2 |                     40.74                                 9.6260725         300
          3 |                     42.277372                        15.437126         137
------------+------------------------------------
      Total |                   42.866494                         11.781366       1,543

                        Analysis of variance
    Source                      SS                     df         MS                         F       Prob > F
------------------------------------------------------------------------
Between groups      1871.11083      2          935.555413      6.79     0.0012
 Within groups           212159.387   1540   137.765836
------------------------------------------------------------------------
    Total           214030.498   1542   138.800582

Bartlett's equal-variances test: chi2(2) =  45.3332    Prob>chi2 = 0.000





Let's interpret it together:
•	The table at the top is the tabulation of the sample data, summarising sample means, standard deviations, and frequencies (number of observations) for each group defined by mstat.
•	The Analysis of Variance table at the bottom has the ANOVA results
o	The column "SS" indicates "sum of squares". This is the sum of square deviations used to calculate the F-test. The between-groups sum of squares is reported in the first row (1871.11 here) and the within-groups sum of squares is reported in the second row (212159.39 here)
o	The column "df" indicates degrees of freedom. These are used to derive the correct F-distribution to obtain the p-value. The between-group degrees of freedom are equal to g-1 (number of groups minus 1, 3-1 = 2 here); The within-groups degrees of freedom are n-g (number of observations minus number of groups, 1,543-3 = 1,540 here).
o	The "MS" column indicates the variance ("Mean of Squares"). The between-groups one is at the top (935.56 here), and the within-groups variance is at the bottom (137.77 here). Their ratio MS-between/MS-within gives the F-statistic in the next column (F = 6.79).
o	The p-value from a F-distribution with 2, 1540 degrees of freedom is reported in the last column (0.0012).
o	All the totals are in the last row. Note that the Total MS is the total variance in the interval variable (working hours).
*/

//## Q7) Based on the output above, what do you conclude about the association between working hours and marital status among full-time workers?



/*
For further practice with one-way ANOVA, answer the following question based on the ADRC_S dataset. In your answer:
a)	Provide descriptive sample statistics
b)	State the null and alternative hypotheses
c)	Carry out the test and interpret the results.

*/

//## Q8) Are there significant differences in mean household head income (measured by variable head_inc) across the three categories of marital status in the UK population?

*If you do not have variable head_inc in your dataset, note that it was generated in week 3 as the clone of hoh_inc, setting invalid values as missing.


*When you're done, remember to save your work (including your do-file).



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


