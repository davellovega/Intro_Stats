
STOP
////////////////////////////////////////////////////////////////////////////////

/*
Introduction to Statistics for Social Science
Semester 2, 2026

Week 4 Lab
Sampling and normal distributions:
•	Simple random sampling using Stata
•	Normally distributed variables and how to check for normality
•	Transforming non-normally distributed variables
•	Obtaining Z-scores
 
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

//#1.	Simple random sampling in Stata
/*
In this week's lecture we learned about different sampling methods, including convenience, simple random, and stratified random sampling. Convenience sampling consists in sampling cases in the target population that are readily available (e.g., friends, relatives, or acquaintances), and does not result in representative samples. By contrast, random sampling is regarded as the benchmark for achieving representativeness because, in a random sample, all observations in the population have equal probability of being selected for the sample, and therefore the characteristics of the sample and the population are, on average, similar. Simple random sampling consists in picking cases at random from the target population. Stratified random sampling consists in sub-dividing the population into groups based on certain traits or characteristics, and then sampling at random within those groups.

Without using Stata code, start by answering the following questions:

I am interested in studying attitudes towards immigrants among people living in Scotland in 2022. Therefore, I collect a sample of 20 people among my colleagues at the University of Edinburgh, and interview them about their attitudes towards immigrants. 


*/


//### Q1) What sampling method have I adopted?

**////////////////////////////////////////////////////////////////////////
 

//### Q2) What would be an appropriate sampling frame for my study?

**////////////////////////////////////////////////////////////////////////
  

//### Q3) Is my sample likely to be representative of the target population? Why? Why not?

**////////////////////////////////////////////////////////////////////////


//### Q4) Is there likely to be any bias in my estimates of attitudes towards immigrants? What potential sources of bias can you think of for this specific sampling method and topic?

**////////////////////////////////////////////////////////////////////////


//##	1.1.	Simple random sampling from the ARDC_S dataset

/*
Stata allows you to sample at random from any dataset. For today's example, we will use the ADRC_S dataset as usual, but we will pretend that we are dealing with a whole population rather than a sample of 5,049 people. As we know, the target population is usually unobservable to researchers, so we just have to use our imagination and pretend that we actually have access to the entire British population. Another way to view this exercise is that our target population is – in fact – the ADRC_S population, from which we take random samples. 

From previous weeks, we know that the mean age in the ARDC_S is 38.88. This is our "population parameter" for mean age:

μ_age=38.88

Let's start by taking a random sample of 10% of our ADRC_S population:
*/

sample 10

//### Q5) Check the properties window of Stata. How many observations does the dataset have now? 

////////////////////////////////////////////////////////////////////////


**////////////////////////////////////////////////////////////////////////


//### Q6) What is the mean age in the sample?

** !!  !!  ////////////////////////////////////////////////////////////////////////


*Note that the answer to Q6 is likely to differ for everyone in the lab. This is not a mistake! When taking random samples, Stata literally picks observations at random, and this process differs across instances of Stata. 

*In order to obtain the same result across people (and allow other people in the future to replicate our findings) we need to "set the seed" in Stata. This specifies the initial value for the random number generator.

*Let's go back to the full ARDC_S dataset by typing:

clear all 
use "ADRC_S_modified.dta"

*Now we can set the seed, deciding to all start from the same number, say 17 (I like 17, but I could have picked any other number, such as 2 or 100 or 4628456.)

set seed 17

*Then we take a 10% sample:

sample 10


//### Q7) What is the mean age in the sample? Check that it is the same as what your classmates obtained.

////////////////////////////////////////////////////////////////////////


**////////////////////////////////////////////////////////////////////////



*Again, we type the following to go back to our starting dataset:

clear all 
use "ADRC_S_modified.dta"


*So far we have taken a 10% random sample of the ARDC, but what if we want to take a sample of a specific size? Say we want to take a sample of size 15. This is done using:

set seed 17
sample 15, count



//### Q8) What is the mean age in the random sample of 15 people? Is it closer or farther away from the population parameter of 38.88 than the mean obtained from the sample containing 10% of the population? 

////////////////////////////////////////////////////////////////////////


**////////////////////////////////////////////////////////////////////////


*Lets' go back to the full dataset before answering the following question:

clear all 
use "ADRC_S_modified.dta"


//### Q9) Now take another random sample of 15 people, but set a seed of your choice other than 17. What is the mean age of people in this sample? Does it differ from the mean age in the sample obtained from a starting seed of 17? Why?

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


**Again, the answer will depend on the seed you set. With a seed of 100, I obtain a mean of 37.13, which differs from the previous estimate obtained with a starting seed of 17 (29.47). Given that both are random samples, and of the same size (n = 15), the only reason why the answer differs is sampling variability. The estimate from the random sample obtained from a starting seed of 100 comes much closer, by chance, to the true population estimate (38.88).



*Finally, before we move on, remember to ask Stata to clear the sub-sample dataset and go back to the original dataset:

clear all 
use "ADRC_S_modified.dta"

/*
A couple of take-home points from this exercise:

	Larger sample sizes usually help get closer to the true population parameters. The samples containing 10% of the population (around 500 people) are more likely to get better estimates of μ_age than those only containing 15 people.

	Sampling variability (or sampling error) is inevitable. Even though random samples are the benchmark for ensuring representativeness and carry no bias due to sampling method, it is unlikely that any of us obtained estimates exactly equal to the true population parameter of 38.88 for the mean (if you did, congrats on your random sampling luck!)
*/


***********************************************************************************************

//# 2.	The Normal distribution

/*
This week we also learned about a special type of distribution: the Normal distribution. Characterised by a "bell" shape, the Normal distribution has the following properties: 

i)	symmetric (no skew): mean = median = mode 
ii)	only defined by its mean and standard deviation
iii)	continuous and asymptotic

//## 2.1.	Assessing normality 

Normally distributed variables are particularly nice to deal with in Statistics, because they can be synthesised using only two parameters (mean and standard deviation) among other things. Normally distributed variables have particularly useful properties for conducting statistical inference, which we will explore more throughout the course. Often, it is useful to check for normality in the distribution of continuous variables. 

Among the continuous variables in our dataset we have age as well as the number of working hours (workhours). Last week (week 3 lab) we generated a variable called head_inc, which is a "clean" version of the income of the household head, which is also continuous. We now want to check how close the distributions of these three variables come to a Normal curve.

The first way to go about it is by visual inspection. For age, we can check similarity to the Normal curve by typing:
*/

hist age, normal

*The option normal adds a normal curve to the plot, which allows us to check how close the data come to a normal distribution. In the case of age in the ADRC dataset, the data follow the normal curve quite closely only at older ages, but there are too many observations at young ages and not enough in the middle of the distribution to conclude that this variable is normally distributed. To confirm our visual inspection, we type:

sum age, detail

*As we know already, the variable age has a right-skewed distribution (skewness = 0.245). This is not a large value for the skewness, but it tells us that the distribution is not perfectly symmetric. Below the skewness you can find another value of interest: the kurtosis, which is a measure of the heaviness of the tails of the distribution. A Normal distribution has a kurtosis value of 3. Anything below has "lighter" tails, anything above has "fuller" or "heavier" tails. In the case of age, we can see that the kurtosis is 2.16. Again, as we have concluded from the visual inspection, this is not too far from normality, but not exactly normally distributed.

*Now using these two tools, answer the following questions:

//### Q10) From visual inspection, how does the distribution of working hours compare to a normal distribution? 

////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////


**////////////////////////////////////////////////////////////////////////

//### Q11) Obtain the values of skewness and kurtosis for working hours. Do they confirm the conclusions from your visual inspection?

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



//### Q12) Now do the same for the variable head_inc, which you generated in week 3. Is its distribution far or close to a normal distribution (relative to age and working hours)?

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


**The distribution of household head income is very far from a Normal curve. It is "truncated" at zero and strongly skewed to the right, and its values are strongly concentrated at lower incomes (<500 per week). 
**The value of skewness is 9.45 (very different from 0); and the value of kurtosis is 177.71 (very different from 3). 


***********************************************************************************************

//## 2.2.	The log transformation
 /*

Dealing with heavily skewed (strongly non-normal) distributions in continuous variables is tricky, because the large number of outliers and make it hard to meaningfully summarise the data. There is, however, a trick we can use to make heavily skewed continuous variables assume a more "normal" shape without substantially altering their meaning. This is the log transformation, which means taking the natural logarithm of the variable.

We have seen that head_inc is heavily right-skewed, which is often the case with income variables since income cannot go below 0, and there are usually few individuals with very high incomes. We can now generate a new variable, log_inc, which is the natural logarithm of head_inc. This is done using the tools we know:
*/

gen log_inc = ln(head_inc)

*In the above code, ln( ) indicates the natural logarithm. Let's label the variable:

label var log_inc "log of hh head income"

*Now let's assess the normality of this new variable. 

hist log_inc, normal
sum log_inc, detail


//### Q13) How close is the distribution of the variable log_inc to a Normal distribution? What are its skewness and kurtosis values? Has the transformation worked in rendering the income variable closer to "normal"?

**////////////////////////////////////////////////////////////////////////



/*A couple of things to keep in mind about the log transformation:

•	The values of any log-transformed variable will need to be exponentiated in order to be interpreted (e.g., exponentiate log_inc to obtain back income in GBP).
•	The natural logarithm of zero or of a negative number does not exist. As such, the log transformation is only applicable to variables with only positive values. More complex transformations exist for approximating a Normal distribution for variables that take zero and negative values.

*/

//### Q14) How many missing values does head_inc have? How many missing values does log_inc have? Why do you think that is?

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


//# 3.	Standardisation

/*
Standardisation (obtaining Z scores) converts the values of interval variables into "standard deviations from the mean". 
For any interval level variable, Z scores can be calculated using the formula:

     (x_i  - x ̅)
Z=  /
     s_x 

In Stata, we can obtain standardised variables (where all values are converted into Z scores) by using the std formula within egen. Say we want to obtain the standardised version of age, and we want to call it z_age. We can use:
*/

egen z_age = std(age)

*Conveniently, Stata automatically labels this variable "Standardized values of age", as you can see by typing:

describe z_age

*Using your own Stata code, answer the following questions:

//### Q15) What is the mean of z_age? Make sure you use an appropriate command to derive it.

////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////




//### Q16) What is the standard deviation of z_age? Make sure you use an appropriate command to derive it.


**////////////////////////////////////////////////////////////////////////


//### Q17) Make a histogram for z_age. How does it compare to the histogram for age?

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////



**They have exactly the same shape:


*That's it for today! As usual, we overwrite our modified version of the dataset:


*Save your changes!!!

save "ADRC_S_modified3.dta", replace



