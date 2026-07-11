/* Adapted from analysis_cross-sectional.sas (hajinjang-epi/screentime_isotemporal_substitution)
   The %int macro tests whether the screen-time/obesity association differs
   by school level: a proc logistic model with an explicit exposure*schoolw1
   interaction term alongside the main effects, distinct from the plain
   additive %or model used elsewhere in the script. Model spec, class refs,
   and macro body are kept verbatim; only the input rows below are synthetic
   (mock exposure/demographic rows in place of the KCYPS2018 survey extract
   the original script reads via a local OneDrive libname). */

data cross_pool;
  input sexw1 famnumw1 schoolw1 pschoolw1 incomew1 gradew1 parcaresumw1 total_re obesityw1;
  datalines;
1 2 2 3 3 2 4.37 4 0
1 3 1 1 1 2 4.73 4 1
1 1 1 2 4 3 2.77 3 0
1 3 2 1 2 3 4.27 1 0
1 2 1 3 3 2 2.94 2 0
2 1 1 1 2 3 4.88 1 0
2 3 2 1 3 1 4.55 4 0
2 3 2 2 4 2 2.06 1 0
2 1 2 1 2 3 3.44 1 0
1 3 2 2 3 3 4.72 2 1
1 1 2 2 2 3 1.15 2 0
1 3 1 2 4 3 2.5 2 0
1 1 1 2 4 3 2.93 3 1
2 3 2 1 4 1 1.68 1 0
1 1 2 1 3 1 4.84 4 1
1 2 1 2 4 2 3.32 4 0
2 1 1 2 2 3 1.09 3 0
2 2 2 1 2 1 1.38 1 0
2 1 1 1 3 1 2.22 3 0
1 3 1 1 2 2 1.81 1 0
1 1 2 2 1 2 4.06 2 0
1 2 2 3 1 1 2.56 3 0
2 3 2 3 1 3 3.4 3 0
2 2 1 1 3 1 2.42 3 0
2 1 1 3 1 3 4.26 4 0
1 3 2 2 4 2 1.28 1 1
2 1 1 2 4 3 2.71 2 0
2 2 1 3 1 1 2.92 4 0
1 2 2 1 4 2 2.54 4 0
1 1 2 1 3 2 3.87 1 0
1 3 2 3 4 3 3.97 1 0
1 3 2 1 3 2 3.57 2 0
1 2 2 1 2 1 3.39 3 0
1 2 2 2 4 2 3.47 3 0
2 3 2 1 2 1 1.14 3 1
1 2 2 3 4 1 4.96 2 1
2 1 2 2 1 2 1.66 4 0
1 2 1 2 4 3 1.98 4 0
1 3 1 1 4 3 4.96 2 1
2 3 2 2 3 1 2.08 3 0
1 1 1 1 1 3 4.31 3 0
1 1 1 3 4 2 3.72 4 1
1 1 2 3 3 2 1.8 2 0
2 1 2 1 2 3 1.16 3 0
1 1 2 2 4 1 4.46 4 0
2 3 1 1 1 2 2.56 4 0
2 1 2 1 3 3 1.1 4 0
1 1 2 1 2 3 3.22 4 0
2 1 1 2 2 2 3.16 3 0
1 2 1 3 2 3 1.43 3 0
2 1 1 1 4 3 3.56 4 0
1 2 1 2 4 1 2.96 3 1
2 1 1 2 4 2 3.95 2 0
2 1 2 1 1 3 4.47 3 0
2 1 2 1 4 3 1.22 3 0
1 2 2 2 3 2 3.25 4 0
1 2 1 2 3 3 4.13 1 0
1 3 2 1 3 1 3.53 2 0
2 1 2 3 2 3 1.83 4 0
2 1 1 3 3 3 3.09 1 0
;
run;

*grade interaction;
%macro int(data,ex,out,cov);
proc logistic data=&data.;
class &out.(ref="0") &ex.(ref="2") schoolw1(ref="1") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex.*schoolw1 &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend int;

%int(cross_pool,total_re,obesityw1,);
