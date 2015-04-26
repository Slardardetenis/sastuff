libname learn "/folders/myshortcuts/blackhole/newlib";
libname myfmts "/folders/myshortcuts/blackhole/formatlib";

options fmtsearch = (myfmts.chap5format);

data learn.survey;
	infile	'/folders/myshortcuts/blackhole/survey1.txt';
	input	ID		:	$3.
			gender	:	$1.
			age
			salary
			(ques1-ques5) (: $1.);

	format	gender		$gender.
			age			age.
			ques1-ques5	$likert.
			salary		dollar10.0;

	label	ID		=	'Subject ID'
			gender	=	'gender'
			Age		=	'Age as of 1/1/2006'
			Salary	=	'Yearly Salary'
			Ques1 	=	'The governor is doing a good job?'
			Ques2	=	'The property tax should be lowered'
			Ques3	=	'Guns should be banned'
			Ques4	=	'Expand the Green Acre program'
			Ques5	=	'The school needs to be expanded';
run;

title 'Data set survey';
proc contents data = learn.survey varnum;
run;

title "Using User-defined formats";

proc freq data = learn.survey;
	tables	ques1-ques5 / nocum;
run;

proc print data = learn.survey;
run;




