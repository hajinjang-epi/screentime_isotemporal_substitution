
%macro iso(data,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weightb1w4;
class &out.(ref="0") sexw1(ref="1") famnumw3(ref="2") pschoolw3(ref="2") incomew3(ref="3") gradew3(ref="2") / param=ref;
model &out.= sleep_all_h ctime8w3 ctime11w3 ctime2w3 ctimestudyw3 ctime7w3 &cov. 
sexw1 famnumw3 pschoolw3 incomew3 gradew3 parcaresumw3;
run;
%mend iso;

/**/
/* cross-sectional (2018)*/
* e4;
%iso(base3_e4,obesityw4,);
%iso(base3_e4,obesityw4, ctime9w3 ctime10w3); *sp;
%iso(base3_e4,obesityw4, ctimespw3 ctime10w3); *com;
%iso(base3_e4,obesityw4, ctimespw3 ctime9w3); *tv;
* m1;
%iso(base3_m1,obesityw4,);
%iso(base3_m1,obesityw4, ctime9w3 ctime10w3); *sp;
%iso(base3_m1,obesityw4, ctimespw3 ctime10w3); *com;
%iso(base3_m1,obesityw4, ctimespw3 ctime9w3); *tv;





/**********/
/* Table 1 */
/**********/
%macro char(data,ex);
proc surveyfreq data=&data.;
weight weighta1w1;
table &ex.*schoolw1 &ex.*sexw1 &ex.*famnumw1 &ex.*pschoolw1 &ex.*fjobw1 &ex.*mjobw1 
&ex.*incomew1 &ex.*gradew1 &ex.*obesityw1/ row;
run;
proc sort data=&data.; by &ex.; run;
proc surveymeans data=&data. mean std;
weight weighta1w1;
by &ex.;
var parcaresumw1 ctimespw1 ctime9w1 ctime10w1 sleep_all_h 
ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1;
run;
%mend char;

data table1; set e4 m1;
if obesityw1 ne .;
run;

%char(table1,total_re);






/*********/
/* obesity */
/*********/


/* OR */
%macro or(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
class &out.(ref="0") &ex.(ref="2") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend or;


/**/
/*cross-sectional (2018)*/
* e4;
%or(e4,total_re,obesityw1,);
%or(e4,sp_new,obesityw1,);
%or(e4,com_new,obesityw1,);
%or(e4,tv_new,obesityw1,);

%or(e4,sp_new,obesityw1,dayuse9w1h dayuse10w1h);
%or(e4,com_new,obesityw1,sp_usew1h dayuse10w1h);
%or(e4,tv_new,obesityw1,sp_usew1h dayuse9w1h);


* m1;
%or(m1,total_re,obesityw1,);
%or(m1,sp_new,obesityw1,);
%or(m1,com_new,obesityw1,);
%or(m1,tv_new,obesityw1,);

%or(m1,sp_new,obesityw1,dayuse9w1h dayuse10w1h);
%or(m1,com_new,obesityw1,sp_usew1h dayuse10w1h);
%or(m1,tv_new,obesityw1,sp_usew1h dayuse9w1h);

*grade_interaction;
%macro inter(data,ex,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
class &out.(ref="0") &ex.(ref="2") schoolw1(ref="1") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex.*schoolw1 &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend inter;

%inter(all,total_re,obesityw1,);
%inter(all,sp_new,obesityw1,);
%inter(all,com_new,obesityw1,);
%inter(all,tv_new,obesityw1,);

%inter(all,sp_new,obesityw1,dayuse9w1h dayuse10w1h);
%inter(all,com_new,obesityw1,sp_usew1h dayuse10w1h);
%inter(all,tv_new,obesityw1,sp_usew1h dayuse9w1h);



/**/
/*flup (including 2019, 2020, 2021 obe)*/
* e4;
%or(obe_e4,total_60,obe_tot,);
%or(obe_e4,sp_re,obe_tot,);
%or(obe_e4,com_re,obe_tot,);
%or(obe_e4,tv_re,obe_tot,);

%or(obe_e4,sp_re,obe_tot,dayuse9w1h dayuse10w1h);
%or(obe_e4,com_re,obe_tot,sp_usew1h dayuse10w1h);
%or(obe_e4,tv_re,obe_tot,sp_usew1h dayuse9w1h);

* m1;
%or(obe_m1,total_60,obe_tot,);
%or(obe_m1,sp_re,obe_tot,);
%or(obe_m1,com_re,obe_tot,);
%or(obe_m1,tv_re,obe_tot,);

%or(obe_m1,sp_re,obe_tot,dayuse9w1h dayuse10w1h);
%or(obe_m1,com_re,obe_tot,sp_usew1h dayuse10w1h);
%or(obe_m1,tv_re,obe_tot,sp_usew1h dayuse9w1h);


*grade_interaction;
%inter(obe_all,total_60,obe_tot,);
%inter(obe_all,sp_re,obe_tot,);
%inter(obe_all,com_re,obe_tot,);
%inter(obe_all,tv_re,obe_tot,);

%inter(obe_all,sp_re,obe_tot,dayuse9w1h dayuse10w1h);
%inter(obe_all,com_re,obe_tot,sp_usew1h dayuse10w1h);
%inter(obe_all,tv_re,obe_tot,sp_usew1h dayuse9w1h);




/********************************************************************************************/

/* isotemporal */
%macro iso(data,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= sleep_all_h ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1 &cov. 
sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1;
run;
%mend iso;

/**/
/* cross-sectional (2018)*/
* e4;
%iso(e4,obesityw1,);
%iso(e4,obesityw1, ctime9w1 ctime10w1); *sp;
%iso(e4,obesityw1, ctimespw1 ctime10w1); *com;
%iso(e4,obesityw1, ctimespw1 ctime9w1); *tv;
* m1;
%iso(m1,obesityw1,);
%iso(m1,obesityw1, ctime9w1 ctime10w1); *sp;
%iso(m1,obesityw1, ctimespw1 ctime10w1); *com;
%iso(m1,obesityw1, ctimespw1 ctime9w1); *tv;


/**/
/* flup (including 2019, 2020, 2021 obe)*/
* e4;
%iso(obe_e4,obe_tot,);
%iso(obe_e4,obe_tot, ctime9w1 ctime10w1); *sp;
%iso(obe_e4,obe_tot, ctimespw1 ctime10w1); *com;
%iso(obe_e4,obe_tot, ctimespw1 ctime9w1); *tv;
* m1;
%iso(obe_m1,obe_tot,);
%iso(obe_m1,obe_tot, ctime9w1 ctime10w1); *sp;
%iso(obe_m1,obe_tot, ctimespw1 ctime10w1); *com;
%iso(obe_m1,obe_tot, ctimespw1 ctime9w1); *tv;





/**************/
/* depression */
/**************/
proc univariate data=dep_e4; var depsumw1; run;
proc univariate data=dep_m1; var depsumw1; run;
proc univariate data=dep19; var depsumw1 depsumw2; run;

/* beta */
%macro freq(data,ex);
proc freq data=&data.; 
table &ex.; 
run;
%mend freq;

%macro beta(data,ex,out,cov);
proc surveyreg data=&data. nomcar; 
weight weighta1w1;
class  &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 / ref=first;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov./ clparm solution;
run;
%mend beta;

%macro trend(data,ex,out,cov);
proc surveyreg data=&data. nomcar; 
weight weighta1w1;
class  sexw1 famnumw1 pschoolw1 incomew1 gradew1 / ref=first;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov./ clparm solution;
run;
%mend trend;

/**/
/*cross-sectional (2018)*/
* e4;
%freq(dep_e4,total_60a);
%freq(dep_e4,sp_new);
%freq(dep_e4,com_new);
%freq(dep_e4,tv_new);

%beta(dep_e4,total_60a,depsumw1,);
%beta(dep_e4,sp_new,depsumw1,);
%beta(dep_e4,com_new,depsumw1,);
%beta(dep_e4,tv_new,depsumw1,);

%beta(dep_e4,sp_new,depsumw1,dayuse9w1h dayuse10w1h);
%beta(dep_e4,com_new,depsumw1,sp_usew1h dayuse10w1h);
%beta(dep_e4,tv_new,depsumw1,sp_usew1h dayuse9w1h);

%trend(dep_e4,total_60a,depsumw1,);
%trend(dep_e4,sp_new,depsumw1,);
%trend(dep_e4,com_new,depsumw1,);
%trend(dep_e4,tv_new,depsumw1,);

%trend(dep_e4,sp_new,depsumw1,dayuse9w1h dayuse10w1h);
%trend(dep_e4,com_new,depsumw1,sp_usew1h dayuse10w1h);
%trend(dep_e4,tv_new,depsumw1,sp_usew1h dayuse9w1h);


* m1;
%freq(dep_m1,total_60a);
%freq(dep_m1,sp_new);
%freq(dep_m1,com_new);
%freq(dep_m1,tv_new);

%beta(dep_m1,dep_total_60a,depsumw1,);
%beta(dep_m1,dep_sp_new,depsumw1,);
%beta(dep_m1,dep_com_new,depsumw1,);
%beta(dep_m1,dep_tv_new,depsumw1,);

%beta(dep_m1,dep_sp_new,depsumw1,dayuse9w1h dayuse10w1h);
%beta(dep_m1,dep_com_new,depsumw1,sp_usew1h dayuse10w1h);
%beta(dep_m1,dep_tv_new,depsumw1,sp_usew1h dayuse9w1h);

%trend(dep_m1,total_60a,depsumw1,);
%trend(dep_m1,sp_new,depsumw1,);
%trend(dep_m1,com_new,depsumw1,);
%trend(dep_m1,tv_new,depsumw1,);

%trend(dep_m1,sp_new,depsumw1,dayuse9w1h dayuse10w1h);
%trend(dep_m1,com_new,depsumw1,sp_usew1h dayuse10w1h);
%trend(dep_m1,tv_new,depsumw1,sp_usew1h dayuse9w1h);


*grade_interaction;
%macro inter_beta(data,ex,out,cov);
proc surveyreg data=&data. nomcar; 
weight weighta1w1;
class  &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 / ref=first;
model &out.= &ex.*schoolw1 &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov./ clparm solution;
run;
%mend inter_beta;

%inter_beta(dep,total_60a,depsumw1,);
%inter_beta(dep,sp_new,depsumw1,);
%inter_beta(dep,com_new,depsumw1,);
%inter_beta(dep,tv_new,depsumw1,);

%inter_beta(dep,sp_new,depsumw1,dayuse9w1h dayuse10w1h);
%inter_beta(dep,com_new,depsumw1,sp_usew1h dayuse10w1h);
%inter_beta(dep,tv_new,depsumw1,sp_usew1h dayuse9w1h);



/**/
/*flup (1 year, 2019)*/
* e4;
%freq(dep19_e4,total_60a);
%freq(dep19_e4,sp_new);
%freq(dep19_e4,com_new);
%freq(dep19_e4,tv_new);

%beta(dep19_e4,dep_total_60a,depsumw2,depsumw1);
%beta(dep19_e4,dep_sp_new,depsumw2,depsumw1);
%beta(dep19_e4,dep_com_new,depsumw2,depsumw1);
%beta(dep19_e4,dep_tv_new,depsumw2,depsumw1);

%beta(dep19_e4,dep_sp_new,depsumw2,depsumw1 dayuse9w1h dayuse10w1h);
%beta(dep19_e4,dep_com_new,depsumw2,depsumw1 sp_usew1h dayuse10w1h);
%beta(dep19_e4,dep_tv_new,depsumw2,depsumw1 sp_usew1h dayuse9w1h);

%trend(dep19_e4,total_60a,depsumw2,depsumw1);
%trend(dep19_e4,sp_new,depsumw2,depsumw1);
%trend(dep19_e4,com_new,depsumw2,depsumw1);
%trend(dep19_e4,tv_new,depsumw2,depsumw1);

%trend(dep19_e4,sp_new,depsumw2,depsumw1 dayuse9w1h dayuse10w1h);
%trend(dep19_e4,com_new,depsumw2,depsumw1 sp_usew1h dayuse10w1h);
%trend(dep19_e4,tv_new,depsumw2,depsumw1 sp_usew1h dayuse9w1h);


* m1;
%freq(dep19_m1,total_60a);
%freq(dep19_m1,sp_new);
%freq(dep19_m1,com_new);
%freq(dep19_m1,tv_new);

%beta(dep19_m1,dep_total_60a,depsumw2,depsumw1);
%beta(dep19_m1,dep_sp_new,depsumw2,depsumw1);
%beta(dep19_m1,dep_com_new,depsumw2,depsumw1);
%beta(dep19_m1,dep_tv_new,depsumw2,depsumw1);

%beta(dep19_m1,dep_sp_new,depsumw2,depsumw1 dayuse9w1h dayuse10w1h);
%beta(dep19_m1,dep_com_new,depsumw2,depsumw1 sp_usew1h dayuse10w1h);
%beta(dep19_m1,dep_tv_new,depsumw2,depsumw1 sp_usew1h dayuse9w1h);

%trend(dep19_m1,total_60a,depsumw2,depsumw1);
%trend(dep19_m1,sp_new,depsumw2,depsumw1);
%trend(dep19_m1,com_new,depsumw2,depsumw1);
%trend(dep19_m1,tv_new,depsumw2,depsumw1);

%trend(dep19_m1,sp_new,depsumw2,depsumw1 dayuse9w1h dayuse10w1h);
%trend(dep19_m1,com_new,depsumw2,depsumw1 sp_usew1h dayuse10w1h);
%trend(dep19_m1,tv_new,depsumw2,depsumw1 sp_usew1h dayuse9w1h);


*grade_interaction;
%inter_beta(dep19,total_60a,depsumw2,depsumw1);
%inter_beta(dep19,sp_new,depsumw2,depsumw1);
%inter_beta(dep19,com_new,depsumw2,depsumw1);
%inter_beta(dep19,tv_new,depsumw2,depsumw1);

%inter_beta(dep19,sp_new,depsumw2,depsumw1 dayuse9w1h dayuse10w1h);
%inter_beta(dep19,com_new,depsumw2,depsumw1 sp_usew1h dayuse10w1h);
%inter_beta(dep19,tv_new,depsumw2,depsumw1 sp_usew1h dayuse9w1h);



/********************************************************************************************/

/* isotemporal */
%macro iso2(data,out,cov);
proc surveyreg data=&data. nomcar; 
weight weighta1w1;
class sexw1 famnumw1 pschoolw1 incomew1 gradew1;
model &out.=sleep_all_h ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1 &cov.   
sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 /clparm solution;
run;
%mend iso2;



* cross-sectional (2018);
* e4;
%iso2(dep_e4,depsumw1,);
%iso2(dep_e4,depsumw1, ctime9w1 ctime10w1); *sp;
%iso2(dep_e4,depsumw1, ctimespw1 ctime10w1); *com;
%iso2(dep_e4,depsumw1, ctimespw1 ctime9w1); *tv;
* m1;
%iso2(dep_m1,depsumw1,);
%iso2(dep_m1,depsumw1, ctime9w1 ctime10w1); *sp;
%iso2(dep_m1,depsumw1, ctimespw1 ctime10w1); *com;
%iso2(dep_m1,depsumw1, ctimespw1 ctime9w1); *tv;


* flup (1 year, 2019);
* e4;
%iso2(dep19_e4,depsumw2,depsumw1);
%iso2(dep19_e4,depsumw2, ctime9w1 ctime10w1 depsumw1); *sp;
%iso2(dep19_e4,depsumw2, ctimespw1 ctime10w1 depsumw1); *com;
%iso2(dep19_e4,depsumw2, ctimespw1 ctime9w1 depsumw1); *tv;
* m1;
%iso2(dep19_m1,depsumw2,depsumw1);
%iso2(dep19_m1,depsumw2, ctime9w1 ctime10w1 depsumw1); *sp;
%iso2(dep19_m1,depsumw2, ctimespw1 ctime10w1 depsumw1); *com;
%iso2(dep19_m1,depsumw2, ctimespw1 ctime9w1 depsumw1); *tv;




/****************/
/* supplementary */
/****************/
data e4; set e4;
total_stw1h=sum(sp_usew1h, dayuse9w1h, dayuse10w1h);
run;
data m1; set m1;
total_stw1h=sum(sp_usew1h, dayuse9w1h, dayuse10w1h);
run;


*sexw1, incomew1;
%macro suppl(data,ex,out,str,class,cov);
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
domain &str.;
class &out.(ref="0") &class. famnumw1(ref="2") pschoolw1(ref="2") gradew1(ref="2") / param=ref;
model &out.= &ex. famnumw1 pschoolw1 gradew1 parcaresumw1 &cov. ;
run;
proc surveylogistic data=&data. nomcar; 
weight weighta1w1;
class &out.(ref="0") &str. &class. famnumw1(ref="2") pschoolw1(ref="2") gradew1(ref="2") / param=ref;
model &out.= &ex.*&str. &ex. &str. famnumw1 pschoolw1 gradew1 parcaresumw1 &cov. ;
run;
%mend suppl;
/*e4*/
/*sex*/
%suppl(e4,total_stw1h,obesityw1,sexw1,incomew1(ref="3"),incomew1);
%suppl(e4,sp_usew1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 dayuse9w1h dayuse10w1h);
%suppl(e4,dayuse9w1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 sp_usew1h dayuse10w1h);
%suppl(e4,dayuse10w1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 sp_usew1h dayuse9w1h);
/*income*/
%suppl(e4,total_stw1h,obesityw1,incomew1,sexw1(ref="1"),sexw1);
%suppl(e4,sp_usew1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 dayuse9w1h dayuse10w1h);
%suppl(e4,dayuse9w1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 sp_usew1h dayuse10w1h);
%suppl(e4,dayuse10w1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 sp_usew1h dayuse9w1h);

/*m1*/
/*sex*/
%suppl(m1,total_stw1h,obesityw1,sexw1,incomew1(ref="3"),incomew1);
%suppl(m1,sp_usew1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 dayuse9w1h dayuse10w1h);
%suppl(m1,dayuse9w1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 sp_usew1h dayuse10w1h);
%suppl(m1,dayuse10w1h,obesityw1,sexw1,incomew1(ref="3"),incomew1 sp_usew1h dayuse9w1h);
/*income*/
%suppl(m1,total_stw1h,obesityw1,incomew1,sexw1(ref="1"),sexw1);
%suppl(m1,sp_usew1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 dayuse9w1h dayuse10w1h);
%suppl(m1,dayuse9w1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 sp_usew1h dayuse10w1h);
%suppl(m1,dayuse10w1h,obesityw1,incomew1,sexw1(ref="1"),sexw1 sp_usew1h dayuse9w1h);





/******************/
/****** note *******/
/******************/

/* obesity prevalence */
proc freq data=e4; table obesityw1; run;
proc freq data=m1; table obesityw1; run;

proc surveyfreq data=e4;
weight weighta1w1;
table obesityw1;
run;
proc surveyfreq data=m1;
weight weighta1w1;
table obesityw1;
run;


/* lost to follow-up possibility? */
data note1; set all;
if obesityw1 in (0,1) then cox1=1; else cox1=0;
if obesityw2 in (0,1) then cox2=1; else cox2=0;
if obesityw3 in (0,1) then cox3=1; else cox3=0;
if obesityw4 in (0,1) then cox4=1; else cox4=0;
run;

proc freq data=note1; where cox1=1 and cox4=1; table cox2 cox3; run;
proc freq data=note1; where cox1=1 and cox3-1; table cox2; run;
proc freq data=note1; where obesityw1=0 and obesityw3=0; table cox2; run;


/* exclusion */
proc freq data=e4; table obesityw1 obesityw2 obesityw3 obesityw4; run;
proc freq data=m1; table obesityw1 obesityw2 obesityw3 obesityw4; run;
proc freq data=all; table obesityw1 obesityw2 obesityw3 obesityw4; run;


/* after-school activities */
proc univariate data=e4; var yphy2a00w1 yphy2b00w1; run;
proc freq data=e4; table bmi_cw1; run;
proc univariate data=e4; var bmiw1; run;
proc univariate data=e4; var heightw1 weightw1; run;

data e4; set e4;
if heightw1 ne . and weightw1 ne . then ex1=1; else ex1=0;
if bmiw1 ne . then ex2=1; else ex2=0;
run;

/*sleep_all_h ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1*/

proc freq data=e4; table obesityw1; run;
proc surveyfreq data=e4 nomcar;
weight weighta1w1;
table obesityw1;
run;

proc freq data=m1; table obesityw1; run;
proc surveyfreq data=m1 nomcar;
weight weighta1w1;
table obesityw1;
run;



*2018-2019;
%macro or(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w2;
class &out.(ref="0") &ex.(ref="2") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w2;
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend or;
*base1_e4;
%or(base1_e4,total_re,obesityw2,);
%or(base1_e4,sp_new,obesityw2,);
%or(base1_e4,com_new,obesityw2,);
%or(base1_e4,tv_new,obesityw2,);

%or(base1_e4,sp_new,obesityw2,dayuse9w1h dayuse10w1h);
%or(base1_e4,com_new,obesityw2,sp_usew1h dayuse10w1h);
%or(base1_e4,tv_new,obesityw2,sp_usew1h dayuse9w1h);

* m1;
%or(base1_m1,total_re,obesityw2,);
%or(base1_m1,sp_new,obesityw2,);
%or(base1_m1,com_new,obesityw2,);
%or(base1_m1,tv_new,obesityw2,);

%or(base1_m1,sp_new,obesityw2,dayuse9w1h dayuse10w1h);
%or(base1_m1,com_new,obesityw2,sp_usew1h dayuse10w1h);
%or(base1_m1,tv_new,obesityw2,sp_usew1h dayuse9w1h);

*interaction;
*grade_interaction;
%macro inter(data,ex,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weightb1w2;
class &out.(ref="0") &ex.(ref="2") schoolw1(ref="1") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex.*schoolw1 &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend inter;
data base1_all; set base1_e4 base1_m1; run;
%inter(base1_all,total_re,obesityw2,);
%inter(base1_all,sp_new,obesityw2,);
%inter(base1_all,com_new,obesityw2,);
%inter(base1_all,tv_new,obesityw2,);

%inter(base1_all,sp_new,obesityw2,dayuse9w1h dayuse10w1h);
%inter(base1_all,com_new,obesityw2,sp_usew1h dayuse10w1h);
%inter(base1_all,tv_new,obesityw2,sp_usew1h dayuse9w1h);





*2019-2020;
%macro or(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w3;
class &out.(ref="0") &ex.(ref="2") sexw1(ref="1") famnumw2(ref="2") pschoolw2(ref="2") incomew2(ref="3") gradew2(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw2 pschoolw2 incomew2 gradew2 parcaresumw2 &cov.;
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w3;
class &out.(ref="0") sexw1(ref="1") famnumw2(ref="2") pschoolw2(ref="2") incomew2(ref="3") gradew2(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw2 pschoolw2 incomew2 gradew2 parcaresumw2 &cov.;
run;
%mend or;
*base2_e4;
%or(base2_e4,total_re,obesityw3,);
%or(base2_e4,sp_new,obesityw3,);
%or(base2_e4,com_new,obesityw3,);
%or(base2_e4,tv_new,obesityw3,);

%or(base2_e4,sp_new,obesityw3,dayuse9w2h dayuse10w2h);
%or(base2_e4,com_new,obesityw3,sp_usew2h dayuse10w2h);
%or(base2_e4,tv_new,obesityw3,sp_usew2h dayuse9w2h);


* m1;
%or(base2_m1,total_re,obesityw3,);
%or(base2_m1,sp_new,obesityw3,);
%or(base2_m1,com_new,obesityw3,);
%or(base2_m1,tv_new,obesityw3,);

%or(base2_m1,sp_new,obesityw3,dayuse9w2h dayuse10w2h);
%or(base2_m1,com_new,obesityw3,sp_usew2h dayuse10w2h);
%or(base2_m1,tv_new,obesityw3,sp_usew2h dayuse9w2h);

*interaction;
*grade_interaction;
%macro inter(data,ex,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weightb1w3;
class &out.(ref="0") &ex.(ref="2") schoolw2(ref="1") sexw1(ref="1") famnumw2(ref="2") pschoolw2(ref="2") incomew2(ref="3") gradew2(ref="2") / param=ref;
model &out.= &ex.*schoolw2 &ex. schoolw2 sexw1 famnumw2 pschoolw2 incomew2 gradew2 parcaresumw2 &cov.;
run;
%mend inter;
data base2_all; set base2_e4 base2_m1; run;
%inter(base2_all,total_re,obesityw3,);
%inter(base2_all,sp_new,obesityw3,);
%inter(base2_all,com_new,obesityw3,);
%inter(base2_all,tv_new,obesityw3,);

%inter(base2_all,sp_new,obesityw3,dayuse9w2h dayuse10w2h);
%inter(base2_all,com_new,obesityw3,sp_usew2h dayuse10w2h);
%inter(base2_all,tv_new,obesityw3,sp_usew2h dayuse9w2h);






*2020-2021;
%macro or(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w4;
class &out.(ref="0") &ex.(ref="2") sexw1(ref="1") famnumw3(ref="2") pschoolw3(ref="2") incomew3(ref="3") gradew3(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw3 pschoolw3 incomew3 gradew3 parcaresumw3 &cov.;
run;
proc surveylogistic data=&data. nomcar; 
weight weightb1w4;
class &out.(ref="0") sexw1(ref="1") famnumw3(ref="2") pschoolw3(ref="2") incomew3(ref="3") gradew3(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw3 pschoolw3 incomew3 gradew3 parcaresumw3 &cov.;
run;
%mend or;
*base3_e4;
%or(base3_e4,total_re,obesityw4,);
%or(base3_e4,sp_new,obesityw4,);
%or(base3_e4,com_new,obesityw4,);
%or(base3_e4,tv_new,obesityw4,);

%or(base3_e4,sp_new,obesityw4,dayuse9w3h dayuse10w3h);
%or(base3_e4,com_new,obesityw4,sp_usew3h dayuse10w3h);
%or(base3_e4,tv_new,obesityw4,sp_usew3h dayuse9w3h);


* m1;
%or(base3_m1,total_re,obesityw4,);
%or(base3_m1,sp_new,obesityw4,);
%or(base3_m1,com_new,obesityw4,);
%or(base3_m1,tv_new,obesityw4,);

%or(base3_m1,sp_new,obesityw4,dayuse9w3h dayuse10w3h);
%or(base3_m1,com_new,obesityw4,sp_usew3h dayuse10w3h);
%or(base3_m1,tv_new,obesityw4,sp_usew3h dayuse9w3h);

*interaction;
*grade_interaction;
%macro inter(data,ex,out,cov);
proc surveylogistic data=&data. nomcar; 
weight weightb1w4;
class &out.(ref="0") &ex.(ref="2") schoolw3(ref="1") sexw1(ref="1") famnumw3(ref="2") pschoolw3(ref="2") incomew3(ref="3") gradew3(ref="2") / param=ref;
model &out.= &ex.*schoolw3 &ex. schoolw3 sexw1 famnumw3 pschoolw3 incomew3 gradew3 parcaresumw3 &cov.;
run;
%mend inter;

data base3_all; set base3_e4 base3_m1; run;
%inter(base3_all,total_re,obesityw4,);
%inter(base3_all,sp_new,obesityw4,);
%inter(base3_all,com_new,obesityw4,);
%inter(base3_all,tv_new,obesityw4,);

%inter(base3_all,sp_new,obesityw4,dayuse9w3h dayuse10w3h);
%inter(base3_all,com_new,obesityw4,sp_usew3h dayuse10w3h);
%inter(base3_all,tv_new,obesityw4,sp_usew3h dayuse9w3h);




