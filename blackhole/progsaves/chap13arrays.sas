/*
Programmer: Giovani Carrara Rodrigues
Date: April/04/2015

Description: Chapter 13 Working with Arrays
"""Real Page 278"""
13.1
13.2 Introduction 244
Setting Values of 999 to a SAS Missing Value for Several Numeric
Variables 244
13.3 Setting Values of NA and ? to a Missing Character Value 247
13.4 Converting All Character Values to Lowercase 248
13.5 Using an Array to Create New Variables 249
13.6 Changing the Array Bounds 250
13.7
13.8 Temporary Arrays 251
Loading the Initial Values of a Temporary Array from a Raw
Data File 253
13.9 Using a Multidimensional Array for Table Lookup 254
13.10 Problems 257
*/

%let gg = giovani;

libname learn "/folders/myshortcuts/blackhole/newlib";

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

/*****Good thinking below xD
Cody’s rule of SAS programming goes something like this: 
If you are writing a SAS program, and it is becoming very tedious, stop. 
There is a good chance that there is a SAS tool, perhaps arrays or macros, 
that will make your task less tedious.
*****/

data learn.careless;
	input score name $ ans1 $ ans2 $ ans3 $;
datalines;
100 COdY A b c
65 sMITH C C d
95 scerbo D e D
;
run;

proc print data = learn.careless;
title "laern.careless";
run;

data lower;
	set learn.careless;
	array all_chars{*} _character_;
	do i = 1 to dim(all_chars);
		all_chars{i} = lowcase(all_chars{i});
	end;
	drop i;
run;

proc print data = lower;
title "lower";
run;

data temp;
input Fahren1-Fahren24 @@;
array Fahren[24];
array Celsius[24] Celsius1-Celsius24;
do Hour = 1 to 24;
Celsius{Hour} = (Fahren{Hour} - 32)/1.8;
end;
drop Hour;
datalines;
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75
72 66 55 53 52 50 45
;
run;

proc print data = temp;
title" temp";
run;

data account;
	input ID income1999-Income2006;
	array income{1999:2006} income1999-income2006;
	array taxes{1999:2006} taxes1999-taxes2006;
	do year = 1999 to 2006;
		taxes{year} = .25*income{year};
	end;
	drop year;
	format	income1999-income2006
			taxes1999-taxes2006 dollar10.;
datalines;
001 45000 47000 47500 48000 48000 52000 53000 55000
002 67130 68000 72000 70000 65000 52000 49000 40100
;
run;

proc print data = account;
title "account";
run;

* Temporary Arrays;

data score;
array ans{10} $ 1;
array key{10} $ 1 _temporary_
('A','B','C','D','E','E','D','C','B','A');
input ID (Ans1-Ans10)($1.);
RawScore = 0;
do Ques = 1 to 10;
RawScore + (key{Ques} eq Ans{Ques});
end;
Percent = 100*RawScore/10;
keep ID RawScore Percent;
datalines;
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;
run;

proc print data = score;
title "score";
run;

data learn.score1;
array ans{10} $ 1;
array key{10} $ 1 _temporary_;
/* Load the temporary array elements */
if _n_ = 1 then do Ques = 1 to 10;
input key{Ques} $1. @;
end;
input ID (Ans1-Ans10)($1.);
RawScore = 0;
/* Score the test */
do Ques = 1 to 10;
RawScore + (key{Ques} eq Ans{Ques});
end;
Percent = 100*RawScore/10;
keep ID RawScore Percent;
datalines;
ABCDEEDCBA
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;
run;

proc print data = learn.score1;
title "learn.score1";
run;

* Using a Multidimensional Array for Table Lookup;

data learn.expose;
	input worker $ Year Jobcode $;
datalines;
001 1944 B
002 1948 E
003 1947 C
005 1945 A
006 1948 D
;
run;

proc print data = learn.expose;
title "learn.expose";
run;

data look_up;
/******************************************************
Create the array, the first index is the year and
it ranges from 1944 to 1949. The second index is
the job code (we're using 1-5 to represent job codes
A through E).
*******************************************************/
array level{1944:1949,5} _temporary_;
/* Populate the array */
	if _n_ = 1 then
	do Year = 1944 to 1949;
		do Job = 1 to 5;
			input level{Year,Job} @;
		end;
	end;
	set learn.expose;
	/* Compute the job code index from the JobCode value */
	Job = input(translate(Jobcode,'12345','ABCDE'),1.);
	Benzene = level{Year,Job};
	drop Job;
datalines;
220 180 210 110 90
202 170 208 100 85
150 110 150 60 50
105 56 88 40 30
60 30 40 20 10
45 22 22 10 8
;
run;

proc print data = look_up;
title "look_up";
run;













