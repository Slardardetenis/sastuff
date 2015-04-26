/*
Programmer:	Giovani C R
Date:	02/02/2015

description:	chapter 5 (Creating formats and labels) from
				Sas for programmers
*/
libname	learn "/folders/myshortcuts/blackhole/newlib";

data learn.test_scores;
	length ID $3 name $15;
	input ID score1-score3 name;
	label	ID = 'student ID'
			score1 = 'math score'
			score2 = 'science score'
			score3 = 'english score';
datalines;
1 90 95 98 Milton
2 78 77 75 Washington
3 88 91 92 Smith
;	
run;

proc print data = learn.test_scores;
run;

proc contents data = learn.test_scores;

