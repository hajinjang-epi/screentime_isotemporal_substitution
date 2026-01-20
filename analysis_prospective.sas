
proc univariate data=pros_e4; 
var ctimetstw1 ctimespw1 ctime9w1 ctime10w1;
run;
proc means data=pros_e4; var dayuse_screen dayuse10w1 dayuse9w1 sp_usew1; run;
proc freq data=pros_e4;table obe_inc; run;


data pros_e4; set pros_e4; age_yw1=age_mw1/12; run;
proc means data=pros_e4; var age_yw1; run;

proc sort data=pros_e4; by total_re; run;
proc means data=pros_e4 mean std; by total_re; var age_yw1; run;
proc freq data=pros_e4; by total_re; table subhealthw1_bin; run;

data pros_e4; set pros_e4;
sumscreen=sum(sp_usew1h, dayuse9w1h, dayuse10w1h);
run;


/**********************************/
/* Table 1. Population characteristics */
/**********************************/


%macro tab1(data);
data &data.; set &data.;
screen_all=sum(ctimespw1, ctime9w1, ctime10w1);
run;
proc sort data=&data.; by total_re; run;
proc freq data=&data.;
by total_re;
table sexw1 famnumw1 pschoolw1 fjobw1 mjobw1 incomew1 gradew1 obe_inc;
run;
proc means data=&data. mean std;
by total_re; 
var parcaresumw1 
ctimetstw1 ctimespw1 ctime9w1 ctime10w1 ctime8w1 
sleep_all_h ctime11w1 ctime7w1 ctimestudyw1 ctime2w1
;
run;
%mend tab1;

%tab1(pros_e4);




/*************************/
/* Table 2. unweighted OR */
/************************/

%macro or_inc(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc logistic data=&data.; 
class &out.(ref="0") &ex.(ref="1") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") subhealthw1_bin(ref="2")/ param=glm;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 subhealthw1_bin parcaresumw1 &cov.;
lsmeans &ex. / oddsratio cl adjust=bon;
run;
proc logistic data=&data.; 
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") subhealthw1_bin(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 subhealthw1_bin parcaresumw1 &cov.;
run;
%mend or_inc;

* e4;
%or_inc(pros_e4,sumfinal,obe_inc);
%or_inc(pros_e4,spfinal,obe_inc);
%or_inc(pros_e4,comfinal,obe_inc);
%or_inc(pros_e4,tvfinal,obe_inc);


/****************************/
/* Figure 1~3. Isotemporal OR */
/****************************/

%macro iso_inc(data,out,cov);
proc logistic data=&data.; 
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") /*subhealthw1_bin(ref="2")*/ / param=ref;
model &out.= ctime8w1 sleep_all_h ctime11w1 ctime7w1 ctimestudyw1 ctime2w1 &cov. 
sexw1 famnumw1 pschoolw1 incomew1 gradew1 /*subhealthw1_bin*/  parcaresumw1;
run;
%mend iso_inc;

*Fig2. e4;
%iso_inc(pros_e4,obe_inc,);
%iso_inc(pros_e4,obe_inc, ctime9w1 ctime10w1); *sp;
%iso_inc(pros_e4,obe_inc, ctimespw1 ctime10w1); *com;
%iso_inc(pros_e4,obe_inc, ctimespw1 ctime9w1); *tv;



