*/
Programmer: Giovani C R
Date:02/02/1015

description: Learning sas from book Sas for programmers
*/

*libname learn "/folders/myshortcuts/blackhole/newlib";

/*data learn.new;
	set learn.test_scores;
	avescore = mean(of score1-score3);
run;

title "listing of data set new";
proc print data = learn.new;
	var ID Score1-score3 avescore;
run;
*/

data _null_;
	set learn.test_scores;
	file '/folders/myshortcuts/blackhole/outputeste.txt';
	if	score1 ge 86 or score2 ge 86 or score3 ge 86 then
		put ID = score1 = score2 = score3 =;		
run;


