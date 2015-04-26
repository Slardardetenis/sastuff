/*
Programmer: Giovani Carrara Rodrigues
Date: Mar/21/2015

Description:	Chapter 10: Subsetting and Combining SAS Data Sets
10.1 Introduction 162
10.2 Subsetting a SAS Data Set 162
10.3 Creating More Than One Subset Data Set in One DATA Step 163
10.4 Adding Observations to a SAS Data Set
10.5 Interleaving Data Sets 167
10.6 Combining Detail and Summary Data 168
10.7 Merging Two Data Sets 170
10.8 Omitting the BY Statement in a Merge 172
10.9 Controlling Observations in a Merged Data Set 173
164
10.10 More Uses for IN= Variables 175
10.11 When Does a DATA Step End? 176
10.12 Merging Two Data Sets with Different BY Variable Names 177
10.13 Merging Two Data Sets with Different BY Variable Data Types 179
*/

title3 " the Date is &sysdate9 - The Time is &systime";

libname learn "/folders/myshortcuts/blackhole/newlib";

data learn.survey;
	infile "/folders/myshortcuts/blackhole/survey1.txt";
	input id gender $ age salary ques1-ques5;
run;

proc print data = learn.survey;
	title "Data survey";
	title3 " the Date is &sysdate9 - The Time is &systime";
run;

/*
data females;
	set learn.survey (drop=salary);
	where gender = 'F';
run;
*/

data males females;
	set learn.survey;
	if gender = 'F' then output females;
	else if gender = 'M' then output males;
run;

proc print data = males;
	title "Data males";
run;

proc print data = females;
	title "Data females";
run;

data one;
	*infile datalines;
	input	id		:	$1. 
			name	:	$9. 
			weight	:	3.;
datalines;
7 Adams     210
1 Smith     190
2 Schneider 110
4 Gregory   90
;
run;

proc print data = one;
title "one";
run;

data one1;
	infile datalines;
	input 	@1	id		1.		
			@3	name	$9. 
			@13	weight	3.;
	
datalines;
7 Adams     210
1 Smith     190
2 Schneider 110
4 Gregory   90
;
run;

proc print data = one1;
title "one1";
run;

data two;
	*infile datalines dsd;
	input	id		:	$1. 
			name	:	$9. 
			weight	:	3.;
datalines;
9 Shea    120
3 O'Brien 180
5 Bessler 207
;
run;

proc print data = two;
title "two";
run;

data two1;
	input 	@1	id		$1.		
			@3	name	$7. 
			@13	weight	3.;
datalines;
9 Shea    120
3 O'Brien 180
5 Bessler 207
;
run;

proc print data = two1;
title "two1";
run;	

data one_two;
	set one two;
run;

proc print data = one_two;
title "one_two";
run;

data three;
	input	id		:	$2.
			gender	:	$1.
			name	:	$7.;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;
run;

proc print data = three;
title "three";
run;

data one_three;
	set one three;
run;

proc print data = one_three;
title "one_three";
run;

proc sort data = one; 
	by	id;
run;

proc sort data = two;
	by id;
run;

data interleave;
	set one two;
	by id;
run;

proc print data = interleave;
	title "interleave";
	*by id;
run;

data employee;
	input	id	:	1.
			name:	$10.;
datalines;
1 Smith
2 Schneider
4 Gregory
5 Washington
7 Adams
;
run;

proc print data = employee;
title "Data employee";
run;

data hours;
	input id class $ hours;
datalines;
1 A 39
4 B 44
5 A 35
9 B 57
;
run;

proc print data = hours;
title "Data hours";
run;

proc sort data = employee;
	by id;
run;

proc sort data = hours;
	by id;
run;

data combine;
	merge employee hours;
	by id;
run;

proc print data = combine;
title "Data combine";
run;

data new;
	merge	employee	(in=inemploy)
			hours		(in=inhours);
	by id;
	file print;
	put id = inemploy = inhours = name = jobclass = hours=;
run;

proc print data = new;
title	"new";
run;

data combine2;
	merge	employee(in=inemploy)
			hours(in=inhours);
	by id;
	if inemploy and inhours; 
	*you could have done
	(if inemploy = 1 and hours =1) 
	the outcome would be the same;
run;

proc print data = combine2;
title "combine2 with (in) variables";
run;

data in_both missing_name(drop=name) missing_hours;
	merge	employee(in=inemploy)
			hours(in=inhours);
	by id;
	if	inemploy and inhours
		then output in_both;
	else if inhours and not inemploy
			then output missing_name;
	else if inemploy = 1 and inhours = 0
			then output missing_hours;
run;

proc print data = in_both;
title "in_both";
run;

proc print data = missing_name;
title "missing_name";
run;

proc print data = missing_hours;
title "missing_hours";
run;

data short;
input x;
datalines;
1
2
;
data long;
input x;
datalines;
3
4
5
6
;
data new;
set short;
output;
set long;
output;
run;

proc print data = new;
title "new";
run;

data bert;
	input id x;
datalines;
123 90
222 95
333 100
;
run;

data ernie;
	input empno y;
datalines;
123 200
222 205
333 317
;
run;

data sesame;
	merge	bert
			ernie(rename=(empno=id));
	by id;
run;

proc print data = sesame;
title "sesame - merging with diferent by variable names";
run;

data division1;
	input ss dob $10. gender $;
datalines;
111223333 11/14/1956 M 
123456789 05/17/1946 F 
987654321 04/01/1977 F
;
run;
proc print data = division1;
title "division1";
run;

data division2;
	input	ss		:	$11.
			jobcode	:	$3.
			salary	:	5.;
datalines;
111-22-3333 A10 45123
123-45-6789 B5 35400
987-65-4321 A20 87900
;
run;
/*page 214*/

proc print data = division2;
title "divison2 - data step(:)";
	*format salary dollar11.2;
run;

*Here the first way we can do it...starting with the data division1;

data division1c;
	set division1(rename=(ss=numss));
	ss = put(numss,ssn11.);
	drop numss;
run;

proc print data = division1c;
title "division1c";
run;

data both_divisions;
	merge	division1c
			division2;
	by ss;
run;

proc print data = both_divisions;
title "both_divisions";
	format salary dollar11.2;
run;

*now the other way we can do it from the data division2;

data division2n;
	set division2(rename=(ss = charss));
	ss = input(compress(charss,'-'),9.);
	***Alternative:
	ss = input(charss,comma11.);
	drop charss;
run;

proc print data = division2n;
	title "division2n";
	format salary dollar11.2;
run;

data prices;
	input	@1 itemcode 3.
			@5 description $17.
			@23 price 5.;
datalines;
150 50 foot hose      19.95
175 75 foot hose      29.95
200 greeting card      1.99 
204 25 lb. grass seed 18.88
208 40 lb. fertilizer 17.98
;
run;

proc print data = prices;
	title	"prices";
	format	price dollar7.2; 
run;

data new15dec2005;
	input itemcode price;
datalines;
204 17.87
175 25.11
208 .
;
run;

proc print data = new15dec2005;
	title	"new15dec2005";
	format price dollar7.2;
run;

proc sort data = prices;
	by itemcode;
run;

proc sort data = new15dec2005;
	by itemcode;
run;

data prices_15dec2005;
	update prices new15dec2005;
	by itemcode;
run;

proc print data = prices_15dec2005;
	title "prices_15dec2005 updated";
	format price dollar7.2;
run;




















	
























