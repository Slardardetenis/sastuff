/*
Programmer: Giovani (Slardar de Tênis)
Date: April/25/2015

Description: Computing frequencies, basic approach.
*/

*libname learn "/folders/myshortcuts/blackhole/newlib";

* Procedimento usado é proc freq;

* Usando o proc freq do jeito que ele vem. Ou seja,
no seu modo padrão, sem especificar nada, ele vai
calcular a frequencia de "todas" variáveis do arquivo;

title " Lets get start xD, Abaixo nossos dados";


data aew;
input 	id 		: 	$3. 
		gender	:	$1.
		age
		salary
		(ques1-ques5) (: $1.);

datalines;
001 M 23 28000 1 2 1 2 3
002 F 55 76123 4 5 2 1 1
003 M 38 36500 2 2 2 2 1
004 F 67 128000 5 3 2 2 4
005 M 22 23060 3 3 3 4 2
006 M 63 90000 2 3 5 4 3
007 F 45 76100 5 3 4 3 3
;
run;

proc print data = aew;
run;

* agora xD;
title "data from aew";

proc freq data = aew;

* agora vamos selecionar as variáveis para calcular frequencia;

title "data from aew";

proc freq data = aew;
	tables gender ques1-ques3 / nocum;
	*essa opção "nocum" ranca a coluna de frequencias acumuladas;
run;

* Não sei se vc chegou a ver isso mas vc pode formatar os valores da sua variável...
quer dizer... vc pode colocar uma saida para cada valor de sua variável xD.. é
um passo um pouquinho avançado xD mas só um pouquinho xD;

* Aqui eu crio os formatos;

proc format;
	value $gender
		'F' = 'Female'
		'M' = 'Male';
	value $likert
	'1' = 'Strongly disagree'
	'2' = 'Disagree'
	'3' = 'No opinion'
	'4' = 'Agree'
	'5' = 'Strongly agree';
run;

title "Adicionando formatos xD";

proc freq data = aew;
	tables gender ques1-ques3;
	
	*agora vou por os formatos novos;
	
	format	gender $gender.
			ques1-ques3 $likert.;
run;

*Agora fazendo frequencias conjuntas...Tipo aquelas
tabelas de distribuição conjuntas lembra ? xD...é só bostar o "*" como
se tivesse plotando os gráficos do R;

title "tabela de frequencias conjuntas";

proc freq data = aew;
	tables gender * ques1-ques3;
run;

* Isso foi o básico e mais um pouquinho. Espero que tenha gostado.
abrass;








 

