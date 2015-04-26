filename eita "/folders/myshortcuts/blackhole/bank.txt";

data financial;
	infile eita;
	input	@1	Subj		$3.
			@4	DOB			mmddyy10.
			@14 Gender		$1.
			@15 Balance		7.;
run;

proc print data = financial;
	format	DOB		mmddyy10.
			Balance	dollar11.2;
run;

 
		
	