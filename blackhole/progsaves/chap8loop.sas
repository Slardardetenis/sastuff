/*
Programmer:	Giovani Carrara Rodrigues
Date_:	Feb/16/2015

Discription:	Chapter 8:	Performing Iterative Processing: Looping
8.1 Introduction 117
8.2 DO Groups 118
8.3 The Sum Statement 120
8.4 The Iterative DO Loop 125
8.5 Other Forms of an Iterative DO Loop 129
8.6 DO WHILE and DO UNTIL Statements 131
8.7 A Caution When Using DO UNTIL Statements 134
8.8 LEAVE and CONTINUE Statements 135
8.9 Problems 137
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

/*
data grades;
	length	gender	$ 1
			quiz	$ 2
			agegrp	$ 13;
	infile '/folders/myshortcuts/blackhole/grades.txt';
	input age gender midterm  quiz finalexam;
	if missing(age) then delete;
		if Age le 39 then Agegrp = 'Younger group';
		if Age le 39 then Grade = .4*Midterm + .6*FinalExam;
		if Age gt 39 then Agegrp = 'Older group';
		if Age gt 39 then Grade = (Midterm + FinalExam)/2;
run;
*/

*you could do like above or like below;

data grades1;
	length	gender	$1.
			quiz	$2.
			agegrp	$13.;
	infile '/folders/myshortcuts/blackhole/grades.txt';
	input age gender midterm quiz finalexam;
	if missing(age) then delete;
	if age le 39 then do;
		agegrp	= 'younger group';
		grade = .4*midterm + .6*finalexam;
	end;
	else if age gt 39 then do;
		agegrp = 'older group';
		grade = (midterm + finalexam)/2;
	end;
run;

title "Listing of Grades1";
proc print	data=grades1 noobs;
run;

/*
data revenue;
	retain total 0;
	input	day		:	$3.
			revenue	:	dollar6.;
	if not missing(revenue) then Total = total + revenue;
	format	revenue total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed .
Thu $2,000
Fri $3,000
;
run;

title 'Listing of REVENUE';
proc print data=revenue;
var day revenue total;
run;

*/
/* Or you can do like that using "a sum statement"

variable + increment;

Notice there is a plus sign and no equal sign in this statement. That’s what identifies this
as a sum statement to SAS. This statement does the following:


.Variable is retained
.Variable is initialized at 0
.Missing values (of increment) are ignored
*/


data revenue;
	input 	Day : $3.
			Revenue : dollar6.;
	Total + Revenue;
	format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed .
Thu $2,000
Fri $3,000
;
run;

title 'Listing of REVENUE';
proc print data=revenue;
run;

data test;
	input x;
	if missing(x) then misscounter + 1;
datalines;
2
.
7
.
;
run;

title "test for miscounter";
proc print data = test;
run;
	
data compound;
	Interest = .0375;
	Total = 100;
	
	Year + 1;
	Total + Interest*Total;
	output;
	
	Year + 1;
	Total + Interest*Total;
	output;
	
	Year + 1;
	Total + Interest*Total;
	output;
	
format Total dollar10.2;
run;

title "Listing of COMPOUND";
proc print data=compound noobs;
run;	
	
/*
or you can do using an iterative DO loop like this:
*/

data compound1;
	interest = 0.375;
	total = 100;
	do year = 1 to 3;
		total + interest*total;
		output;
	end;
	format total dollar10.02;
run;

title "Listing of COMPOUND1";
proc print data=compound noobs;
run;

data table;
	do	n = 1 to 10;
		square = n*n;
		squareroot = sqrt(n);
		output;
	end;
run;

title "table os squares and square roots";
proc print data = table noobs;
run;

data equation;
	do	x = -10 to 10 by .5;
		y = 2*x**3 - 5*x**2 + 15*x -8;
		output;
	end;
run;

title "equation";
proc print data = equation;

/*
ERROR: Procedure GPLOT not found.
It looks like I don't have this proc -_-, :(
 
symbol value=none interpol=sm width=2;
title "Plot of Y versus X";
proc gplot data=equation;
plot Y * X;
run; 
*/

data easyway;
	do group = 'Placebo','Active';
		do subj = 1 to 5;
			input score @; *how to work this @ at chapter 21, section 11;
			output;
		end;
	end;	
datalines;
250 222 230 210 199
166 183 123 129 234
;
run;

title 'Like a virgin';
proc print data = easyway;
run;

data easyway_alter;
	do group = 'Placebo';
		do subj = 1 to 10;
			input score @; *how to work this @ at chapter 21, section 11;
			output;
		end;
	end;	
datalines;
250 222 230 210 199
166 183 123 129 234
;
run;

title "easyway_alter";
proc print data = easyway_alter;
run;

data	easyway_alter1;
			input score @@; *how to work this @ at chapter 21, section 11;
			output;	
datalines;
250 222 230 210 199
166 183 123 129 234
;
run;

title "treta loca";
proc print data = easyway_alter1;
run;

data double;
	interest 	=	0.375;
	total		=	100;	
	do year = 1 to 100 until(total gt 200);
		total = total + interest*total;
		output;
	end;
	format total dollar10.2;
run;

proc print data = double;
	title "double data";
run;


 	
	

	
	


	

		