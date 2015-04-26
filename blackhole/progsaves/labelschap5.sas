/*
Programmer: Giovani C R
Data: Feb/07/2015

description: Chapter 5: Labels
*/
libname learn "/folders/myshortcuts/blackhole/newlib";

data learn.survey;
	input ID gender $ age salary ques1 $ ques2 $ ques3 $ ques4 $ ques5 $;
	datalines;
	001 M 23 28000 1 2 1 2 3
	002 F 55 76123 4 5 2 1 1
	003 M 38 36500 2 2 2 2 1
	004 F 67 128000 5 3 2 2 4
	005 M 22 23060 3 3 3 4 2
	006 M 63 90000 2 3 5 4 3
	007 F 45 76100 5 3 4 3 3
	;
run;

proc format;
	value $gender	'M'	= 'Male'
					'F'	= 'Female'
					' '	= 'Not entered'
				other	= 'Miscoded';
				
	value age	low-29	= 'less than 30'
				30-50	= '30 to 50'
				51-high	= '51+';
	
	value $likert	'1'	= 'Strongly disagree'
					'2' = 'Disagree'
					'3'	= 'No opinion'
					'4' = 'Agree'
					'5'	= 'Strongly agree';
					
	value	$three	'1','2'	=	'Disagreement'
					'3'		=	'No opinion'
					'4','5'	=	'Agreement';	
run;		

title " data set survey with formatted values";

proc print data = learn.survey;
	id ID;
	var gender age salary ques1-ques5;
	format	gender		$gender.
			age			age.
			ques1-ques5	$three.
			salary		dollar11.2;
run;	

proc freq data = learn.survey;
	title	"Question Frequencies Using the $three format";
	tables	ques1-ques5;
	format ques1-ques5 $three.;
run;	
