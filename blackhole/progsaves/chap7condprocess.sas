/*
Programmer: Giovani C R
Date: Feb/15/2015

Description: Chapter 7:	Performing Conditional Processing
7.1 Introduction 102
7.2 The IF and ELSE IF Statements 102
7.3 The Subsetting IF Statement 105
7.4 The IN Operator 107
7.5 Using a SELECT Statement for Logical Tests 108
7.6 Using Boolean Logic (AND, OR, and NOT Operators) 109
7.7 A Caution When Using Multiple OR Operators 111
7.8 The WHERE Statement 112
7.9 Some Useful WHERE Operators 113
7.10 Problems 114
*/
libname learn "/folders/myshortcuts/blackhole/newlib";

libname myfmts "/folders/myshortcuts/blackhole/formatlib";
options fmtsearch = (myfmts.chap5format);
/*
title "Formats at library myfmts... fmtsearch = (myfmts.chap5format)";
proc format library = myfmts.chap5format fmtlib;
	select age $likert;
run;
*/

data conditional;
	infile datalines;
	length	gender	$1
			quiz	$2;
	input age gender midterm quiz finalexam;
	select;
		when (missing(age)) agegroup = .;
		when (age lt 20) agegroup = 1;
		when (age lt 40) agegroup = 2;
		when (age lt 60) agegroup = 3;
		when (age ge 60) agegroup = 4;
		otherwise;
	end;
	/*
	if missing(Age) then AgeGroup = .;
		else if Age lt 20 then AgeGroup = 1;
		else if Age lt 40 then AgeGroup = 2;
		else if Age lt 60 then AgeGroup = 3;
		else if Age ge 60 then AgeGroup = 4;
		*/
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F . . 76
59 F 95 A+ 97
15 M 88 . 93
67 F 97 A 91
. M 62 F 67
35 F 77 C- 77
49 M 59 C 81
;
title "Listing of conditional";
proc print data = conditional noobs;
run;

data ii2;
	set conditional;
	where age between 20 and 40;
run;
