libname learn "/folders/myshortcuts/blackhole/newlib";

filename vai url "http://www.icmc.usp.br/pessoas/cibele/ModelosLineares/imoveis.dat";

data aew;
	infile vai;
	input va1 va2 va3 va4 va5;
run;

proc print data = aew;
run;


