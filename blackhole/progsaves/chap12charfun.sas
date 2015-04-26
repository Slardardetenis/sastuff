/*
Programmer: Giovani Carrara Rodrigues
Date: April/04/2015

Description: Chapter 12 working with Character Functions
"""Real Page 26"""
12.1 Introduction 212
12.2 Determining the Length of a Character Value 212
12.3 Changing the Case of Characters 213
12.4 Removing Characters from Strings 214
12.5 Joining Two or More Strings Together 215
12.6
12.7 Removing Leading or Trailing Blanks 217
Using the COMPRESS Function to Remove Characters from a
String 218
12.8 Searching for Characters 220
12.9 Searching for Individual Characters 223
12.10 Searching for Words in a String 223
12.11 Searching for Character Classes 225
12.12 Using the NOT Functions for Data Cleaning 226
12.13 Describing a Real Blockbuster Data Cleaning Function 227
12.14 Extracting Part of a String 228
12.15 Dividing Strings into Words 230
12.16 Comparing Strings 232
12.17 Performing a Fuzzy Match 234
12.18 Substituting Characters or Words 235
12.19 Problems 238
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

data learn.mixed;
	input	@1 name	$13. 
			@15 id	$3.	;
datalines;
Daniel Fields 123
Patrice Helms 233 
Thomas Chien  998
;
run;

data learn.upper;
	input	@1 name	$13.
			@15 dob	$5.;
datalines;
DANIEL FIELDS 2194
PATRICE HELMS 10370
THOMAS CHIEN  14926
;
run;

proc print data = learn.mixed;
title "mixed";
run;

proc print data = learn.upper;
title "upper";
run;

data mixed; 
	set learn.mixed;
	name = upcase(name);
run;

data both;
	merge 	mixed
			learn.upper;
	by name;
run;

data learn.address;
	input 	@1	name	$10.
			@12	street	$20.
			@33	city	$13.
			@47	state   $2.
			@50	zip		$5.;
datalines;
ron   coDY 1178 HIGHWAY 480	    camp verde    tx 78010
jason Tran 123  lake view drive East Rockaway ny 11518
;
run;

proc print data = learn.address;
title "address";
run;

data standard;
	set learn.address;
	name = compbl(propcase(name));
	street = compbl(propcase(street));
	city = compbl(propcase(city));
	state = upcase(state);
run;	
	
proc print data = standard;
title "standard";
run;

*Using compress function to remove characters from a string;

data learn.phone;
	input phone $17.;
datalines;
(908)232-4856
210.343.4757
(516) 343 - 9293
9342342345
;
run;

proc print data = learn.phone;
title "learn.phone";
run;

data phone;
	length phonenumber $10;
	set learn.phone;
	phonenumber = compress(phone,,'kd');*that's a fucking amazing function xD;
	drop phone;
run;
/*
Here are a few examples: If String = "X1y2Z3"
Function Description Value
Returned
compress(String,,'a') Removes all letters 123
compress(String,,'kd') Keeps digits (deletes
everything else) 123
compress(String,'wxyz','i') Removes wxyz and
ignores case 123
compress("A?B C99",,'pd') Removes punctuation
and digits AB C
*/
proc print data = phone;
title "new phone";
run;










	
	
	
	
















