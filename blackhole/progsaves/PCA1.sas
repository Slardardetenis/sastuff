/*	!Principal Components Analysis!
	Esses dados foram retirados do seu exemplo de PCA
	no curso de Análise multivariada como segue o link abaixo:
	
	http://wiki.icmc.usp.br/images/7/70/ComponentesPrincipais.pdf
		
*/

*libname learn "/folders/myshortcuts/blackhole/newlib";

data expca;
	*infile "/folders/myshortcuts/blackhole/pratticc1.txt";
	input	x1 x2 x3;
datalines;
9893 564 17689
8776 389 17359
13572 1103 18597
6455 743 8745
5129 203 14397
5432 215 3467
3807 385 4679
3423 187 6754
3708 127 2275
3294 297 6754
5433 432 5589
6287 451 8972
run;

title "Principal Components Analysis from expca";

proc print data = expca;
run;

proc factor data = expca
simple
method=prin
priors=one
nfactors=3
/* mineigen=1 */
scree
/* rotate=varimax */
round
flag=.40
out = newtable;
var x1 x2 x3;
run;

title " data(=xpca) with factors(=principal components)";

proc print data = newtable;
run;