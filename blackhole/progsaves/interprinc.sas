/*import data from internet web site*/

libname learn "/folders/myshortcuts/blackhole/newlib";

data treta;
	infile "/folders/myshortcuts/blackhole/pratticc1.txt";
	input	x1 x2 x3;
run;

title "vamo";

proc print data = treta;
run;

PROC FACTOR DATA = treta
SIMPLE
METHOD=PRIN
PRIORS=ONE
MINEIGEN=1
SCREE
ROTATE=VARIMAX
ROUND
FLAG=.40 ;
VAR x1 x2 x3;
RUN;