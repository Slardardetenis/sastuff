/*
Programmer: Giovani Carrara Rodrigues
Date: April/03/2015

Description:	Chapter 11: Working with numeric functions
"""Real Page is 224"""
11.1 Introduction 190
11.2 Functions That Round and Truncate Numeric Values 190
11.3 Functions That Work with Missing Values 192
11.4 Setting Character and Numeric Values to Missing 193
11.5 Descriptive Statistics Functions 194
11.6 Computing Sums within an Observation 196
11.7 Mathematical Functions 197
11.8 Computing Some Useful Constants 198
11.9 Generating Random Numbers 199
11.10 Special Functions 201
11.11 Functions That Return Values from Previous Observations 204
11.12 Problems 207	
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

