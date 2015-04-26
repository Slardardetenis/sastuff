/* principal components analysis ....cibele russo*/

libname learn "/folders/myshortcuts/blackhole";

filename seercode URL "http://www.seer.cancer.gov/siterecode/icdo3_d01272003/index.txt";

data siterecode;
infile seercode truncover;
input @1 bigline $char256.;
run;

proc print data = siterecode;
run;