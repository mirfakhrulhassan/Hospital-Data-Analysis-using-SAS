/* Breast Cancer Data Analysis */


/*1. Frequency Distribution for Histologic Grade*/

data mirp3.HistGrade;
set mirp3.Breastcancer;
length Histologic_Grade $10;
if histgrad=1 then Histologic_Grade =  "Grade 1";
if histgrad=2 then Histologic_Grade =  "Grade 2";
if histgrad=3 then Histologic_Grade =  "Grade 3";
if histgrad=4 then Histologic_Grade =  ' ';
run;

proc freq data = mirp3.HistGrade;
table Histologic_Grade;
run;


/*2.Estrogen Receptor Status*/

data mirp3.Estrogen_Recepter;
set mirp3.breastcancer;
length Estrogen_Receptor_Status $10;
if er = 0 then 	Estrogen_Receptor_Status = "Negative";
if er = 1 then 	Estrogen_Receptor_Status = "Positive";
if er = 2 then 	Estrogen_Receptor_Status = ' ';
run;
 
proc freq data = mirp3.Estrogen_Recepter;
table  Estrogen_Receptor_Status;
run;

/*3. Progesterone Receptor Status*/

data mirp3.Progesterone_Receptor;
set mirp3.breastcancer;
length Progesterone_Receptor_Status $10;
if pr = 0 then 	Progesterone_Receptor_Status = "Negative";
if pr = 1 then 	Progesterone_Receptor_Status = "Positive";
if pr = 2 then 	Progesterone_Receptor_Status = ' ';
run;
 
proc freq data = mirp3.Progesterone_Receptor;
table  Progesterone_Receptor_Status;
run;




/*4.Status*/

data mirp3.status;
set mirp3.Breastcancer;
length statuss $10;
if status = 0 then statuss= "Censord";
if status = 1 then statuss= "Died";
run;

proc freq data = mirp3.status;
table statuss;
run;

/*5. PTSC*/

data mirp3.ptsc;
set mirp3.breastcancer;

if pathsize <=3 then PTSC = 1;
if pathsize >3 and pathsize <=5 then PTSC = 2;
if pathsize >5 then PTSC = 3;
if pathsize =. then PTSC = 99;
run;

proc freq data =mirp3.ptsc;
table PTSC;
run;

/*6. Lnodes*/
data mirp3.LNodes;
set mirp3.breastcancer;
length lnodes $10;
if lnpos = 0 then lnodes = "No";
if lnpos>=1 then lnodes = "Yes";
run;

proc freq data = mirp3.LNodes;
table lnodes;
run; 

/*7. AGEGR* and 8. TMGR*/

data mirp3.breastcancer1;
set mirp3.breastcancer;
length AGEGR $20;
if age < = 25 then AGEGR = "<=25 yr";
else if age > 25 and age <=40 then AGEGR = "26-40 yr";
else if age > 40 and age <=50 then AGEGR = "41-50 yr";
else if age > 50 and age <=60 then AGEGR = "51-60 yr";
else AGEGR = "60+ yr";


length TMGR $20;
if time < = 12 then TMGR = "<=12 Mon";
else if time > 12 and time <=24 then TMGR = "12-24 Mon";
else if time > 24 and time <=36 then TMGR = "24-36 Mon";
else if time > 36 and time <=48 then TMGR = "36-48 Mon";
else TMGR = "48+ Mon";
run;

proc freq data = mirp3.breastcancer1;
tables agegr tmgr;
run;

/*9. Correlation*/
proc corr data  = mirp3.breastcancer;
var age time;
run;

/*10. Chi-Square Test*/

proc freq data = mirp3.breastcancer1;
tables AGEGR*TMGR/Chisq;
run;


/* Employee Data Analysis */

/*11. Chisq taste */

proc format;
value minority 1= 'Minority'
			   0 = "Non Minority";
run;

proc freq data = mirp3.employee;
tables minority*jobcat/chisq;
format minority minority.;
run;

proc freq data = mirp3.employee;
tables gender*jobcat/chisq;
run;

proc freq data = mirp3.employee;
tables gender*minority/chisq;
run;

/*12. Histogram by normal curve of Increase (Current Salary - Begin Salary)*/
proc univariate data = mirp3.employee;
var salary salbegin;
histogram/cfill  = gray normal ;
run;

/*13. Mean Median and Standard Deviation of Begin and Current Salary*/
proc means data = mirp3.employee mean median std;
var salbegin salary;
run;

/*14.Scatter Plot : Current salary and begin salary by set marks gender*/
symbol1 v=circle c=red;
proc gplot data = mirp3.employee;
plot salary*salbegin= gender;
run;

/*15. T Test*/
proc ttest data =  mirp3.employee;
paired salary*salbegin;
run;


/* Birth/Death Data Analysis */


/*16. Seasonality for Death*/
proc import datafile = 	'C:\Users\Student3\Desktop\SAS_Class\Birth.xls'
out = mirp3.birth;
run;

proc import datafile = 	'C:\Users\Student3\Desktop\SAS_Class\death.xls'
out = mirp3.death;
run;

proc sort data = mirp3.birth
out = mirp3.birthrd nodup;
by crid;
run;

proc sort data = mirp3.death
out = mirp3.deathrd nodup;
by crid;
run;

proc sql;
create table mirp3.bdij as
select * from mirp3.birthrd inner join mirp3.deathrd
on birthrd.crid = deathrd.crid;
quit;

data mirp3.bd;
set  mirp3.bdij;
length gender $20 newarea $20;
if sex = 1 then gender = "Male";
else gender = "Female";

if area=5 then newarea = "Comparison Area";
else newarea = "Treatment Area";

aadm = (dod-dob)/30.46;
format aadm 6.2;
run;

proc means data = mirp3.bd mean;
var aadm;
run;

proc sort data = mirp3.bd;
by area	sex;
run;

proc surveyselect data = mirp3.bd
n=600 out = mirp3.bd1;
strata area sex/alloc = prop;
run;

proc freq data = mirp3.bd1;
table area*sex;
run;




/*16. Seasonality for Death continued*/
data mirp3.seasonality;
set mirp3.death;
q  =qtr(dod);
if q = 1 then Season = "Winter";
else if q= 2 then Season = "Spring";
else if q = 3 then Season = "Summer";
else Season = "Fall";
run;

proc gchart data  = mirp3.seasonality;
vbar season/discrete;
run;


/*17. Chi-square test*/
proc freq data = mirp3.bd;
tables area*sex/chisq;
run;


/*18. T test*/
proc ttest data = mirp3.bd1 ho = 9.9877;
var aadm;
run;

proc ttest data = mirp3.bd;
class newarea;
var aadm;
run;

/*19 . Macro to Generate Report on Dec 9 , 2018 data reflecting patients' density by 6 hourly;*/
data mirp3.hospitalNew;
set mirp3.hospital;

adm_date=datepart(admdate);
adm_time = timepart(admdate);
dis_date = datepart(DisDate);
dis_time = timepart(DisDate);
adm_day = Day(adm_date);
adm_month = Month(adm_date);
adm_year = Year(adm_date);
dis_day = Day(dis_date);
dis_month = Month(dis_date);
dis_year = Year(dis_date);
adm_hour = hour(adm_time);
dis_hour = hour(dis_time);
length Admission_Desnsity $20;
length Discharge_Desnsity $20;

if adm_hour<=6 then Admission_Desnsity = 'Midnight to 6';
else if adm_hour >6 and adm_hour <=12 then Admission_Desnsity = '7 to 12';
else if adm_hour >12 and adm_hour <=18 then Admission_Desnsity = '13 to 18';
else Admission_Desnsity = '18 to 24';

if Dis_hour<=6 then Discharge_Desnsity = 'Midnight to 6';
else if Dis_hour >6 and Dis_hour <=12 then Discharge_Desnsity = '7 to 12';
else if Dis_hour >12 and Dis_hour <=18 then Discharge_Desnsity = '13 to 18';
else Discharge_Desnsity = '18 to 24';
/* adm_fullDate=MDY(adm_month,adm_day,adm_year); */
format adm_date ddmmyy8.;
run;

%Macro density;
proc freq data = mirp3.hospitalNew order = data;
tables Admission_Desnsity*sex;
tables Discharge_Desnsity*sex;
run;
%Mend density;

%density


 proc print data =  mirp3.hospitalNew;
var name adm_time;

/*where adm_time = '15:12:35'T;*/
where dis_date <= '01JUN16'D;
run;

data mirp3.hospitalm;
set mirp3.hospital;

adm_date=datepart(admdate);
adm_time = timepart(admdate);
dis_date = datepart(DisDate);
dis_time = timepart(DisDate);
length Admission_Desnsity $20;
length Discharge_Desnsity $20;

if adm_time<='06:00:00'T then Admission_Desnsity = 'Midnight to 6';
else if adm_time >'06:00:00'T and adm_time <='12:00:00'T then Admission_Desnsity = '7 to 12';
else if adm_time >'12:00:00'T and adm_time <='18:00:00'T then Admission_Desnsity = '13 to 18';
else Admission_Desnsity = '18 to 24';

if Dis_time<='06:00:00'T then Discharge_Desnsity = 'Midnight to 6';
else if Dis_time >'06:00:00'T and Dis_time <='12:00:00'T then Discharge_Desnsity = '7 to 12';
else if Dis_time >'12:00:00'T and Dis_time <='18:00:00'T then Discharge_Desnsity = '13 to 18';
else Discharge_Desnsity = '18 to 24';
run;

%Macro PTdensity;
proc freq data = mirp3.hospitalm order = data;
tables Admission_Desnsity*sex;
tables Discharge_Desnsity*sex;
run;
%Mend PTdensity;

%PTdensity

proc print data  = mirp3.hospitalm;
where dis_time>'12:00:00'T and Dis_time <='18:00:00'T;
run;

