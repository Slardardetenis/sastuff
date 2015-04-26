/*
Programmer: Giovani Carrara Rodrigues
Date: April/03/2015

Description:	Chapter 25: Introducing The SAS Macro Language
"""Real Page 556"""
25.1 Introduction 522
25.2 Macro Variables: What Are They? 522
25.3 Some Built-In Macro Variables 523
25.4 Assigning Values to Macro Variables with a %LET Statement 524
25.5 Demonstrating a Simple Macro 525
25.6 A Word about Tokens 527
25.7 Another Example of Using a Macro Variable as a Prefix 529
25.8 Using a Macro Variable to Transfer a Value between DATA Steps 530
25.9 Problems 532
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

%macro gen(	n,	/* number of random numbers */
			Start, /* Starting value*/
			End,/* Ending value*/);
	/********************************************
		Example: To generate 4 random numbers from
		1 to 100 use:
		%gen(4,1,100)
	*********************************************/
data generate;
do Subj = 1 to &n;
	x = int((&End - &Start + 1)*ranuni(0) + &Start);
	output;
	end;
run;
proc print data=generate noobs;
	title "Randomly Generated Data Set with &n Obs";
	title2 "Values are integers from &Start to &End";
run;
%mend gen;

%gen(4,1,100)




