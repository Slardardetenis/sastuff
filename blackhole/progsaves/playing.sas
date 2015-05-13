/*
Programmer: Giovani (Slardar de Tênis)
Date: April/25/2015

Description: Let's play with SAS.
*/

%let gg = giovani;

libname	learn	"/folders/myshortcuts/blackhole/newlib";

title1 "hi guys";

title2 "lets do it";

proc print data = learn.survey;
run;

proc freq data = learn.survey;
	tables gender * age * ques1 / nocum;
run;

title "proc means with all the defaults";

/*
Every time you gonna use the proc means with
the by statement you have to sort your data set
first.
*/

proc sort data = learn.survey out = sursurvey;
	by gender;
run;

proc means data = sursurvey n nmiss median min max sum mean clm t maxdec=1;
	by gender;
	var age salary;	
run;

/* You can do the same thing like above with the
"class" statement. The diference is that the apperance
of the output is a quite difent and you don't need
to sort the data set before using "class" statement.
*/

*I particulary prefere the first one...by statement;

proc means data = learn.survey n nmiss median min max sum mean clm t maxdec=1;
	class gender;
	var age salary;	
run;














