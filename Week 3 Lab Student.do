
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 3 Lab:
- Visualising interval variables (histograms, density plots, boxplots)
- Visualising categorical variables (bar charts)
- Percentages and cummulative percentages using *fre*
- Two-way tables using *tab*

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

//#1.	Visualising distributions for interval variables

*In this week's lecture we defined interval level (continuous and discrete) variables as variables that can be expressed in numerical terms, and can either take an infinite (continuous) or finite (discrete) number of values within some range. We have also covered some of the main ways to visualise distributions for interval variables. Let's review them in Stata.

*/
//## Histograms 

*Last week we learned how to produce a histogram for the continuous variable age in our dataset. If you can, try to answer the following questions without looking at your code from last week (but taking a peek is fine as well).


//### Q1) Make a histogram showing the percentage distribution of age and containing exactly 70 bins (bars)

%%%%%%%%%%%%

//### Q2) Make a histogram showing the frequency distribution of age and containing 50 bins 
%%%%%%%%%%%%


*In this week's lecture we learned about a property of histograms and distributions: the skewness. The Stata command summarize, which we learned last week, tells us about the skewness of a distribution for any interval level variable by specifying the detail option.
*/

sum age, detail

/*
This gives a value of 0.245 for "skewness". How do we interpret it? 
•	A symmetric distribution has a skewness value of 0
•	A right-skewed (positive skewed) distribution has a skewness value above 0
•	A left-skewed (negative skewed) distribution has a skewness value below 0

Knowing this, answer the following questions:
*/

//### Q3) Make a frequency distribution histogram for working hours, which are measured by the variable workhours. From visual inspection of the histogram, describe the skewness of working hours, as well as any modal points.
%%%%%%%%%%%%
%%%%%%%%%%%%

*From the histogram, the distribution appears to have a right long tail, suggesting a positive skew. Modal values are around 36-39.

//### Q4) Now using sum, find the value for the skewness of the working hours distribution. Does it confirm your conclusions from the visual inspection?

%%%%%%%%%%%%

//##	Density plots
/*Over the past couple of weeks, we have also introduced density plots, which show the distribution of a variable over hypothetically infinite points (i.e., for an infinite number of bins of a histogram). Because of this property, density plots are only appropriate for continuous (not discrete) variables. In Stata, we can obtain density plots using the kdensity command:
*/

kdensity age

/*
This produces density estimates for the variable age, and plots the result. Note that the density needs to be estimated first because, in the dataset, we do not have infinite points for age within its range (we have 99 unique values between 0 and 98). If you'd like to know more about Kernel density estimates, and their comparison to histogram, the Stata manual has a nice description with references. This can be accessed simply by typing
*/
help kdensity

*It is also possible to overlay a density plot over a histogram. This can be done using:

hist age, kdensity

//## Boxplots
/*
In this week's lecture we have also introduced a complementary graph to the histogram, which plots the median and interquartile range of a variable. This is called a boxplot, and can be obtained in Stata using the graph box command. Let's make a boxplot for age:
*/
graph box age

/*
This is a vertical box plot, showing the median, interquartile range, as well as adjacent values range of age (for definitions of these, refer to the Lecture 3 slides). It also shows that age does not have any outliers outside the adjacent values range. This boxplot is identical to what we saw in this week's lecture, except for its vertical (rather than horizontal) orientation. We can make a HORIZONTAL boxplot in Stata using graph hbox:
*/

**Note the H in front of the word box in the command**
graph hbox age

*We can check that the boxplot is giving us exactly the same information as our summary statistics for the median and IQR that we learned last week. 

//### Q5) Using the sum command, derive the median and interquartile range for age. Then, produce a horizontal box plot for age. Do they give the same results? What are the median and IQR of age?
%%%%%%%%%%%%
%%%%%%%%%%%%

%%%%%%%%%%%%

*Next, using the commands you've learned, answer the following questions:

//### Q6) Make a box plot for working hours. What are the median and IQR for this variable? Does this variable have outliers?
%%%%%%%%%%%%
%%%%%%%%%%%%

*Next, we want to examine the distribution of the variable hoh_inc, which expresses the income of the household head. If we codebook this variable, we see that its range of values goes from -9 to 8175.

codebook hoh_inc

*We know that, by definition, someone's income cannot be negative. Therefore, we should explore negative values further. We can type:

codebook hoh_inc if hoh_inc<0

*which gives us the values and labels of the variable when it is below 0. We find that -9 indicates "refused" and -8 indicates "not applicable". Thus, we need to set these values to missing (= .  in Stata). We do so using the commands we know from last week:

clonevar head_inc = hoh_inc
replace head_inc = . if head_inc<0

**Note that there are various possible ways to achieve this. An alternative would have been:

recode hoh_inc (-9 -8 = .), gen(head_inc)

*Either way, we have created a new variable called head_inc which has missing values where hoh_inc has negative values.

//### Q7) Make a box plot for income of the household head, expressed by the variable head_inc that we have generated. Are there outliers? Where do they lie? What does this tell us about the skewness of the distribution of income of the household head in the data?

%%%%%%%%%%%%
%%%%%%%%%%%%

*All the outliers in the distribution of income lie on the right, which gives evidence of a positive skew for the distribution.

*The median and IQR for working hours are 38 and 43 – 27 = 16, respectively. The variable has some outliers, mainly concentrated on the right-hand side. 


***********************************************************************************************

//# 	2. Visualising distributions for categorical/qualitative/count variables

*As we have discussed this week, the best way to visualise categorical (nominal, binary, and ordinal) variables is to use bar charts. The Stata command for this is graph bar, with the over() option.

*Last week we generated a new variable called ecstat, which measures the economic status of respondents. The code for generating this variable is in section 5.1 of the previous assignment: make sure you have it in your dataset before continuing. 

*Using codebook and tab, answer the following:

//### Q8) What type of categorical variable is ecstat? Nominal, ordinal, or binary?
%%%%%%%%%%%%
%%%%%%%%%%%%

%%%%%%%%%%%%

//### Q9) How many values can this variable take? What is its modal value?
%%%%%%%%%%%%


//### Q10) How many observations have missing values on ecstat?
%%%%%%%%%%%%



*Now that we know a bit more about ecstat, let's graph its distribution using a bar chart.

graph bar, over(ecstat)

*Stata's default is to have horizontal value labels in graph bars, but in this case these are hard to read. We can modify the value labels to a 45 degree angle using the graph editor. First, open the graph editor, and then click on the labels. Under "label angle" in the top menu, select 45°. Alternatively, we can use Stata code to modify labels:

graph bar, over(ecstat, label(angle(45)))

*An even better option, which doesn't put strain on your readers' necks and requires no modifications, is simply to flip the graph to horizontal bars using graph hbar:

graph hbar, over(ecstat)

*Just as in histograms, we can choose whether we want frequencies or percentages displayed. The Stata default for bar charts is percentages, and we can obtain frequencies by specifying:

graph hbar (count), over(ecstat)


//### Q11) Using the commands you have learned, make a bar chart showing percentages in each sex. What percentage of respondents are female?
%%%%%%%%%%%%
%%%%%%%%%%%%

//### Q12) Make a frequency bar chart for marstat, indicating marital status. Approximately how many respondents are married?
%%%%%%%%%%%%
%%%%%%%%%%%%

***********************************************************************************************

//# 3.	Percentages and cumulative percentages using fre

*While Stata has many built-in commands, often we need to rely on user-written commands, that have been written by researchers for a specific purpose and are then added to Stata. These user-written commands need to be installed before using.

*Last week we learned Stata's built-in command tabulate. Today we will see a simple but useful user-written command that complements tabulate for one-way frequency tables, called fre.

*Let's install this command using:

ssc install fre

*This opens a list of potential candidates, of which you click and install the first one. Note that, for this, you need an internet connection. Once you have installed a command in your Stata package, you won't need to install it again. Having installed fre, let's check the differences with tab:

tab ecstat
fre ecstat

/*
fre has two main advantages over tab: 
i)	in its basic form, it displays the number and percentage of missing values, as well as two types of percentages, both for the total number of observations in the data, and for the "valid" cases (i.e., those with no missing values). 
ii)	It always displays both the values and the labels of a variable (while tab only displays values). In our dataset this is not crucial, since values were labelled such that they also contain the corresponding value number. However, in most datasets, this is not the case and fre can save you a lot of time going back and forth between values and labels!
*/

*In this week's lecture, we learned about cumulative percentages. Now using fre, answer the following questions:

//### Q13) Consider variable rgsc, which describes individuals' social class. What type of variable is this (nominal, ordinal, or binary)?
%%%%%%%%%%%%

*This is an ordinal variable, with social classes ordered from the highest (professionals) to the lowest (unskilled) in terms of occupational prestige.

//### Q14) How many missing values does rgsc have? What percentage of missing values are missing? 
%%%%%%%%%%%%

//### Q15) What percentage of people are in the skilled manual class? In answering this question, only consider valid (non-missing) cases.
%%%%%%%%%%%%

//### Q16) What percentage of people are in skilled manual or higher occupations? In other words, what cumulative percentage of people are in skilled manual occupations?
%%%%%%%%%%%%

//### Q17) What percentage of people are in managerial/technical or higher occupations?
%%%%%%%%%%%%

//# 4.	Contingency tables using tab

*Finally, this week we learned about contingency tables as a way of summarising the relationship between two (often categorical) variables. In today's example, we want to explore the association between variables sex and earnings, where earnings measures the gross weekly earnings of respondents grouped into 9 categories (from 0 to the highest).

*Let's start as usual by describing the values of these variables

codebook sex

codebook earnings, tab(20)

*The coding of sex is fine (no non-valid values), but we can see that earnings has some non-valid responses ("refused" and "not applicable"). Thus, using code that we learned over the past few weeks, we recode it into a new variable called earn_cat that has the same categories but missing values as "."

clonevar earn_cat = earnings
replace earn_cat = . if earn_cat<0

codebook earn_cat

*After checking that the recoding worked, we now want to produce a contingency table of earn_cat by sex. This is done using a command we already know: tabulate.

tab earn_cat sex

*This gives you a contingency table of frequencies, where each number tells us the number of people who are in each possible combination of earnings bands and sex. Note that missing values have been left out of the table.

*In the lecture we learned about row and column percentages. These are very helpful if we want to compare the distribution of a variable across different values of the other.
*Let's start with row percentages:

tab earn_cat sex, row

*This tells us the percentages in each category of sex for each group defined by the row variable (earnings). 

*If we want to obtain column percentages, we type instead:

tab earn_cat sex, col

*This tells us the percentages in each category of earnings for each group defined by the column variable (sex). 

*By looking at these contingency tables, answer the following questions:

//### Q18) What percentage of individuals who earn nothing (nil) is male? What percentage of those earning nothing is female?
%%%%%%%%%%%%

//### Q19) What percentage of men earn nothing? What percentage of women earn nothing?
%%%%%%%%%%%%

//### Q20) What percentage of men earn 350.01 or more? What percentage of women earn 350.01 or more?
%%%%%%%%%%%%

//### Q21) What can we conclude from the contingency table in terms of the association between earnings and sex?

%%%%%%%%%%%%

*Lastly, note that if you wish to obtain both row and column percentages in the same table, you can do so:

tab earn_cat sex, row col

*By default, Stata will always put row percentages above column percentages, no matter the order in which you specify these options.


*Save your changes!!!

save "ADRC_S_modified3.dta", replace



