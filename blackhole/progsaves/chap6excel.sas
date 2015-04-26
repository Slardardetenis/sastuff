/*
Programmer:	Giovani C R
Date:		Feb/09/2015

description:	chapter 6: Reading and Wrinting Data from an
				Excel Spreadsheet
*/

libname learn "/folders/myshortcuts/blackhole/newlib";

/** Import an XLS file.  **/

PROC IMPORT DATAFILE="/folders/myshortcuts/blackhole/issoae"
		    OUT= learn.xlstest
		    DBMS=XLS
		    REPLACE;
RUN;

PROC PRINT DATA = learn.xlstest (firstobs=3 obs=4);
RUN;

ods	csv	file='/folders/myshortcuts/blackhole/test_scores.csv';

proc print data=learn.test_scores noobs;
run;
ods csv close;

