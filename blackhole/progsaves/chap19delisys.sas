/*
Programmer: Giovani Carrara Rodrigues
Date: April/04/2015

Description: Chapter 19 Introducing the Output Delivery System
"""Real Page 432"""
19.1 Introduction 397
19.2 Sending SAS Output to an HTML File 398
19.3 Creating a Table of Contents 400
19.4 Selecting a Different HTML Style 401
19.5 Choosing Other ODS Destinations
402
19.6 Selecting or Excluding Portions of SAS Output 403
19.7 Sending Output to a SAS Data Set 407
19.8 Problems 409
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

ods html 	body = 'body_sample.html'
			contents = 'contents_sample.html'
			frame = 'frame_sample.html'
			path = '/folders/myshortcuts/blackhole/sasreports' (url=none)
			style = fancyprinter;

title "Using ODS to Create a Table of Contents";
proc print data=learn.test_scores;
	id ID;
	var Name Score1-Score3;
run;

proc print data = learn.survey;
	title1 " the Date is &sysdate9 - The Time is &systime";
	title3 "Data survey";

run;

title "Descriptive Statistics";
proc means data=learn.test_scores n mean min max;
	var Score1-Score3;
run;
ods html close;
