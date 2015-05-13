/*
Programmer: Giovani (Slardar de Tênis)
Date:  may/12/2015

Description: Multiple Comparisons.
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

filename tapete "/folders/myshortcuts/blackhole/carpet.csv";

data learn.carpet;
	infile "/folders/myshortcuts/blackhole/carpet.csv"	dsd;
	input	dura 
			carpet 
			compos $;
run;

title "Data set carpet from minitab";

proc print data = learn.carpet;
run;

proc freq data = learn.carpet;
	tables carpet*compos;
run;

proc means data = learn.carpet;
	var dura;
run;

title1 'Nitrogen Content of Red Clover Plants';
data clover;
	input strain $ nitrogen @@;
	datalines;
3DOK1  19.4 3DOK1  32.6 3DOK1  27.0 3DOK1  32.1 3DOK1  33.0
3DOK5  17.7 3DOK5  24.8 3DOK5  27.9 3DOK5  25.2 3DOK5  24.3
3DOK4  17.0 3DOK4  19.4 3DOK4   9.1 3DOK4  11.9 3DOK4  15.8
3DOK7  20.7 3DOK7  21.0 3DOK7  20.5 3DOK7  18.8 3DOK7  18.6
3DOK13 14.3 3DOK13 14.4 3DOK13 11.8 3DOK13 11.6 3DOK13 14.2
COMPOS 17.3 COMPOS 19.4 COMPOS 19.1 COMPOS 16.9 COMPOS 20.8
;
run;

*proc print data = clover;
*run;

/*
means "var with the class" / "kind of test I want";
o alpha padra é 5%;
In the most of cases the key of tests are abbreviated so...
tukey = tukey
bon = bonferroni
scheffe =scheffe

we the two layot to show the results from the multiple comparisons
"lines" and "clidiff";

*/
/*
proc anova data = clover;
	class strain;
	model nitrogen = strain;
	means strain / tukey bon scheffe alpha = 0.05 lines;
run;	
*/
title ;

ods graphics on;
proc anova data = learn.carpet;
	class carpet;
	model dura = carpet;
	means carpet / tukey bon scheffe lines;
run;





