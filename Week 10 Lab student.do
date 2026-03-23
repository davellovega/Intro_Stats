
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 10 Lab
Multiple linear regression

•	Multiple linear regression and its interpretation
•	Testing for moderation through interactions
•	Adding polynomal (quadratic) terms


 
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
Laboratory Multiple Linear regression

This week's lecture covered multiple linear regression, and we went through five potential reasons for adding independent variables: confounding, mediation, prediction, flexibility, and moderation. Remember, since we are dealing with linear regression, the dependent variable y needs to be interval-level, while the independent variables x can be at any level of measurement.
*/

//# 1.	Multiple linear regression
/*
As we discussed in the lecture, there may be several good reasons for including independent variables to a simple linear regression model. The first few questions are aimed at fixing ideas, and do not require the use of Stata.

Suppose I wish to study whether and how early retirement is associated with health. In a representative sample of 5,000 adults aged 50–70, I regress health levels (dependent variable) on an indicator of whether the respondent took early retirement (independent variable). 
*/

//## Q1) I believe that the association between early retirement and health may be different according to marital status, as married individuals may benefit more than widowed or separated individuals from early retirement. What is marital status here (a confounder, a mediator, or a moderator)?








//## Q2) I believe that the association between early retirement and health may be explained by marital status, for example as married individuals are both healthier and more likely to retire earlier. What is marital status here (a confounder, a mediator, or a moderator)?









//## Q3) I believe that the association between early retirement and health may be explained by income, as early retirement may cause a decline in income which leads to poorer health. What is income here (a confounder, a mediator, or a moderator)?









/*Next, let's practice fitting and interpreting multiple linear regressions. We will start from the example we covered in last week's lab and this week's lecture, about working hours by sex for full-time workers. We will then add a new independent variable to the model, age.

Start by describing the outcome variable workhrs_ft, which represents weekly working hours for full-time workers, and is missing for those not working full-time This was generated in lab 6. If you don't have it, the code to generate it is:
gen workhrs_ft = workhours
replace workhrs_ft = . if workmode!=1
label var workhrs_ft "working hours for FT workers"
*/

//## Q4) Are there differences in average working hours for full-time workers between males and females in the sample? Visualise these using a bar chart.









*Next, we fit a simple linear regression of workhrs_ft on sex to study the association in the population. Make sure you specify that sex is a categorical variable in your Stata syntax by adding i. before it.

//## Q5) Based on the simple linear regression, do working hours vary by sex in the population of full-time workers? Interpret the size and statistical significance of the association.









*Next, we wish to test whether the association between working hours and sex holds when we control for age. 

//## Q6) Add variable age to the regression model for working hours. Now, interpret the coefficient on sex, both in terms of size and statistical significance. What has changed? 









*Remember: in interpreting the coefficients in multiple linear regression, we need to take care to specify that these are partial coefficients. Below is an example of the interpretation for the coefficient on age, the other independent variable in our model:

"Controlling for sex, an additional year of age is associated with higher working hours by 0.071. This association is statistically significant at the 0.1% level, and we are 95% confident that the average coefficient on age controlling for sex lies between 0.028 and 0.115. Substantively, after accounting for whether one is male or female, older full-time workers tend to work more hours than younger full-time workers".


//#2.	Testing for moderation using interactions

*We now want to test whether age moderates the association between being female (vs. male) and working hours. In other words, we believe that the extent to which working hours vary by sex may depend on age, as, for example there may be differences in working hours by sex among older workers, but not among younger workers.

*To test for moderation, we need to interact the coefficients of sex and age in our model. In Stata, there are several ways of doing this. Let's start from the "manual" one, and then we'll switch to "automatic".

*In practice, an interaction term is a multiplication between two variables. Therefore, we can start by generating a new variable that is the multiplicative term of age and sex. Since sex takes two values in this survey, to make things easier, we first turn it into a 0/1 binary variable (let's call it female):

gen female = (sex==2)
label var female "whether individual is female"
tab female

*Note that the first line could have been replaced by any of the commands we already know (e.g., recode or generate and replace), but this is a quicker way to do it if your aim is to generate a binary indicator (0/1).

*Now we generate our multiplicative term of age by female:

gen agexfem = age*female
label var agexfem "age*female"

//## Q7) Describe the new variable agexfem. What values does it take for females? What values does it take for males?









* Now that we have our new variable, we are ready to fit a model with an interaction. Importantly, any model with an interaction term also needs to include the "main effects", i.e. the non-interacted coefficients for the variables of interest:

regress workhrs_ft i.female age agexfem

*Note that, since female and sex represent the same indicator, this is equivalent to:
regress workhrs_ft i.sex age agexfem

*While this did not take too long (hopefully), we've had to make a few tweaks to generate the interaction manually. In Stata, a more common way to specify an interaction is by using the hashtag (#) to indicate that we wish to interact two variables in a model. To avoid confusion, we need to make sure we tell Stata which variable types we are dealing with (c. for interval and i. for categorical):

regress workhrs_ft i.sex c.age i.sex#c.age

*We can also make it even shorter by using the double hashtag (##), which tells Stata to include the main effects of both variables as well as their multiplication:

regress workhrs_ft i.sex##c.age

*Make sure it is clear to you that the four regression commands above all give exactly the same output, and why. 

*Let's move on to the interpretation of this model. In this week's lecture, we saw an example of a model with an interaction between two binary variables. However, in this case, age is continuous. How do we interpret this?

*The "main effect" coefficients on sex and age represent the association between each variable and working hours when the other variable is equal to 0.
/*
	Among individuals aged 0, females work on average 3.36 hours less than males (note: this is correct although it does not make too much sense to interpret, as no full-time worker is 0 years old)
	
    Among males (female = 0), each additional year of age is associated with an increase in working hours by 0.085 
So what about the interaction? We can read it in two ways:
	
    If we are interested in how age moderates the association between sex and working hours, we can conclude that the negative association between being female and working hours is stronger (i.e., more negative) at older ages compared to younger ages. Each additional year of age makes the association more negative by 0.033 hours.
	
    If we are interested in how sex moderates the association between age and working hours, we can conclude that the positive association between age and working hours is weaker (i.e., more negative) for females compared to males. Among females, the coefficient on age is 0.085 – 0.033 = 0.052. In other words, working hours still increase with age for females, but not as much as for males
*/

*This is generally how you interpret interaction coefficients in multiple linear regression. However, remember to always check the statistical significance of an interaction term! In this case, the p-value for the interaction coefficient is 0.456. That is, it is unlikely that age moderates the association between sex and work hours in the population (and vice-versa, sex does not appear to moderate the association between age and working hours).

*You're now ready to test for moderation on your own. You can try by answering the following question:

//## Q8) Does being married moderate the association between self-rated health and income? Test this hypothesis using the ADRC_S dataset. Make sure you describe the relevant variables, and interpret the results.
*Tip: you can use variables married, log_inc, and health, which we have generated throughout the course.










//# 3. Adding polynomial terms

*We will finish this exercise by learning how to generate and add polynomial terms to a regression model. Polynomial terms are positive-integer powers of interval-level variable x, such as the square (x^2) or cubic (x^3) transformation. They are quite useful when we need some flexibility on the linearity assumption.

*Let's start by replicating the example in the lecture, once again, of income by age.
First, since we are good social scientists, we plot our data and check the plausibility of a linear vs. quadratic association by overlaying a line and a quadratic curve, respectively.

//## Q9) Just like you did last week, produce a scatter plot of log_inc on age, adding a line of best fit (tip: you can go back to your code from week 9).









*Adding a quadratic fit can be done in just the same way, the only difference being that we need to type qfit instead of lfit in the command for Q9. Can you do it yourself? 

//## Q10) Now add a quadratic fit to the scatter plot. Which of the two looks like a better "fit" for the data?









*If you agree with me that a quadratic fit looks more suitable for this data, then the next step is to generate a quadratic term for age. This is done by typing:

gen agesq = age^2
label var agesq "age squared"

*Next, we add it to the model alongside age (as usual, "main effects" should be included):
regress log_inc age agesq

*Note that, in the lecture, we restricted the sample to individuals with valid cases on workstat (a variable we generated in week 2). 
* In case you've lost it, the code to generate workstat was:

recode econstat (-9 -8 =.) (1/3 = 1) (4/11 = 0), gen(workstat)
label var workstat "working status"
label define worklab 0 "not working" 1"working"
label values workstat worklab

*To replicate the results from lecture 10 you can type:

regress log_inc age agesq if workstat!=.

//## Q11) Making use of the lecture material, interpret the association between age and log of income in your own words.









*Note that it is easy to generate and add polynomials. We could generate the cubic term of age by typing gen age_cube = age^3, and add it to the model alongside age and age squared. However, in practice, one seldom needs to include polynomials beyond the square.




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


