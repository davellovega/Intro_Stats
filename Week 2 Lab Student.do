STOP

////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science

Semester 2, 2026
Week 2 Lab:
•	Tabulations 
•	Histograms
•	Measures of central tendency (mean, median, mode)
•	Measures of dispersion (range, interquartile range, standard deviation, variance)
•	Generating variables

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
use "ADRC_S_modified.dta", clear

****************************************************************************************************
****************************************************************************************************
****************************************************************************************************




//#  2. TABULATIONS

/*
Last week we used frequency tables (using codebook) to explore how different variables were coded. This week, we will produce tabulations with a different purpose: to explore the distribution of the variables.

Today we are interested in the distribution of the variable age in the ADRC_S dataset. Starting from the commands we know, we can type:
*/

br age
codebook age

*From the above code, answer the following questions:

//### Q1) What is the range of values of age?


//### Q2) How many unique values does age have in this dataset?



*Age has many values, and no value labels. In this case, value labels are not necessary because each number represents exactly it value (a year of age). Still, codebook gives you a description of this variable, including its range and how many values are missing (that is, how many values are set as = .) 

//### Q3) How many missing values does age have?

*In order to make a table displaying all the possible values of age, we can use tabulate (or tab for short).

tab age



//### Q4) How many people are 13 years old in the dataset? How many are 93 years old?



//### Q5) What percentage of people are aged 13? What percentage are aged 93?


*Using your own code, answer the following questions about variable workhours.

//### Q6) What is the variable label for workhours?
&&&&&&&&&&


//### Q7) What is the range of workhours, and how many unique values does it have?
&&&&&&&&&&

 //### Q8) How many missing values does workhours have? What is a potential explanation for why these values are missing?
 
 &&&&&&&&&&
 
 //### Q9) How many people in the dataset work exactly 35 hours per week? What percentage of people does that correspond to?
&&&&&&&&&&


//# 3. HISTOGRAMS
*Next, let's create a histogram to visualise the distribution of age in the dataset. Simply type:

histogram age

/*By default, this generates a graph showing the density distribution of age. The density scales the height of the bars so that the sum of their areas equals 1. This is not very convenient to interpret, and we might want to change this default so that the height of the bars represents frequencies (number of observations) or percentages. We can do that by typing:
*/

hist age, frequency
hist age, percent


*We may also want to change the number of bins (bars) of the histogram. This is done using the option:

hist age, percent bin(20)
hist age, percent bin(99) 


 //### Q10) How do the two histograms with 20 and 99 bins compare? What are the advantages and disadvantages of having a higher number of bins in a histogram?
 
 

 //## Saving graphs in STATA
 
*Note that Stata does not automatically save your graphs. If you want to be able to go back to a graph you've created, you need to save it yourself (by clicking on the "save" icon or going through File > Save as…).

*Stata renders graphs in its default outlook, with light-blue backgrounds. If you'd like to change that, you can open the graph editor by clicking on the graph editor icon of the graph menu, or selecting File > Start graph editor. This is pretty easy to use. You can play around with changing the background colour of the histogram, which you can do by double-clicking on the light blue area and selecting "color" under "region". 

*You can also add a title, or change the colour of the bars of the histogram. Feel free to explore this feature in your own time!

*Note: Stata will not let you progress any further (in terms of commands, do-files, or anything else, really) until you close the graph editor.

 

//# 4. MEASURES OF CENTRAL TENDENCY AND DISPERSION

/* In this week's lecture we learned about three measures of central tendency: the mean, the median, and the mode. Let's see how we can derive them in Stata.


 //## Summarize
 
 Now that we have plotted the distribution of age, we may be interested in summarising its values in terms of central tendency and dispersion. Remember, in this week's lecture we learned about the following measures of central tendency
•	Mean
•	Median
•	Mode
And the following measures of dispersion
•	Variance and standard deviation
•	Range (maximum – minimum)
•	Interquartile range (75th percentile – 25th percentile)
*/
 
summarize age
*or simply
sum age

*The output from this command gives us some of the above measures.

 //### Q11) What is the mean age of people in the ADRC_S data?
 
 
&&&&&&&&&&

 //### Q12) What is the standard deviation of age?

&&&&&&&&&&
 //### Q13) What is the range of age?

&&&&&&&&&&

*We may want some more details than what the default summarize output gives us. We can ask Stata:

sum age, detail
 
 //### Q14) What is the median age in the dataset?

 &&&&&&&&&&
 
 //### Q15) What is the interquartile range?

 &&&&&&&&&&
 
 //### Q16) What is the value of the variance of age?

 &&&&&&&&&&
 
*Note that we could also calculate the variance of age from the standard deviation that we obtained from the default summarize output, if we use Stata as a calculator. We know the variance is the square of the standard deviation, and we can just type:

display 23.91541^2

*Other examples of using Stata as a calculator...

display 2+2
dis sqrt(571.9466)


*We now know how to derive most of the statistics above using summarize, but there is one left: the mode. Unfortunately, Stata does not have a built-in command that calculates the mode, but if we need to, we have two ways of obtaining it. You already know the first:

tab age

*You can go through the values of age and check which one has the highest frequency/percentage of observations. This, however, may be unfeasible if there are too many values. We can therefore generate a new variable that takes the mode of age as its value using egen:

egen modage = mode(age)

*and then we tabulate this new variable:
tab modage

*Note that the new variable modage takes the same value (equal to the mode) for all observations in the data. 
*Now we know how to obtain all our measures of central tendency and dispersion.

*In your own time, answer the following questions about the workhours variable.

 //### Q17) Find the mean, median, and mode number of working hours in the dataset

 &&&&&&&&&&
 
 
 //### Q18) Find the standard deviation, variance, range, and interquartile range for working hours

&&&&&&&&&&


//# 5. GENERATING VARIABLES

/*
For calculating the mode, we generated a new variable (modage) using egen. Last week, if you remember, we also generated a new variable (health) by "cloning" an existing one (ghealth) using clonevar. Generating new variables is an essential component of a Stata project. Let's review some of the main ways for generating and modifying variables:

*/


//##5.1 Clonevar and generate and replace

*As we saw last week for our general health variable, clonevar allows you to generate a "clone" of a variable that you can later modify using replace. It is always a good idea to create clones before changing the variables, so that you do not lose the original information. In the following example, we wish to generate a new version of econstat (which measures the economic status of the respondent) that sets invalid values ("refused" and "not applicable") as missing (".").


tab econstat
clonevar ecstat = econstat
replace ecstat = . if ecstat==-9 | ecstat==-8
tab ecstat
tab ecstat, m  

/*
A few things to note here: 
i)	| means "or" in Stata (while & means "and")
ii)	The option ,m after tab tells Stata to show missing values in the tabulation
iii)	Because of the way ecstat is coded, the third line of code is equivalent to:
*/
replace ecstat = . if ecstat<0

*or similarly

replace ecstat = . if ecstat<-7


*Now let's generate an identical variable, ecstat2, using a different command, generate.

tab econstat
gen ecstat2 = econstat
replace ecstat2 = . if ecstat2==-9 | ecstat2==-8
tab ecstat2
tab ecstat2, m  

*Now we can compare the two:

codebook ecstat ecstat2
tab ecstat 
tab ecstat2


//### Q19) What is the main difference between the two variables ecstat and ecstat2 in the way they were generated?




//##5.2 Recode

/* We may also want to generate a variable that takes different values from the existing one (not necessarily equal to missing). Say we just want to create an indicator of whether someone is working or not based on econstat.

We want the new variable – which we will call workstat – to take value 1 if someone is working, and 0 otherwise. We also want to set invalid values (refused and non applicable) as missing.

Follow this code, and check that you understand what it is doing:

*/

codebook econstat, tab(13)
recode econstat (-9 -8 =.) (1/3 = 1) (4/11 = 0), gen(workstat)

/*
First, we have used codebook to check which values econstat takes. The option tab(13) ensures that codebook displays all the 13 unique values of the variable. Then we have asked Stata to recode the values of econstat so that 

•	-9 and -8 ("refused" and "not applicable") become . (missing)
•	1, 2, and 3 ("working" ; "working yt, et"; and "govsch coll-base") become 1
•	All values from 4 to 11 (all non-working categories) become 0

And, using these new codes, generate a new variable called workstat. Note that, had we not specified the gen(workstat)option, Stata would have simply recoded the existing variable econstat with the new codes. It is always a good idea to leave the original variables as they are, so make sure you always specify gen(newvar) after recode, where newvar is the name of the new variable you aim to generate. Let's check that it worked by typing:

*/
tab workstat
tab workstat econstat

*It worked, but! the labels are missing...

//## 5.3 Labels
/*
Labels are important when working with complex data, as we might forget what the variables names mean or what the values of each variable indicate. For workstat, the variable indicates "working status"; its values indicate "not working" (0) and "working" (1).

•	Variable labels indicate what the variable as a whole represents. These are assigned using label var:

*/


label var workstat "working status"

*	Value labels indicate what each value of the variable represent. These are assigned first by defining a "value label" (in this case, we create one named worklab); then, assigning the value label to variable workstat using label values.

label define worklab 0 "not working" 1"working"
label values workstat worklab

*We can check that everything worked by typing 
tab workstat
*or
codebook workstat


**Once you are finished, make sure to overwrite the "modified" version of the dataset (remember, we don't touch the original).**

save "ADRC_S_modified.dta", replace



