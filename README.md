# Hospital Data (Breast Cancer, Birth_Death and Employees) Analysis Using SAS

Summary : This repository contains data analysis of a hospital.Data sets are: Breast cancer, birth/death and employee.Various statistical analysis were done on these data sets, like frequency distribution, correlation, chi-square test, histogram, mean, median, standard deviation, scatter plot, t-test, etc. A macro was also created to reflect hospital patients' density by 6 hourly.

Technology Used : SAS and MS PowerPoint


### Breast Cancer Data Analysis:

Frequency Distribution for:
1. Histologic Grade:
          1 = Grade 1,
          2 = Grade 2,
          3 = Grade 3,
          Missing 4 = Unknon.
2. Estrogen Receptor Status:
          0 = Negative,
          1 = Positive,
          Missing 2 = Unknown.
3. Progesterone Receptor Status:
          0 = Negative,
          1 = Positive,
          Missing 2 = Unknown.
4. Status:
          0 = Censored,
          1 = Died.
5. Created new variable PTSC from PATHSIZE (Pathological Tumor Size):
          1 <= 3 cm,
          2 3-5 cm,
          3 >5 cm,
          99 missing.
6. Created a new variable LNODES from INPOS:
          0 = No,
          >=1 Yes.
7. AGEGR age group from age:
          <=25 yr,
          26-40 yr,
          41-50 yr,
          51-60 yr,
          60+ yr.
8. TMGR Time group from Time:
          <= 12 Mon,
          12-24 Mon,
          24-36 Mon,
          36-48 Mon,
          48+ Mon.
9. Correlation between Age and Time.
10. Chi-square test: AGEGR and TIMEGR.


### Employee Data Analysis:

11. Chi-square test:
          a) Minority*Jobcat,
          b) Gender*Jobcat,
          c) Gender*Minority.
12. Historgram by Normal Curve of increase (Current Salary - Begin Salary)
13. Mean, median and standard deviation of begin and current salary.
14. Scatter plot: current salary and begin salary by set marks GENDER
15. t test: paired sample t-test on SALARY and SALBEGIN variable
16. Seasonality of Death
17. t test: a) one sample t-test on  age at death in month (AADM) variable
            b) Independent sample t-test on AADM variable by Area (Treatment and Comparison)
          

### Patient Data Analysis:
19. Created a Macro to generate a report that will reflect patients' density by 6 hourly.
          
