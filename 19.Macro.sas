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

proc freq data = mirp3.hospitalNew;

tables Admission_Desnsity*sex;
tables Discharge_Desnsity*sex;
run;
%Mend density;

%density






