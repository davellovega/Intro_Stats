
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 1 Lab
The Basics of Stata
•	Opening and closing Stata
•	Opening datasets in Stata
•	Finding your way around Stata
•	Using do-files 
•	Checking variables
•	Missing values
•	Getting additional help with Stata

 
Prepared by: Dalia Avello-Vega
*/

////////////////////////////////////////////////////////////////////////////////

//# Preparing the session:

cls
macro drop _all
clear all
set more off

************************************************************************************************************
************************************************************************************************************

**NOTE: Please complete steps 1 to 4 according to instructions on Lab1 Assignment document on Learn


************************************************************************************************************
************************************************************************************************************

//##	5. Exploring the data

use 8888888 insert here the link to the first dataset (Learn: Course Information) 888888

//### 5.1 Browse

/*
Type browse in the command window (or run it from the do-file). This opens a new window, which gives you an overview of the dataset. The columns are variables and the rows the observations for the respondents. The first column is the unique ID number for the respondent (Case identifier). Hover the mouse over the variables' names on the right hand side of the screen (Variables window). This tells you more fully what data each variable contains.
*/

//### Q1: What is the full variable label for id?

////////////////////////////////////////////////////////////////////////

//### Q2: What is the full variable label for relate?

////////////////////////////////////////////////////////////////////////

//### Q3: What is the full variable label for educ?

////////////////////////////////////////////////////////////////////////

//### Q4: What is the full variable label for ghealth?

////////////////////////////////////////////////////////////////////////


//### Q5: What is the full variable label for rgsc?

////////////////////////////////////////////////////////////////////////

*Each row contains the answers for a single respondent.  Each respondent only has one row.  This means that the number of rows equals the number of respondents. Looking around the Stata interface, find out how many respondents there are in this dataset. 

//### Q6: How many respondents are there in the dataset?

////////////////////////////////////////////////////////////////////////

//##	5.2. Variable names
*In the variables window you find the short name of each variables. Each variable name must be unique. The variable names cannot start with a number. These names are quite short because you will be typing them into syntax and it is easier if they are not too long. By convention, we generally keep variable names to a maximum of 8 alphanumeric characters if we can. 

*5.3. Values 
*In your browse window, you will note that there are two identifier variables. Variable id contains the unique number assigned to each respondent. The same is true for variable ID. However, variable id is numeric, while variable ID is a "string". String variables are variables that do not treat their values as numbers. Stata can contain string variables, but in order to analyse them they will need to be transformed into numbers.

* As an example, consider the following two variables: REGION and hh_govreg. Try the following:

browse REGION hh_govreg

*In the browse window, click on the values of each variable. What is the difference? REGION does not have numeric values assigned to it, and cannot be analysed in Stata. It tells you where each respondent lives, but you cannot use it for analysis. By contrast, hh_govreg has numeric values assigned to each region, and can be analysed.

*We will only analyse numeric variables, i.e. data that have been entered into Stata as numbers. Some of these numbers are true numbers, such as age in years or income in pounds. Others are codes that stand for categories, such as sex or marital status.

*Stata can only conduct analyses with numerical data. You can assign codes such as "male" and "female" to numerical values of 1 and 2, and Stata will be able to manipulate these in ways that it could not if you had entered M and F as letters.

*Consider the sex variable.  Type browse sex. If you click on female, you will see that `2' appears; while when you click on male, `1' appears.

*A better way to explore how the variables are coded is to use codebook. Type codebook sex to find the values of the sex variable. Now, do the same with some other variables in the dataset to answer the following questions:

codebook sex


//### Q7: What numbers are used as category codes in the marstat variable?

////////////////////////////////////////////////////////////////////////

//### Q8: What number would you give someone who has never been married in the marstat variable?

////////////////////////////////////////////////////////////////////////

//### Q9: What does a number 3 mean in the ghealth variable?

////////////////////////////////////////////////////////////////////////

* codebook works great for variables with a few values, but if there are more than 10 values it will just give you a "selection" of them. For example, variable educ has 19 unique values, which you can find out using:

codebook educ

*If you want all of them displayed, then you can type:

codebook educ, tab(20)  //this  tells Stata to tabulate 20 values of the variable


************************************************************************************************************
************************************************************************************************************

//##	6. Missing values

*You will have noticed from the codebook command box that some variables (such as educ and ghealth) have special codes (such as "-9: never went to school"; or "-9: refused").

*Commonly, negative values such as -9, -8, (or -9999 in some surveys) are used to indicate "non-valid" data, i.e. data that does not make sense for that case. In the example of educ, it does not make sense to code the highest educational attainment for someone who is still in school. In the example of ghealth, some people may refuse to answer the question about their health.


//### Q10: What numbers indicate non-valid data in the econstat variable?

////////////////////////////////////////////////////////////////////////


*These are what we call missing values. This means that they are not valid responses to the questions. Stata will not know how to exclude these values from the analysis of this variable. Therefore, we have to replace the missing value with a `.' 

*We can do this for the ghealth variable. First, it is always a good idea to create a "clone" of this variable, so that we do not lose the original data. 

*We can start by typing

clonevar health = ghealth //This generates an identical clone of ghealth called health. 

*You can type
 browse ghealth health // to check that it worked.
 
replace ghealth =. if ghealth ==-8
replace ghealth =. if ghealth ==-9

*Now
codebook health
* What has changed?

************************************************************************************************************
************************************************************************************************************

//##	7. Other commands and additional exploration

*Make sure you familiarise yourself with the variables in this dataset and how they are coded. We will be using this dataset for many of the workshops in this module.

*The Variable Manager also gives you a quick access to information about the variables and their labels:
*Window => Variables Manager

*The following commands are useful to explore the dataset in addition to browse and codebook:

list 
*Allows you to examine the full dataset in the results window. It is not very convenient in a large dataset like the one we are using but you can use some options to make the output of list more tractable, like listing only some variables:
list sex age


*describe reports some basic information about the dataset and its variables (size, number of variables and observations, storage type of variables, etc.)
*If you run describe all by itself, you'll get a description of all the variables in the data set:
*If you had many variables, the describe output would be very long. Remember you can press 'q' or click on the red stop sign button to have Stata quit what it is doing.
*If you want information about a specific variable, put its name right after describe:

describe age

*With so many variables, it can be hard to find what you need in a large dataset. One useful trick:

describe *hoh*
*This will describe all variables that contain "hoh" (= household head) anywhere in their name. 


//### Q11: How many variables are included in the dataset?

////////////////////////////////////////////////////////////////////////

//### Q12: What variable measures social class of the household head? What are its category code numbers and corresponding value labels?

////////////////////////////////////////////////////////////////////////

//### Q13: Is there a variable on ethnicity? If so, name it.
////////////////////////////////////////////////////////////////////////

//### Q14: Is there a variable on country of birth? If so, name it.
////////////////////////////////////////////////////////////////////////

************************************************************************************************************
************************************************************************************************************


//##	8. Saving and closing

*Save your work before you close the program.
*In the drop-down menu, you can go to File => Save As. However, the best way to do it is from your do-file:

save "ADRC_S_modified.dta", replace

/*
We give the dataset a new name (because we have changed it). Provided that you have set a working directory at the start, Stata will save it in your own directory.

Remember to also save your do-file.

You can now exit Stata. 
*/


