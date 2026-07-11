/* Adapted from data_w4.sas (hajinjang-epi/screentime_isotemporal_substitution)
   The %beta macro is the paper's categorical-exposure counterpart to %iso2:
   a survey-weighted proc surveyreg regression of the continuous depression
   score on total screen-time exposure as a CLASS'd categorical predictor
   (rather than decomposed into individual time-use covariates), with
   clparm/solution requested. Model spec, class list, and macro body are
   kept verbatim; only the input rows below are synthetic (mock exposure/
   demographic/weight rows in place of the KCYPS2018 survey extract the
   original script reads via a local OneDrive libname). */

data dep_e4;
  input sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 total_60a depsumw1 weighta1w1;
  datalines;
2 1 2 2 3 1.06 1 11.11 1.529
1 1 1 2 3 1.69 4 10.34 1.1538
2 1 1 4 2 1.24 2 9.46 0.7984
1 1 1 4 3 1.1 4 12.63 1.2677
2 3 1 4 1 2.53 2 7.56 1.8145
1 1 1 1 2 2.14 2 12.65 1.0481
1 2 3 3 3 2.31 4 9.35 0.9676
2 3 3 3 2 2.9 3 13.36 1.6992
2 2 1 1 2 4.93 4 12.58 1.6747
2 1 3 1 3 2.24 1 8.12 1.8378
1 3 1 4 2 4.64 4 8.67 1.9683
1 3 2 3 3 3.46 3 8.14 1.5438
2 1 2 1 1 4.47 2 8.0 1.0856
1 2 3 4 3 3.76 4 9.88 1.7999
1 2 2 3 2 2.44 4 10.75 1.455
2 3 2 2 2 1.78 2 10.96 1.2438
2 3 3 4 1 1.07 3 8.37 0.7781
1 3 3 4 2 3.71 2 12.29 0.9826
1 2 3 2 1 4.07 2 10.85 0.746
2 3 3 1 1 2.23 1 11.5 1.0059
2 2 2 2 2 2.55 4 14.0 0.9651
1 1 1 4 1 3.65 2 8.69 0.8094
2 2 2 4 2 1.48 1 8.49 1.6363
1 2 2 3 2 4.48 1 7.07 1.724
2 3 1 3 2 1.34 2 9.99 1.4311
2 1 2 2 2 1.47 3 7.74 1.6654
2 3 2 3 2 1.09 4 9.54 0.5186
2 2 3 4 3 3.19 3 7.69 1.054
2 3 3 2 3 3.64 2 8.43 0.6249
2 1 2 2 1 1.44 3 10.13 1.8603
2 1 3 4 1 3.72 3 8.91 1.7619
1 1 2 3 2 2.41 1 9.51 0.6264
2 3 2 3 2 2.49 1 9.05 1.9481
1 1 3 2 2 2.94 4 9.7 1.2238
1 1 2 4 1 3.63 4 13.48 1.7124
1 1 2 2 3 4.93 2 11.27 0.7476
2 2 3 4 3 3.61 1 11.44 1.1405
2 3 2 4 2 3.93 1 6.1 1.1171
2 2 2 1 2 3.79 3 10.13 1.8867
2 2 2 1 2 3.36 4 9.37 1.5447
2 2 2 2 3 3.47 1 11.49 1.278
2 1 2 4 1 3.62 2 10.72 1.7579
2 2 2 1 1 4.33 4 8.51 1.4162
1 3 2 2 1 1.96 1 6.06 1.3997
2 1 1 1 2 1.57 4 11.48 0.7821
1 2 3 1 2 3.5 3 13.32 0.7646
1 2 3 2 1 4.41 1 8.92 1.9549
2 3 2 4 1 4.22 2 11.01 1.4035
1 1 2 2 2 3.86 3 10.89 1.8947
1 2 1 4 2 4.27 2 10.98 1.4429
2 2 3 4 3 4.62 2 9.59 1.968
2 1 3 2 3 1.25 1 9.01 1.7405
2 2 1 1 1 4.16 1 10.64 1.0466
1 1 3 2 1 3.32 3 13.53 1.6934
1 2 2 4 2 2.21 1 10.78 1.6316
2 2 2 1 2 1.6 1 8.87 0.9107
2 3 2 1 3 4.65 1 11.27 0.8292
2 2 2 3 2 3.05 3 9.97 1.3245
2 3 1 4 1 3.56 2 9.02 1.1908
2 3 3 4 2 2.63 4 11.74 1.9832
;
run;

%macro beta(data,ex,out,cov);
proc surveyreg data=&data. nomcar;
weight weighta1w1;
class  &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 / ref=first;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov./ clparm solution;
run;
%mend beta;

%beta(dep_e4,total_60a,depsumw1,);
