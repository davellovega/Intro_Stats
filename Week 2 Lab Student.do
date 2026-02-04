STOP

////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science

Semester 2, 2026
Week 2 Lab:
- Tabulations
- Histograms
- Measures of Central Tendency (mean, median, mode)
- Measures of Dispersion (range, Interquartile range, standard deviation, variance)
- Generating variables

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
/*
//## From previous week:

* 5) Missing values

clonevar health = ghealth

br health ghealth // check that it worked

replace health = . if ghealth==-9
replace health = . if ghealth==-8

codebook health

*/

//#  2. TABULATIONS

/*
Last week we used frequency tables (using codebook) to explore how different variables were coded. This week, we will produce tabulations with a different purpose: to explore the distribution of the variables.
Today we are interested in the distribution of the variable age in the ADRC_S dataset. Starting from the commands we know, we can type:
*/

br age
codebook age


//### Q1) What is the range of values of age?
******************************

//### Q2) How many unique values does age have in this dataset?
******************************

*Age has many values, and no value labels. In this case, value labels are not necessary because each number represents exactly it value (a year of age). Still, codebook gives you a description of this variable, including its range and how many values are missing (that is, how many values are set as = .) 

//### Q3) How many missing values does age have?
******************************

*We can create a table to display all possible values of age
&&&&&&&&&& //tabulate age

//### Q4) How many people are 13 years old in the dataset? How many are 93 years old?
*In order to make a table displaying all the possible values of age, we can use tabulate (or tab for short).

tab age


//### Q5) What percentage of people are aged 13? What percentage are aged 93?


*Using your own code, answer the following questions about variable workhours.

//### Q6) What is the variable label for workhours?
&&&&&&&&&&


//### Q7) What is the range of workhours, and how many unique values does it have?
&&&&&&&&&&

 //### Q8) How many missing values does workhours have? What is a potential explanation for why these values are missing?
 
 //### Q9) How many people in the dataset work exactly 35 hours per week? What percentage of people does that correspond to?
&&&&&&&&&&


//# 3. HISTOGRAMS
*These will help us VISUALISE the distribution of age in the dataset

&&&&&&&&&& // this gives the density distribution of age (by default)

/*density scales the height of the bars so that the sum of their areas equals 1. This is not very convenient to interpret, and we might want to change this default so that the height of the bars represents frequencies (number of observations) or percentages
*/

&&&&&&&&&&
&&&&&&&&&&

/*we might want to change the number of bins (or BARS or BUCKETS) that group the data in a histogram
*/

&&&&&&&&&&
&&&&&&&&&&

 //### Q10) How do the two histograms with 20 and 99 bins compare? What are the advantages and disadvantages of having a higher number of bins in a histogram?
 
 
*Let's say that I want to see a quick summary, so I want to put lots of data in just a few bins:
&&&&&&&&&&

*The histogram might look smooth and concise, but it may mask subtle patterns, such as small secondary peaks or skeweness. It may oversimply the distribution. So, I tried many more narrower bins"
&&&&&&&&&&

 //## Saving graphs in STATA
 
 *They won't save automatically, you need to save using the icon OR File > Save as...
 *Default is light blue backgrounds. You can change settings by using the Main Stata Menu File > Start Graph Editor
 *There are also commands you can use to change your default settings, for example:
 
graph set window fontface "Garamond"
graph set pdf fontface "Garamond"
graph set ps fontface "Garamond"

* Or you can go back to the defaults
graph set window fontface default
 

//# 4. MEASURES OF CENTRAL TENDENCY AND DISPERSION

/* To derive measures of central tendency (Mean, Median, Mode) and measures of dispersion (Variance and Standard Deviation, Range (Max - Min) and interquartile range (75th - 25th percentiles) in Stata you can use:
*/

 //## Summarize
&&&&&&&&&&

 //### Q11) What is the mean age of people in the ADRC_S data?

 //### Q12) What is the standard deviation of age?

 //### Q13) What is the range of age?

*If we want more details that the default version of summarize, we can add [, detail]

&&&&&&&&&&
 
 //### Q14) What is the median age in the dataset?

 //### Q15) What is the interquartile range?

 //### Q16) What is the value of the variance of age?

*You can also calculate the variance of age using the SD we obtained before, to do it you just need to use Stata as a calculator 

*The SD was 23.91541 
&&&&&&&&&&

*Other examples of using Stata as a calculator...
&&&&&&&&&&
&&&&&&&&&&

*However, there is one measure that did not appear when we used summarize: MODE! 
*There is no specific command to obtain the mode in Stata, but we can use one of two strategies:

*Strategy 1: 'manual'
&&&&&&&&&& // go through the values of age and check which one has the highest frequency/percentage of observations

*Strategy 2: 'New MODE variable'
&&&&&&&&&& // generate a new variable that takes the mode of age as its value
*Then we tabulate the new variable:
&&&&&&&&&& //the new variable modage takes the same value (equal to the mode) for all observations in the data

***HOMEWORK:
 //### Q17) Find the mean, median, and mode number of working hours in the dataset

 //### Q18) Find the standard deviation, variance, range, and interquartile range for working hours

&&&&&&&&&&
&&&&&&&&&&
&&&&&&&&&&



//# 5. GENERATING VARIABLES

/*
To calculate the mode, we generated a new variable (modage) using *egen* 
Last week we also generated a new variable (health) by "cloning" an existing one (ghealth) using *clonevar*

Now we explore some of the main ways to generate or modify a variable
*/


//##5.1 Clonevar and generate and replace

*clonevar = generate a 'clone' variable that you can modify  without risk of losing the original information

*Example: Generate a new version of econstat (which measures the economic status of the respondent) that sets invalid values ("refused" and "not applicable") as missing ("."):

&&&&&&&&&&
&&&&&&&&&& //ecstat is the new variable
&&&&&&&&&& // in Stata | means 'OR'
*This reads... replace the values of ecstat to missing if the values are -9 or -8. The rest stays the same
&&&&&&&&&&

&&&&&&&&&&  //This option used after tab tells Stata to show you the missing values in the tabulation

*Alternatively, you could have asked Stata to:

&&&&&&&&&& // no real changes made, because we've already replaced those values above

*OR*

&&&&&&&&&& // and again, just another way to do it

*Now we will create another identical variable, ecstat2, using a different command, *generate* or *gen*

&&&&&&&&&&
&&&&&&&&&&
&&&&&&&&&&
&&&&&&&&&&
&&&&&&&&&&

*Now we can compare the two:

&&&&&&&&&&
&&&&&&&&&&
&&&&&&&&&&

//### Q19) What is the main difference between the two variables ecstat and ecstat2 in the way they were generated?

//##5.2 Recode

/* We may also want to generate a variable that takes different values from the existing one (not necessarily equal to missing). Say we just want to create an indicator of whether someone is working or not based on econstat.
We want the new variable – which we will call workstat – to take value 1 if someone is working, and 0 otherwise. We also want to set invalid values (refused and non applicable) as missing.
*/

&&&&&&&&&& //We check the values that econstat takes, the optin (13) ensures that the command codebook displays all 13 unique values of the variable.

*Now we ask Stata to recode the values of econstat, but with some changes:

*values -9 and -8 ("refused" and "not applicable") become . (missing)
*1, 2, and 3 ("working" ; "working yt, et"; and "govsch coll-base") become 1
*all values from 4 to 11 (all non-working categories) become 0
* using these new codes, generate a new variable called workstat !Important because otherwise we would have modified the original instead

&&&&&&&&&&

**RULE TO REMEMBER: always specify gen(newvar) after recode!

*Let's chech that it worked:
&&&&&&&&&&
&&&&&&&&&&

*It worked, but! the labels are missing...

//## 5.3 Labels
/*
Labels are important when working with complex data, as we might forget what the variables names mean or what the values of each variable indicate. 
For workstat, the variable indicates "working status"; its values indicate "not working" (0) and "working" (1).
Variable labels indicate what the variable as a whole represents. These are assigned using *label var*:
*/

*For exampke, we want to label the variable and values of workstat
&&&&&&&&&& //First we label the variable workstat
&&&&&&&&&&

*Then we want to label the values to know what they represent. These are assigned first by defining a "value label" (in this case, we create one named worklab); then, assigning the value label to variable workstat using *label values*:

&&&&&&&&&&  //For this binary variable, we define that values of 0 mean "Not working" and values of 1 mean "working"
&&&&&&&&&& //Here we say, for variable workstat, label the values using the label worklab (like work labels...)

*Check that it worked:
&&&&&&&&&&
&&&&&&&&&&


**Additional example:
 /* I want to group people by age bands instead of having the continuous values, particulatly, I want to know who is either over or under 65:
*/

&&&&&&&&&& //Take age variable and generate a new variable called "age65". Anyone aged 0-64 will get coded as 0, anyone 65 and over will get coded as 1.
&&&&&&&&&& //here I label the new variable 
&&&&&&&&&& //here I create a value label called yesno
&&&&&&&&&& //here I apply the yesno value labels to age65, so now you will see "no" and "yes"

&&&&&&&&&&
&&&&&&&&&&

**Once you are finished, make sure to overwrite the "modified" version of the dataset (remember, we don't touch the original).**

save "ADRC_S_modified.dta", replace



