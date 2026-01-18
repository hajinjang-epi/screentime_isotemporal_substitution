
proc univariate data=cross_pool; 
var dayuse10w1 dayuse9w1 sp_usew1;
run;
proc univariate data=cross_e4; 
var dayuse10w1 dayuse9w1 sp_usew1;
run;
proc univariate data=cross_m1; 
var dayuse10w1 dayuse9w1 sp_usew1;
run;



/**********************************/
/* Table 1. Population characteristics */
/**********************************/

%macro tab1(data);
proc freq data=&data.;
table sexw1 famnumw1 pschoolw1 fjobw1 mjobw1 incomew1 gradew1 obesityw1;
run;
data &data.; set &data.;
screen_all=sum(ctimespw1, ctime9w1, ctime10w1);
run;
proc means data=&data. mean std;
var parcaresumw1 ctimespw1 ctime9w1 ctime10w1 screen_all sleep_all_h ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1;
run;
%mend tab1;

%tab1(cross_pool);
%tab1(cross_e4);
%tab1(cross_m1);



/*************************/
/* Table 2. unweighted OR */
/************************/

%macro or(data,ex,out,cov);
proc freq data=&data.; 
table &ex.*&out.; 
run;
proc logistic data=&data.; 
class &out.(ref="0") &ex.(ref="2") sexw1(ref="1") famnumw1(ref="2") schoolw1(ref="1") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=glm;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
lsmeans &ex. / oddsratio cl adjust=bon;
run;
proc logistic data=&data.; 
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex. sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend or;

*pooled;
%or(cross_pool,total_re,obesityw1,schoolw1);
%or(cross_pool,sp_new,obesityw1,schoolw1);
%or(cross_pool,com_new,obesityw1,schoolw1);
%or(cross_pool,tv_new,obesityw1,schoolw1);

* e4;
%or(cross_e4,total_re,obesityw1,);
%or(cross_e4,sp_new,obesityw1,);
%or(cross_e4,com_new,obesityw1,);
%or(cross_e4,tv_new,obesityw1,);

* m1;
%or(cross_m1,total_re,obesityw1,);
%or(cross_m1,sp_new,obesityw1,);
%or(cross_m1,com_new,obesityw1,);
%or(cross_m1,tv_new,obesityw1,);

*grade interaction;
%macro int(data,ex,out,cov);
proc logistic data=&data.; 
class &out.(ref="0") &ex.(ref="2") schoolw1(ref="1") sexw1(ref="1") famnumw1(ref="2") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= &ex.*schoolw1 &ex. schoolw1 sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1 &cov.;
run;
%mend int;

%int(cross_pool,total_re,obesityw1,);
%int(cross_pool,sp_new,obesityw1,);
%int(cross_pool,com_new,obesityw1,);
%int(cross_pool,tv_new,obesityw1,);




/****************************/
/* Figure 1~3. Isotemporal OR */
/****************************/

%macro iso(data,out,cov);
proc logistic data=&data.; 
class &out.(ref="0") sexw1(ref="1") famnumw1(ref="2") schoolw1(ref="1") pschoolw1(ref="2") incomew1(ref="3") gradew1(ref="2") / param=ref;
model &out.= ctime8w1 sleep_all_h ctime11w1 ctime7w1 ctimestudyw1 ctime2w1 &cov. 
sexw1 famnumw1 pschoolw1 incomew1 gradew1 parcaresumw1;
run;
%mend iso;

*Fig1. pooled;
%iso(cross_pool,obesityw1, schoolw1);
%iso(cross_pool,obesityw1, ctime9w1 ctime10w1 schoolw1); *sp;
%iso(cross_pool,obesityw1, ctimespw1 ctime10w1 schoolw1); *com;
%iso(cross_pool,obesityw1, ctimespw1 ctime9w1 schoolw1); *tv;

*Fig2. e4;
%iso(cross_e4,obesityw1,);
%iso(cross_e4,obesityw1, ctime9w1 ctime10w1); *sp;
%iso(cross_e4,obesityw1, ctimespw1 ctime10w1); *com;
%iso(cross_e4,obesityw1, ctimespw1 ctime9w1); *tv;

*Fig3. m1;
%iso(cross_m1,obesityw1,);
%iso(cross_m1,obesityw1, ctime9w1 ctime10w1); *sp;
%iso(cross_m1,obesityw1, ctimespw1 ctime10w1); *com;
%iso(cross_m1,obesityw1, ctimespw1 ctime9w1); *tv;





/*************************************************/
/* Supplementary Table 1. Population characteristics */
/************************************************/

%macro sup1(data);
data &data.; set &data.;
screen_all=sum(ctimespw1, ctime9w1, ctime10w1);
run;
proc sort data=&data.; by total_re; run;
proc freq data=&data.;
by total_re;
table schoolw1 sexw1 famnumw1 pschoolw1 fjobw1 mjobw1 incomew1 gradew1 obesityw1;
run;
proc means data=&data. mean std;
by total_re; 
var parcaresumw1 ctimespw1 ctime9w1 ctime10w1 screen_all sleep_all_h ctime8w1 ctime11w1 ctime2w1 ctimestudyw1 ctime7w1;
run;
%mend sup1;

%sup1(cross_pool);
