libname a 'C:\Users\HajinJang\OneDrive - 고려대학교\논문작성\0_230201_screen_diet\KCYPS2018_all';
data kcyps18_e4;
set a. kcyps2018e4yw1;run;
data kcyps18_e4p;
set a. kcyps2018e4pw1;run;
data kcyps18_m1;
set a. kcyps2018m1yw1;run;
data kcyps18_m1p;
set a. kcyps2018m1pw1;run;

data kcyps19_e4;
set a. kcyps2018e4yw2;run;
data kcyps19_e4p;
set a. kcyps2018e4pw2;run;
data kcyps19_m1;
set a. kcyps2018m1yw2;run;
data kcyps19_m1p;
set a. kcyps2018m1pw2;run;

data kcyps20_e4;
set a. kcyps2018e4yw3;run;
data kcyps20_e4p;
set a. kcyps2018e4pw3;run;
data kcyps20_m1;
set a. kcyps2018m1yw3;run;
data kcyps20_m1p;
set a. kcyps2018m1pw3;run;

data kcyps21_e4;
set a. kcyps2018e4yw4;run;
data kcyps21_e4p;
set a. kcyps2018e4pw4;run;
data kcyps21_m1;
set a. kcyps2018m1yw4;run;
data kcyps21_m1p;
set a. kcyps2018m1pw4;run;

proc sort data=kcyps18_e4; by hid pid;run;
proc sort data=kcyps18_e4p; by hid pid;run;
proc sort data=kcyps18_m1; by hid pid;run;
proc sort data=kcyps18_m1p; by hid pid;run;

proc sort data=kcyps19_e4; by hid pid;run;
proc sort data=kcyps19_e4p; by hid pid;run;
proc sort data=kcyps19_m1; by hid pid;run;
proc sort data=kcyps19_m1p; by hid pid;run;

proc sort data=kcyps20_e4; by hid pid;run;
proc sort data=kcyps20_e4p; by hid pid;run;
proc sort data=kcyps20_m1; by hid pid;run;
proc sort data=kcyps20_m1p; by hid pid;run;

proc sort data=kcyps21_e4; by hid pid;run;
proc sort data=kcyps21_e4p; by hid pid;run;
proc sort data=kcyps21_m1; by hid pid;run;
proc sort data=kcyps21_m1p; by hid pid;run;

data element;
merge kcyps18_e4 kcyps18_e4p kcyps19_e4 kcyps19_e4p kcyps20_e4 kcyps20_e4p kcyps21_e4 kcyps21_e4p; by hid pid; run;
data middle; 
merge kcyps18_m1 kcyps18_m1p kcyps19_m1 kcyps19_m1p kcyps20_m1 kcyps20_m1p kcyps21_m1 kcyps21_m1p; by hid pid; run;


/*****/
/*초4*/
/*****/

data e4;
set element;

if ymda1a00w1 in (1,2,3) then sp1=(ymda1a00w1 in (1,2));

/*월연령*/
birth_d=15; *생년월일 중 '일' 고정;
surveydayw1=mdy(9,15,2018); *조사날짜 2018년 9월 15일로 간주;
surveydayw4=mdy(9,15,2021); *조사날짜 2021년 9월 15일로 간주;
birth=mdy(ybrt1bw1, birth_d, ybrt1aw1); *출생일;
age_mw1=intck('month' , birth, surveydayw1); *1차조사 월_연령. range 113-139;
age_mw4=intck('month' , birth, surveydayw4);

/*성별*/
sexw1=ygenderw1;

/*학년*/
schoolw1=1;


/*스마트폰 이용시간*/
*평일;
if ytim1k01w1=1 then sp_use_wdw1=0;
else if ytim1k01w1=2 then sp_use_wdw1=15;
else if ytim1k01w1=3 then sp_use_wdw1=45;
else if ytim1k01w1=4 then sp_use_wdw1=90;
else if ytim1k01w1=5 then sp_use_wdw1=150;
else if ytim1k01w1=6 then sp_use_wdw1=210;
else if ytim1k01w1=7 then sp_use_wdw1=270;
sp_use_wdw1h=sp_use_wdw1/60; *단위를 시간으로변환;
*주말;
if ytim1k02w1=1 then sp_use_wkw1=0;
else if ytim1k02w1=2 then sp_use_wkw1=15;
else if ytim1k02w1=3 then sp_use_wkw1=45;
else if ytim1k02w1=4 then sp_use_wkw1=90;
else if ytim1k02w1=5 then sp_use_wkw1=150;
else if ytim1k02w1=6 then sp_use_wkw1=210;
else if ytim1k02w1=7 then sp_use_wkw1=270;
sp_use_wkw1h=sp_use_wkw1/60; *단위를 시간으로변환;
*일주일평균;
sp_usew1=sum(sp_use_wdw1*5, sp_use_wkw1*2)/7;
sp_usew1h=sp_usew1/60;


/*스마트폰 이용 컨텐츠*/
*SNS 이용; sp_snsw1=ymda1b05w1;
*게임; sp_gamew1=ymda1b06w1;
*TV 및 동영상 시청; sp_videow1=ymda1b08w1;


/*스마트폰 의존도점수*/
*총 15개의 문항으로 계산;
*5,10,15번은 역문항이라서 역코딩진행;
r_ymda1c05w1r=(5-ymda1c05w1);
r_ymda1c10w1r=(5-ymda1c10w1);
r_ymda1c15w1r=(5-ymda1c15w1);

sp_addictscorew1=sum(
ymda1c01w1, ymda1c02w1, ymda1c03w1, ymda1c04w1, r_ymda1c05w1r, /*일상생활장애 disturbance of adaptive functions*/
ymda1c06w1, ymda1c07w1, /*가상세계 지향성 virtual life orientation*/
ymda1c08w1, ymda1c09w1, r_ymda1c10w1r, ymda1c11w1, /*금단 withdrawl*/
ymda1c12w1, ymda1c13w1, ymda1c14w1, r_ymda1c15w1r /*내성 tolerance*/);

*20% 이상을 중독으로 구분 (1: 중독, 0: 정상);
if sp_addictscorew1 ne . then sp_addictw1=(sp_addictscorew1>=34);


/*수면시간*/
*평일;
wake_wd=hms(ytim1a01w1, ytim1a02w1, 0);
bed_wd=hms(ytim1b01w1, ytim1b02w1, 0);
sleep_wd_raw=intck('second', bed_wd, wake_wd);
if sleep_wd_raw<0 then sleep_wd=sleep_wd_raw+86400; /*24*60*60=86400 sec*/
else if sleep_wd_raw>=0 then sleep_wd=sleep_wd_raw;
sleep_wd_m=sleep_wd/60;
sleep_wd_h=sleep_wd/3600;
*주말;
wake_wk=hms(ytim1a03w1, ytim1a04w1, 0);
bed_wk=hms(ytim1b03w1, ytim1b04w1, 0);
sleep_wk_raw=intck('second', bed_wk, wake_wk);
if sleep_wk_raw<0 then sleep_wk=sleep_wk_raw+86400;
else if sleep_wk_raw>=0 then sleep_wk=sleep_wk_raw;
sleep_wk_m=sleep_wk/60;
sleep_wk_h=sleep_wk/3600;
*일주일평균;
sleep_all_m=((sleep_wd_m*5)+(sleep_wk_m*2))/7;
sleep_all_h=((sleep_wd_h*5)+(sleep_wk_h*2))/7;


/*부모님 대화시간*/
*평일;
if ytim1d01w1=1 then dayuse2_wdw1=0;
else if ytim1d01w1=2 then dayuse2_wdw1=15;
else if ytim1d01w1=3 then dayuse2_wdw1=45;
else if ytim1d01w1=4 then dayuse2_wdw1=90;
else if ytim1d01w1=5 then dayuse2_wdw1=150;
else if ytim1d01w1=6 then dayuse2_wdw1=210;
else if ytim1d01w1=7 then dayuse2_wdw1=270;
dayuse2_wdw1h=dayuse2_wdw1/60;
*주말;
if ytim1d02w1=1 then dayuse2_wkw1=0;
else if ytim1d02w1=2 then dayuse2_wkw1=15;
else if ytim1d02w1=3 then dayuse2_wkw1=45;
else if ytim1d02w1=4 then dayuse2_wkw1=90;
else if ytim1d02w1=5 then dayuse2_wkw1=150;
else if ytim1d02w1=6 then dayuse2_wkw1=210;
else if ytim1d02w1=7 then dayuse2_wkw1=270;
dayuse2_wkw1h=dayuse2_wkw1/60;
*일주일평균;
dayuse2w1=sum(dayuse2_wdw1*5, dayuse2_wkw1*2)/7;
dayuse2w1h=dayuse2w1/60;


/*학원 및 과외시간*/
*평일;
if ytim1e01w1=1 then dayuse3_wdw1=0;
else if ytim1e01w1=2 then dayuse3_wdw1=15;
else if ytim1e01w1=3 then dayuse3_wdw1=45;
else if ytim1e01w1=4 then dayuse3_wdw1=90;
else if ytim1e01w1=5 then dayuse3_wdw1=150;
else if ytim1e01w1=6 then dayuse3_wdw1=210;
else if ytim1e01w1=7 then dayuse3_wdw1=270;
dayuse3_wdw1h=dayuse3_wdw1/60;
*주말;
if ytim1e02w1=1 then dayuse3_wkw1=0;
else if ytim1e02w1=2 then dayuse3_wkw1=15;
else if ytim1e02w1=3 then dayuse3_wkw1=45;
else if ytim1e02w1=4 then dayuse3_wkw1=90;
else if ytim1e02w1=5 then dayuse3_wkw1=150;
else if ytim1e02w1=6 then dayuse3_wkw1=210;
else if ytim1e02w1=7 then dayuse3_wkw1=270;
dayuse3_wkw1h=dayuse3_wkw1/60;
*일주일평균;
dayuse3w1=sum(dayuse3_wdw1*5, dayuse3_wkw1*2)/7;
dayuse3w1h=dayuse3w1/60;


/*인터넷 및 TV강의 시간*/
*평일;
if ytim1f01w1=1 then dayuse4_wdw1=0;
else if ytim1f01w1=2 then dayuse4_wdw1=15;
else if ytim1f01w1=3 then dayuse4_wdw1=45;
else if ytim1f01w1=4 then dayuse4_wdw1=90;
else if ytim1f01w1=5 then dayuse4_wdw1=150;
else if ytim1f01w1=6 then dayuse4_wdw1=210;
else if ytim1f01w1=7 then dayuse4_wdw1=270;
dayuse4_wdw1h=dayuse4_wdw1/60;
*주말;
if ytim1f02w1=1 then dayuse4_wkw1=0;
else if ytim1f02w1=2 then dayuse4_wkw1=15;
else if ytim1f02w1=3 then dayuse4_wkw1=45;
else if ytim1f02w1=4 then dayuse4_wkw1=90;
else if ytim1f02w1=5 then dayuse4_wkw1=150;
else if ytim1f02w1=6 then dayuse4_wkw1=210;
else if ytim1f02w1=7 then dayuse4_wkw1=270;
dayuse4_wkw1h=dayuse4_wkw1/60;
*일주일평균;
dayuse4w1=sum(dayuse4_wdw1*5, dayuse4_wkw1*2)/7;
dayuse4w1h=dayuse4w1/60;


/*방과 후 학교*/
*평일;
if ytim1g01w1=1 then dayuse5_wdw1=0;
else if ytim1g01w1=2 then dayuse5_wdw1=15;
else if ytim1g01w1=3 then dayuse5_wdw1=45;
else if ytim1g01w1=4 then dayuse5_wdw1=90;
else if ytim1g01w1=5 then dayuse5_wdw1=150;
else if ytim1g01w1=6 then dayuse5_wdw1=210;
else if ytim1g01w1=7 then dayuse5_wdw1=270;
dayuse5_wdw1h=dayuse5_wdw1/60;
*주말;
if ytim1g02w1=1 then dayuse5_wkw1=0;
else if ytim1g02w1=2 then dayuse5_wkw1=15;
else if ytim1g02w1=3 then dayuse5_wkw1=45;
else if ytim1g02w1=4 then dayuse5_wkw1=90;
else if ytim1g02w1=5 then dayuse5_wkw1=150;
else if ytim1g02w1=6 then dayuse5_wkw1=210;
else if ytim1g02w1=7 then dayuse5_wkw1=270;
dayuse5_wkw1h=dayuse5_wkw1/60;
*일주일평균;
dayuse5w1=sum(dayuse5_wdw1*5, dayuse5_wkw1*2)/7;
dayuse5w1h=dayuse5w1/60;


/*스스로 공부하는 시간*/
*평일;
if ytim1h01w1=1 then dayuse6_wdw1=0;
else if ytim1h01w1=2 then dayuse6_wdw1=15;
else if ytim1h01w1=3 then dayuse6_wdw1=45;
else if ytim1h01w1=4 then dayuse6_wdw1=90;
else if ytim1h01w1=5 then dayuse6_wdw1=150;
else if ytim1h01w1=6 then dayuse6_wdw1=210;
else if ytim1h01w1=7 then dayuse6_wdw1=270;
dayuse6_wdw1h=dayuse6_wdw1/60;
*주말;
if ytim1h02w1=1 then dayuse6_wkw1=0;
else if ytim1h02w1=2 then dayuse6_wkw1=15;
else if ytim1h02w1=3 then dayuse6_wkw1=45;
else if ytim1h02w1=4 then dayuse6_wkw1=90;
else if ytim1h02w1=5 then dayuse6_wkw1=150;
else if ytim1h02w1=6 then dayuse6_wkw1=210;
else if ytim1h02w1=7 then dayuse6_wkw1=270;
dayuse6_wkw1h=dayuse6_wkw1/60;
*일주일평균;
dayuse6w1=sum(dayuse6_wdw1*5, dayuse6_wkw1*2)/7;
dayuse6w1h=dayuse6w1/60;


/*독서시간*/
*평일;
if ytim1i01w1=1 then dayuse7_wdw1=0;
else if ytim1i01w1=2 then dayuse7_wdw1=15;
else if ytim1i01w1=3 then dayuse7_wdw1=45;
else if ytim1i01w1=4 then dayuse7_wdw1=90;
else if ytim1i01w1=5 then dayuse7_wdw1=150;
else if ytim1i01w1=6 then dayuse7_wdw1=210;
else if ytim1i01w1=7 then dayuse7_wdw1=270;
dayuse7_wdw1h=dayuse7_wdw1/60;
*주말;
if ytim1i02w1=1 then dayuse7_wkw1=0;
else if ytim1i02w1=2 then dayuse7_wkw1=15;
else if ytim1i02w1=3 then dayuse7_wkw1=45;
else if ytim1i02w1=4 then dayuse7_wkw1=90;
else if ytim1i02w1=5 then dayuse7_wkw1=150;
else if ytim1i02w1=6 then dayuse7_wkw1=210;
else if ytim1i02w1=7 then dayuse7_wkw1=270;
dayuse7_wkw1h=dayuse7_wkw1/60;
*일주일평균;
dayuse7w1=sum(dayuse7_wdw1*5, dayuse7_wkw1*2)/7;
dayuse7w1h=dayuse7w1/60;


/*운동 및 신체활동시간*/
*평일;
if ytim1j01w1=1 then dayuse8_wdw1=0;
else if ytim1j01w1=2 then dayuse8_wdw1=15;
else if ytim1j01w1=3 then dayuse8_wdw1=45;
else if ytim1j01w1=4 then dayuse8_wdw1=90;
else if ytim1j01w1=5 then dayuse8_wdw1=150;
else if ytim1j01w1=6 then dayuse8_wdw1=210;
else if ytim1j01w1=7 then dayuse8_wdw1=270;
dayuse8_wdw1h=dayuse8_wdw1/60;
*주말;
if ytim1j02w1=1 then dayuse8_wkw1=0;
else if ytim1j02w1=2 then dayuse8_wkw1=15;
else if ytim1j02w1=3 then dayuse8_wkw1=45;
else if ytim1j02w1=4 then dayuse8_wkw1=90;
else if ytim1j02w1=5 then dayuse8_wkw1=150;
else if ytim1j02w1=6 then dayuse8_wkw1=210;
else if ytim1j02w1=7 then dayuse8_wkw1=270;
dayuse8_wkw1h=dayuse8_wkw1/60;
*일주일평균;
dayuse8w1=sum(dayuse8_wdw1*5, dayuse8_wkw1*2)/7;
dayuse8w1h=dayuse8w1/60;


/*컴퓨터를 가지고노는시간*/
*평일;
if ytim1l01w1=1 then dayuse9_wdw1=0;
else if ytim1l01w1=2 then dayuse9_wdw1=15;
else if ytim1l01w1=3 then dayuse9_wdw1=45;
else if ytim1l01w1=4 then dayuse9_wdw1=90;
else if ytim1l01w1=5 then dayuse9_wdw1=150;
else if ytim1l01w1=6 then dayuse9_wdw1=210;
else if ytim1l01w1=7 then dayuse9_wdw1=270;
dayuse9_wdw1h=dayuse9_wdw1/60;
*주말;
if ytim1l02w1=1 then dayuse9_wkw1=0;
else if ytim1l02w1=2 then dayuse9_wkw1=15;
else if ytim1l02w1=3 then dayuse9_wkw1=45;
else if ytim1l02w1=4 then dayuse9_wkw1=90;
else if ytim1l02w1=5 then dayuse9_wkw1=150;
else if ytim1l02w1=6 then dayuse9_wkw1=210;
else if ytim1l02w1=7 then dayuse9_wkw1=270;
dayuse9_wkw1h=dayuse9_wkw1/60;
*일주일평균;
dayuse9w1=sum(dayuse9_wdw1*5, dayuse9_wkw1*2)/7;
dayuse9w1h=dayuse9w1/60;


/*TV시청*/
*평일;
if ytim1m01w1=1 then dayuse10_wdw1=0;
else if ytim1m01w1=2 then dayuse10_wdw1=15;
else if ytim1m01w1=3 then dayuse10_wdw1=45;
else if ytim1m01w1=4 then dayuse10_wdw1=90;
else if ytim1m01w1=5 then dayuse10_wdw1=150;
else if ytim1m01w1=6 then dayuse10_wdw1=210;
else if ytim1m01w1=7 then dayuse10_wdw1=270;
dayuse10_wdw1h=dayuse10_wdw1/60;
*주말;
if ytim1m02w1=1 then dayuse10_wkw1=0;
else if ytim1m02w1=2 then dayuse10_wkw1=15;
else if ytim1m02w1=3 then dayuse10_wkw1=45;
else if ytim1m02w1=4 then dayuse10_wkw1=90;
else if ytim1m02w1=5 then dayuse10_wkw1=150;
else if ytim1m02w1=6 then dayuse10_wkw1=210;
else if ytim1m02w1=7 then dayuse10_wkw1=270;
dayuse10_wkw1h=dayuse10_wkw1/60;
*일주일평균;
dayuse10w1=sum(dayuse10_wdw1*5, dayuse10_wkw1*2)/7;
dayuse10w1h=dayuse10w1/60;


/*친구들과 노는시간*/
*평일;
if ytim1n01w1=1 then dayuse11_wdw1=0;
else if ytim1n01w1=2 then dayuse11_wdw1=15;
else if ytim1n01w1=3 then dayuse11_wdw1=45;
else if ytim1n01w1=4 then dayuse11_wdw1=90;
else if ytim1n01w1=5 then dayuse11_wdw1=150;
else if ytim1n01w1=6 then dayuse11_wdw1=210;
else if ytim1n01w1=7 then dayuse11_wdw1=270;
dayuse11_wdw1h=dayuse11_wdw1/60;
*주말;
if ytim1n02w1=1 then dayuse11_wkw1=0;
else if ytim1n02w1=2 then dayuse11_wkw1=15;
else if ytim1n02w1=3 then dayuse11_wkw1=45;
else if ytim1n02w1=4 then dayuse11_wkw1=90;
else if ytim1n02w1=5 then dayuse11_wkw1=150;
else if ytim1n02w1=6 then dayuse11_wkw1=210;
else if ytim1n02w1=7 then dayuse11_wkw1=270;
dayuse11_wkw1h=dayuse11_wkw1/60;
*일주일평균;
dayuse11w1=sum(dayuse11_wdw1*5, dayuse11_wkw1*2)/7;
dayuse11w1h=dayuse11w1/60;


/*학업성적*/
*1-6 categories: 매우 못함 - 매우 잘함 - 잘 모르겠음;
if yint1a00w1 in (1,2,3) then gradew1=1;
else if yint1a00w1 in (4,5) then gradew1=2;
else gradew1=3;


/*부모의양육태도*/
*강요;
parcare1dw1=yfam2d01w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare2dw1=yfam2d02w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare3dw1=yfam2d03w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare4dw1=yfam2d04w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcaresumw1=sum(parcare1dw1, parcare2dw1, parcare3dw1, parcare4dw1); *range 4-16;


/*부모님 동거여부*/
if pfam1a00w1 in(1,4) then famnumw1=2;
else famnumw1=1;


/*부모님학력*/
if pschool1w1 in (5,6,7) or pschool2w1 in (5,6,7) then pschoolw1=2;
else if pschool1w1 in (1:4) or pschool2w1 in (1:4) then pschoolw1=1;
else pschoolw1=2;


/*월평균가구소득*/
if pincomew1 in(1:3) then incomew1=1;
else if pincomew1 in(4,5) then incomew1=2;
else if pincomew1 in(6,7) then incomew1=3;
else if pincomew1=. then incomew1=3;
else if pincomew1 in(8,9) then incomew1=4;
else incomew1=5;

/*층화분석용 가구소득*/
if incomew1 in (1,2) then incomew1r=1;
else if incomew1=3 then incomew1r=2;
else if incomew1 in (4,5) then incomew1r=3;


/*아버지 직업*/
if pjob1w1 in (1,2,3) then fjobw1=1;
else if pjob1w1 in (4,5) then fjobw1=2;
else if pjob1w1 in (6:11) then fjobw1=3;
else fjobw1=4;


/*어머니 직업*/
if pjob2w1 in (1,2,3) then mjobw1=1;
else if pjob2w1 in (4,5) then mjobw1=2;
else if pjob2w1 in (6:11) then mjobw1=3;
else mjobw1=4;



/*학습시간(학원 및 과외, 인터넷 및 TV강의, 방과 후 학교, 스스로 공부하는 시간의 합)*/;
daystudy_wdw1=sum(dayuse3_wdw1h, dayuse4_wdw1h, dayuse5_wdw1h, dayuse6_wdw1h);
daystudy_wkw1=sum(dayuse3_wkw1h, dayuse4_wkw1h, dayuse5_wkw1h, dayuse6_wkw1h);
daystudyw1=sum(daystudy_wdw1*5, daystudy_wkw1*2)/7;

/*시간변수 24시간 단위로 변환*/
*일주일평균;
atimew1=24-sleep_all_h-25/7;
btimew1=sum(dayuse2w1h, daystudyw1, dayuse7w1h, dayuse8w1h, dayuse9w1h, dayuse10w1h, dayuse11w1h, sp_usew1h);
ctime2w1=(dayuse2w1h/btimew1)*atimew1;
ctimestudyw1=(daystudyw1/btimew1)*atimew1;
ctime7w1=(dayuse7w1h/btimew1)*atimew1;
ctime8w1=(dayuse8w1h/btimew1)*atimew1;
ctime9w1=(dayuse9w1h/btimew1)*atimew1;
ctime10w1=(dayuse10w1h/btimew1)*atimew1;
ctime11w1=(dayuse11w1h/btimew1)*atimew1;
ctimespw1=(sp_usew1h/btimew1)*atimew1;
ctimetstw1=sum(ctimespw1, ctime9w1, ctime10w1);

/*스마트폰, 컴퓨터(day9), TV(day10)중 가장 많이 이용하는 것*/
*일주일평균;
if sp_usew1^=. then do;
if sp_usew1 > dayuse9w1 and sp_usew1> dayuse10w1 then uselongw1=1; *스마트폰을 제일 많이 이용;
else if dayuse9w1> sp_usew1 and dayuse9w1>dayuse10w1 then uselongw1=2; *컴퓨터를 제일 많이 이용;
else if dayuse10w1>sp_usew1 and dayuse10w1>dayuse9w1 then uselongw1=3; *TV를 제일 많이 이용;
else uselongw1=4; *그 외;
end;



/***************/
/*screentime cat*/
/***************/

/* smartphone */
*sp_new;
if sp_usew1=. or sp_usew1=0 then sp_new=1;
else if 0<sp_usew1<60 then sp_new=2;
else if 60<=sp_usew1<120 then sp_new=3;
else if 120<=sp_usew1<180 then sp_new=4;
else if sp_usew1>=180 then sp_new=5;
*sp_re;
if sp_usew1=. or 0<=sp_usew1<60 then sp_re=2;
else if 60<=sp_usew1<120 then sp_re=3;
else if 120<=sp_usew1<180 then sp_re=4;
else if sp_usew1>=180 then sp_re=5;


*com_new;
if dayuse9w1=. or dayuse9w1=0 then com_new=1;
else if 0<dayuse9w1<60 then com_new=2;
else if 60<=dayuse9w1<120 then com_new=3;
else if dayuse9w1>=120 then com_new=4;
*com_re;
if dayuse9w1=. or 0<=dayuse9w1<60 then com_re=2;
else if 60<=dayuse9w1<120 then com_re=3;
else if dayuse9w1>=120 then com_re=4;


*tv_new;
if dayuse10w1=. or dayuse10w1=0 then tv_new=1;
else if 0<dayuse10w1<60 then tv_new=2;
else if 60<=dayuse10w1<120 then tv_new=3;
else if dayuse10w1>=120 then tv_new=4;
*tv_re;
if dayuse10w1=. or 0<=dayuse10w1<60 then tv_re=2;
else if 60<=dayuse10w1<120 then tv_re=3;
else if dayuse10w1>=120 then tv_re=4;


*total_new;
tstw1=sum(sp_usew1, dayuse9w1, dayuse10w1);
if tstw1=. or tstw1=0 then total_new=1;
else if 0<tstw1<120 then total_new=2;
else if 120<=tstw1<180 then total_new=3;
else if 180<=tstw1<240 then total_new=4;
else if tstw1>=240 then total_new=5;
*total_re;
if tstw1=. or 0<=tstw1<120 then total_re=2;
else if 120<=tstw1<180 then total_re=3;
else if 180<=tstw1<240 then total_re=4;
else if tstw1>=240 then total_re=5;
*total_60;
if tstw1=. or 0<=tstw1<60 then total_60=2;
else if 60<=tstw1<120 then total_60=3;
else if 120<=tstw1<180 then total_60=4;
else if 180<=tstw1<240 then total_60=5;
else if tstw1>=240 then total_60=6;
*total_60a;
if tstw1=. or tstw1=0 then total_60a=1;
else if 0<tstw1<60 then total_60a=2;
else if 60<=tstw1<120 then total_60a=3;
else if 120<=tstw1<180 then total_60a=4;
else if 180<=tstw1<240 then total_60a=5;
else if tstw1>=240 then total_60a=6;





/**********/
/* obesity */
/**********/
surveydayw2=mdy(9,15,2019); *조사날짜 2019년 9월 15일로 간주;
surveydayw3=mdy(9,15,2020); *조사날짜 2020년 9월 15일로 간주;
surveydayw4=mdy(9,15,2021); *조사날짜 2021년 9월 15일로 간주;
age_mw2=intck('month' , birth, surveydayw2); 
age_mw3=intck('month' , birth, surveydayw3);
age_mw4=intck('month' , birth, surveydayw4);


/********************************************** w1 *************************************************/
*BMI;
heightw1=yphy2a00w1/100;
weightw1=yphy2b00w1;
if heightw1^=. and weightw1^=. then bmiw1=weightw1/(heightw1*heightw1);

/*남자*/
if sexw1=1 then do; 

if age_mw1=113 then do; pct05w1=14.6; pct85w1=20.6; pct95w1=22.5; end;

if age_mw1=115 then do; pct05w1=14.6; pct85w1=20.8; pct95w1=22.7; end;
if age_mw1=116 then do; pct05w1=14.6; pct85w1=20.9; pct95w1=22.8; end;
if age_mw1=117 then do; pct05w1=14.7; pct85w1=21.0; pct95w1=22.9; end;
if age_mw1=118 then do; pct05w1=14.7; pct85w1=21.1; pct95w1=23.0; end;
if age_mw1=119 then do; pct05w1=14.7; pct85w1=21.1; pct95w1=23.1; end;
if age_mw1=120 then do; pct05w1=14.7; pct85w1=21.2; pct95w1=23.1; end;
if age_mw1=121 then do; pct05w1=14.8; pct85w1=21.3; pct95w1=23.2; end;
if age_mw1=122 then do; pct05w1=14.8; pct85w1=21.4; pct95w1=23.3; end;
if age_mw1=123 then do; pct05w1=14.8; pct85w1=21.5; pct95w1=23.4; end;
if age_mw1=124 then do; pct05w1=14.9; pct85w1=21.6; pct95w1=23.5; end;
if age_mw1=125 then do; pct05w1=14.9; pct85w1=21.6; pct95w1=23.6; end;
if age_mw1=126 then do; pct05w1=14.9; pct85w1=21.7; pct95w1=23.7; end;
if age_mw1=127 then do; pct05w1=15.0; pct85w1=21.8; pct95w1=23.8; end;
if age_mw1=128 then do; pct05w1=15.0; pct85w1=21.9; pct95w1=23.9; end;
if age_mw1=129 then do; pct05w1=15.0; pct85w1=22.0; pct95w1=24.0; end;
if age_mw1=130 then do; pct05w1=15.0; pct85w1=22.0; pct95w1=24.0; end;

if age_mw1=132 then do; pct05w1=15.1; pct85w1=22.2; pct95w1=24.2; end;

if age_mw1=134 then do; pct05w1=15.2; pct85w1=22.3; pct95w1=24.4; end;
if age_mw1=135 then do; pct05w1=15.2; pct85w1=22.4; pct95w1=24.4; end;

if age_mw1=137 then do; pct05w1=15.3; pct85w1=22.5; pct95w1=24.6; end;
if age_mw1=138 then do; pct05w1=15.3; pct85w1=22.6; pct95w1=24.7; end;
if age_mw1=139 then do; pct05w1=15.4; pct85w1=22.7; pct95w1=24.7; end;
end;

/*여자*/
if sexw1=2 then do; 

if age_mw1=113 then do; pct05w1=14.2; pct85w1=20.1; pct95w1=21.9; end;

if age_mw1=115 then do; pct05w1=14.2; pct85w1=20.2; pct95w1=22.0; end;
if age_mw1=116 then do; pct05w1=14.3; pct85w1=20.3; pct95w1=22.1; end;
if age_mw1=117 then do; pct05w1=14.3; pct85w1=20.3; pct95w1=22.2; end;
if age_mw1=118 then do; pct05w1=14.3; pct85w1=20.4; pct95w1=22.3; end;
if age_mw1=119 then do; pct05w1=14.3; pct85w1=20.5; pct95w1=22.4; end;
if age_mw1=120 then do; pct05w1=14.4; pct85w1=20.6; pct95w1=22.4; end;
if age_mw1=121 then do; pct05w1=14.4; pct85w1=20.6; pct95w1=22.5; end;
if age_mw1=122 then do; pct05w1=14.4; pct85w1=20.7; pct95w1=22.6; end;
if age_mw1=123 then do; pct05w1=14.5; pct85w1=20.8; pct95w1=22.7; end;
if age_mw1=124 then do; pct05w1=14.5; pct85w1=20.8; pct95w1=22.7; end;
if age_mw1=125 then do; pct05w1=14.5; pct85w1=20.9; pct95w1=22.8; end;
if age_mw1=126 then do; pct05w1=14.6; pct85w1=21.0; pct95w1=22.9; end;
if age_mw1=127 then do; pct05w1=14.6; pct85w1=21.0; pct95w1=23.0; end;
if age_mw1=128 then do; pct05w1=14.6; pct85w1=21.1; pct95w1=23.0; end;
if age_mw1=129 then do; pct05w1=14.7; pct85w1=21.2; pct95w1=23.1; end;
if age_mw1=130 then do; pct05w1=14.7; pct85w1=21.2; pct95w1=23.2; end;

if age_mw1=132 then do; pct05w1=14.8; pct85w1=21.4; pct95w1=23.3; end;

if age_mw1=134 then do; pct05w1=14.9; pct85w1=21.5; pct95w1=23.5; end;
if age_mw1=135 then do; pct05w1=14.9; pct85w1=21.6; pct95w1=23.5; end;

if age_mw1=137 then do; pct05w1=15.0; pct85w1=21.7; pct95w1=23.7; end;
if age_mw1=138 then do; pct05w1=15.0; pct85w1=21.8; pct95w1=23.7; end;
if age_mw1=139 then do; pct05w1=15.1; pct85w1=21.8; pct95w1=23.8; end;
end;

*BMI 카테고리;
if bmiw1^=. then do;
if bmiw1<pct05w1 then bmi_cw1=1;
else if pct05w1<=bmiw1<pct85w1 then bmi_cw1=2;
else if pct85w1<=bmiw1<pct95w1 then bmi_cw1=3;
else bmi_cw1=4;
end;

*비만;
if bmi_cw1^=. then do;
if bmi_cw1 in (1:3) then obesityw1=0;
else obesityw1=1;
end;

/********************************************** w2 *************************************************/
*BMI;
heightw2=yphy2a00w2/100;
weightw2=yphy2b00w2;
if yphy2a00w2^=. and yphy2b00w2^=. then bmiw2=weightw2/(heightw2*heightw2);

/*남자 125-150*/
if sexw1=1 then do; 

if age_mw2=125 then do; pct05w2=14.9; pct85w2=21.6; pct95w2=23.6; end;
if age_mw2=126 then do; pct05w2=14.9; pct85w2=21.7; pct95w2=23.7; end;
if age_mw2=127 then do; pct05w2=15.0; pct85w2=21.8; pct95w2=23.8; end;
if age_mw2=128 then do; pct05w2=15.0; pct85w2=21.9; pct95w2=23.9; end;
if age_mw2=129 then do; pct05w2=15.0; pct85w2=22.0; pct95w2=24.0; end;
if age_mw2=130 then do; pct05w2=15.0; pct85w2=22.0; pct95w2=24.0; end;
if age_mw2=131 then do; pct05w2=15.1; pct85w2=22.1; pct95w2=24.1; end;
if age_mw2=132 then do; pct05w2=15.1; pct85w2=22.2; pct95w2=24.2; end;
if age_mw2=133 then do; pct05w2=15.1; pct85w2=22.3; pct95w2=24.3; end;
if age_mw2=134 then do; pct05w2=15.2; pct85w2=22.3; pct95w2=24.4; end;
if age_mw2=135 then do; pct05w2=15.2; pct85w2=22.4; pct95w2=24.4; end;
if age_mw2=136 then do; pct05w2=15.3; pct85w2=22.5; pct95w2=24.5; end;
if age_mw2=137 then do; pct05w2=15.3; pct85w2=22.5; pct95w2=24.6; end;
if age_mw2=138 then do; pct05w2=15.3; pct85w2=22.6; pct95w2=24.7; end;
if age_mw2=139 then do; pct05w2=15.4; pct85w2=22.7; pct95w2=24.7; end;
if age_mw2=140 then do; pct05w2=15.4; pct85w2=22.7; pct95w2=24.8; end;
if age_mw2=141 then do; pct05w2=15.4; pct85w2=22.8; pct95w2=24.9; end;
if age_mw2=142 then do; pct05w2=15.5; pct85w2=22.9; pct95w2=24.9; end;
if age_mw2=143 then do; pct05w2=15.5; pct85w2=22.9; pct95w2=25.0; end;
if age_mw2=144 then do; pct05w2=15.5; pct85w2=23.0; pct95w2=25.1; end;
if age_mw2=145 then do; pct05w2=15.6; pct85w2=23.0; pct95w2=25.1; end;
if age_mw2=146 then do; pct05w2=15.6; pct85w2=23.1; pct95w2=25.2; end;
if age_mw2=147 then do; pct05w2=15.7; pct85w2=23.1; pct95w2=25.2; end;
if age_mw2=148 then do; pct05w2=15.7; pct85w2=23.2; pct95w2=25.3; end;
if age_mw2=149 then do; pct05w2=15.7; pct85w2=23.2; pct95w2=25.3; end;
if age_mw2=150 then do; pct05w2=15.8; pct85w2=23.3; pct95w2=25.4; end;
end;

/*여자 125-150*/
if sexw1=2 then do; 

if age_mw2=125 then do; pct05w2=14.5; pct85w2=20.9; pct95w2=22.8; end;
if age_mw2=126 then do; pct05w2=14.6; pct85w2=21.0; pct95w2=22.9; end;
if age_mw2=127 then do; pct05w2=14.6; pct85w2=21.0; pct95w2=23.0; end;
if age_mw2=128 then do; pct05w2=14.6; pct85w2=21.1; pct95w2=23.0; end;
if age_mw2=129 then do; pct05w2=14.7; pct85w2=21.2; pct95w2=23.1; end;
if age_mw2=130 then do; pct05w2=14.7; pct85w2=21.2; pct95w2=23.2; end;
if age_mw2=131 then do; pct05w2=14.7; pct85w2=21.3; pct95w2=23.3; end;
if age_mw2=132 then do; pct05w2=14.8; pct85w2=21.4; pct95w2=23.3; end;
if age_mw2=133 then do; pct05w2=14.8; pct85w2=21.4; pct95w2=23.4; end;
if age_mw2=134 then do; pct05w2=14.9; pct85w2=21.5; pct95w2=23.5; end;
if age_mw2=135 then do; pct05w2=14.9; pct85w2=21.6; pct95w2=23.5; end;
if age_mw2=136 then do; pct05w2=14.9; pct85w2=21.6; pct95w2=23.6; end;
if age_mw2=137 then do; pct05w2=14.0; pct85w2=21.7; pct95w2=23.7; end;
if age_mw2=138 then do; pct05w2=15.0; pct85w2=21.8; pct95w2=23.7; end;
if age_mw2=139 then do; pct05w2=15.1; pct85w2=21.8; pct95w2=23.8; end;
if age_mw2=140 then do; pct05w2=15.1; pct85w2=21.9; pct95w2=23.9; end;
if age_mw2=141 then do; pct05w2=15.2; pct85w2=21.9; pct95w2=23.9; end;
if age_mw2=142 then do; pct05w2=15.2; pct85w2=22.0; pct95w2=24.0; end;
if age_mw2=143 then do; pct05w2=15.2; pct85w2=22.1; pct95w2=24.1; end;
if age_mw2=144 then do; pct05w2=15.3; pct85w2=22.1; pct95w2=24.1; end;
if age_mw2=145 then do; pct05w2=15.3; pct85w2=22.2; pct95w2=24.2; end;
if age_mw2=146 then do; pct05w2=15.4; pct85w2=22.2; pct95w2=24.2; end;
if age_mw2=147 then do; pct05w2=15.4; pct85w2=22.3; pct95w2=24.3; end;
if age_mw2=148 then do; pct05w2=15.5; pct85w2=22.3; pct95w2=24.4; end;
if age_mw2=149 then do; pct05w2=15.5; pct85w2=22.4; pct95w2=24.4; end;
if age_mw2=150 then do; pct05w2=15.6; pct85w2=22.4; pct95w2=24.5; end;
end;

*BMI 카테고리;
if bmiw2^=. then do;
if bmiw2<pct05w2 then bmi_cw2=1;
else if pct05w2<=bmiw2<pct85w2 then bmi_cw2=2;
else if pct85w2<=bmiw2<pct95w2 then bmi_cw2=3;
else bmi_cw2=4;
end;

*비만;
if bmi_cw2^=. then do;
if bmi_cw2 in (1:3) then obesityw2=0;
else obesityw2=1;
end;


/********************************************** w3 *************************************************/
*BMI;
heightw3=yphy2a00w3/100;
weightw3=yphy2b00w3;
if yphy2a00w3^=. and yphy2b00w3^=. then bmiw3=weightw3/(heightw3*heightw3);


/*남자 137-162*/
if sexw1=1 then do; 

if age_mw3=137 then do; pct05w3=15.3; pct85w3=22.5; pct95w3=24.6; end;
if age_mw3=138 then do; pct05w3=15.3; pct85w3=22.6; pct95w3=24.7; end;
if age_mw3=139 then do; pct05w3=15.4; pct85w3=22.7; pct95w3=24.7; end;
if age_mw3=140 then do; pct05w3=15.4; pct85w3=22.7; pct95w3=24.8; end;
if age_mw3=141 then do; pct05w3=15.4; pct85w3=22.8; pct95w3=24.9; end;
if age_mw3=142 then do; pct05w3=15.5; pct85w3=22.9; pct95w3=24.9; end;
if age_mw3=143 then do; pct05w3=15.5; pct85w3=22.9; pct95w3=25.0; end;
if age_mw3=144 then do; pct05w3=15.5; pct85w3=23.0; pct95w3=25.1; end;
if age_mw3=145 then do; pct05w3=15.6; pct85w3=23.0; pct95w3=25.1; end;
if age_mw3=146 then do; pct05w3=15.6; pct85w3=23.1; pct95w3=25.2; end;
if age_mw3=147 then do; pct05w3=15.7; pct85w3=23.1; pct95w3=25.2; end;
if age_mw3=148 then do; pct05w3=15.7; pct85w3=23.2; pct95w3=25.3; end;
if age_mw3=149 then do; pct05w3=15.7; pct85w3=23.2; pct95w3=25.3; end;
if age_mw3=150 then do; pct05w3=15.8; pct85w3=23.3; pct95w3=25.4; end;
if age_mw3=151 then do; pct05w3=15.8; pct85w3=23.3; pct95w3=25.4; end;
if age_mw3=152 then do; pct05w3=15.8; pct85w3=23.4; pct95w3=25.5; end;
if age_mw3=153 then do; pct05w3=15.9; pct85w3=23.4; pct95w3=25.5; end;
if age_mw3=154 then do; pct05w3=15.9; pct85w3=23.5; pct95w3=25.6; end;
if age_mw3=155 then do; pct05w3=16.0; pct85w3=23.5; pct95w3=25.6; end;
if age_mw3=156 then do; pct05w3=16.0; pct85w3=23.6; pct95w3=25.7; end;
if age_mw3=157 then do; pct05w3=16.1; pct85w3=23.6; pct95w3=25.7; end;
if age_mw3=158 then do; pct05w3=16.1; pct85w3=23.6; pct95w3=25.7; end;
if age_mw3=159 then do; pct05w3=16.1; pct85w3=23.7; pct95w3=25.8; end;
if age_mw3=160 then do; pct05w3=16.2; pct85w3=23.7; pct95w3=25.8; end;
if age_mw3=161 then do; pct05w3=16.2; pct85w3=23.7; pct95w3=25.8; end;
if age_mw3=162 then do; pct05w3=16.3; pct85w3=23.8; pct95w3=25.8; end;
end;

/*여자 137-162*/
if sexw1=2 then do; 

if age_mw3=137 then do; pct05w3=15.0; pct85w3=21.7; pct95w3=23.7; end;
if age_mw3=138 then do; pct05w3=15.0; pct85w3=21.8; pct95w3=23.7; end;
if age_mw3=139 then do; pct05w3=15.1; pct85w3=21.8; pct95w3=23.8; end;
if age_mw3=140 then do; pct05w3=15.1; pct85w3=21.9; pct95w3=23.9; end;
if age_mw3=141 then do; pct05w3=15.2; pct85w3=21.9; pct95w3=23.9; end;
if age_mw3=142 then do; pct05w3=15.2; pct85w3=22.0; pct95w3=24.0; end;
if age_mw3=143 then do; pct05w3=15.2; pct85w3=22.1; pct95w3=24.1; end;
if age_mw3=144 then do; pct05w3=15.3; pct85w3=22.1; pct95w3=24.1; end;
if age_mw3=145 then do; pct05w3=15.3; pct85w3=22.2; pct95w3=24.2; end;
if age_mw3=146 then do; pct05w3=15.4; pct85w3=22.2; pct95w3=24.2; end;
if age_mw3=147 then do; pct05w3=15.4; pct85w3=22.3; pct95w3=24.3; end;
if age_mw3=148 then do; pct05w3=15.5; pct85w3=22.3; pct95w3=24.4; end;
if age_mw3=149 then do; pct05w3=15.5; pct85w3=22.4; pct95w3=24.4; end;
if age_mw3=150 then do; pct05w3=15.6; pct85w3=22.4; pct95w3=24.5; end;
if age_mw3=151 then do; pct05w3=15.6; pct85w3=22.5; pct95w3=24.5; end;
if age_mw3=152 then do; pct05w3=15.7; pct85w3=22.5; pct95w3=24.6; end;
if age_mw3=153 then do; pct05w3=15.7; pct85w3=22.6; pct95w3=24.6; end;
if age_mw3=154 then do; pct05w3=15.8; pct85w3=22.7; pct95w3=24.7; end;
if age_mw3=155 then do; pct05w3=15.8; pct85w3=22.7; pct95w3=24.7; end;
if age_mw3=156 then do; pct05w3=15.9; pct85w3=22.8; pct95w3=24.8; end;
if age_mw3=157 then do; pct05w3=15.9; pct85w3=22.8; pct95w3=24.8; end;
if age_mw3=158 then do; pct05w3=16.0; pct85w3=22.8; pct95w3=24.8; end;
if age_mw3=159 then do; pct05w3=16.0; pct85w3=22.9; pct95w3=24.9; end;
if age_mw3=160 then do; pct05w3=16.0; pct85w3=22.9; pct95w3=24.9; end;
if age_mw3=161 then do; pct05w3=16.1; pct85w3=23.0; pct95w3=25.0; end;
if age_mw3=162 then do; pct05w3=16.1; pct85w3=23.0; pct95w3=25.0; end;
end;

*BMI 카테고리;
if bmiw3^=. then do;
if bmiw3<pct05w3 then bmi_cw3=1;
else if pct05w3<=bmiw3<pct85w3 then bmi_cw3=2;
else if pct85w3<=bmiw3<pct95w3 then bmi_cw3=3;
else bmi_cw3=4;
end;

*비만;
if bmi_cw3^=. then do;
if bmi_cw3 in (1:3) then obesityw3=0;
else obesityw3=1;
end;


/********************************************** w4 *************************************************/
*BMI;
heightw4=yphy2a00w4/100;
weightw4=yphy2b00w4;
if yphy2a00w4^=. and yphy2b00w4^=. then bmiw4=weightw4/(heightw4*heightw4);

/*남자: 149-174*/
if sexw1=1 then do; 

if age_mw4=149 then do; pct05w4=15.7; pct85w4=23.2; pct95w4=25.3; end;
if age_mw4=150 then do; pct05w4=15.8; pct85w4=23.3; pct95w4=25.4; end;
if age_mw4=151 then do; pct05w4=15.8; pct85w4=23.3; pct95w4=25.4; end;
if age_mw4=152 then do; pct05w4=15.8; pct85w4=23.4; pct95w4=25.5; end;
if age_mw4=153 then do; pct05w4=15.9; pct85w4=23.4; pct95w4=25.5; end;
if age_mw4=154 then do; pct05w4=15.9; pct85w4=23.5; pct95w4=25.6; end;
if age_mw4=155 then do; pct05w4=16.0; pct85w4=23.5; pct95w4=25.6; end;
if age_mw4=156 then do; pct05w4=16.0; pct85w4=23.6; pct95w4=25.7; end;
if age_mw4=157 then do; pct05w4=16.1; pct85w4=23.6; pct95w4=25.7; end;
if age_mw4=158 then do; pct05w4=16.1; pct85w4=23.6; pct95w4=25.7; end;
if age_mw4=159 then do; pct05w4=16.1; pct85w4=23.7; pct95w4=25.8; end;
if age_mw4=160 then do; pct05w4=16.2; pct85w4=23.7; pct95w4=25.8; end;
if age_mw4=161 then do; pct05w4=16.2; pct85w4=23.7; pct95w4=25.8; end;
if age_mw4=162 then do; pct05w4=16.3; pct85w4=23.8; pct95w4=25.8; end;
if age_mw4=163 then do; pct05w4=16.3; pct85w4=23.8; pct95w4=25.9; end;
if age_mw4=164 then do; pct05w4=16.3; pct85w4=23.8; pct95w4=25.9; end;
if age_mw4=165 then do; pct05w4=16.4; pct85w4=23.9; pct95w4=25.9; end;
if age_mw4=166 then do; pct05w4=16.4; pct85w4=23.9; pct95w4=26.0; end;
if age_mw4=167 then do; pct05w4=16.5; pct85w4=23.9; pct95w4=26.0; end;
if age_mw4=168 then do; pct05w4=16.5; pct85w4=23.9; pct95w4=26.0; end;
if age_mw4=169 then do; pct05w4=16.6; pct85w4=24.0; pct95w4=26.0; end;
if age_mw4=170 then do; pct05w4=16.6; pct85w4=24.0; pct95w4=26.1; end;
if age_mw4=171 then do; pct05w4=16.7; pct85w4=24.0; pct95w4=26.1; end;
if age_mw4=172 then do; pct05w4=16.7; pct85w4=24.0; pct95w4=26.1; end;
if age_mw4=173 then do; pct05w4=16.7; pct85w4=24.1; pct95w4=26.1; end;
if age_mw4=174 then do; pct05w4=16.8; pct85w4=24.1; pct95w4=26.1; end;
end;

/*여자 149-174*/
if sexw1=2 then do; 

if age_mw4=149 then do; pct05w4=15.5; pct85w4=22.4; pct95w4=24.4; end;
if age_mw4=150 then do; pct05w4=15.6; pct85w4=22.4; pct95w4=24.5; end;
if age_mw4=151 then do; pct05w4=15.6; pct85w4=22.5; pct95w4=24.5; end;
if age_mw4=152 then do; pct05w4=15.7; pct85w4=22.5; pct95w4=24.6; end;
if age_mw4=153 then do; pct05w4=15.7; pct85w4=22.6; pct95w4=24.6; end;
if age_mw4=154 then do; pct05w4=15.8; pct85w4=22.7; pct95w4=24.7; end;
if age_mw4=155 then do; pct05w4=15.8; pct85w4=22.7; pct95w4=24.7; end;
if age_mw4=156 then do; pct05w4=15.9; pct85w4=22.8; pct95w4=24.8; end;
if age_mw4=157 then do; pct05w4=15.9; pct85w4=22.8; pct95w4=24.8; end;
if age_mw4=158 then do; pct05w4=16.0; pct85w4=22.8; pct95w4=24.8; end;
if age_mw4=159 then do; pct05w4=16.0; pct85w4=22.9; pct95w4=24.9; end;
if age_mw4=160 then do; pct05w4=16.0; pct85w4=22.9; pct95w4=24.9; end;
if age_mw4=161 then do; pct05w4=16.1; pct85w4=23.0; pct95w4=25.0; end;
if age_mw4=162 then do; pct05w4=16.1; pct85w4=23.0; pct95w4=25.0; end;
if age_mw4=163 then do; pct05w4=16.2; pct85w4=23.0; pct95w4=25.0; end;
if age_mw4=164 then do; pct05w4=16.2; pct85w4=23.1; pct95w4=25.1; end;
if age_mw4=165 then do; pct05w4=16.3; pct85w4=23.1; pct95w4=25.1; end;
if age_mw4=166 then do; pct05w4=16.3; pct85w4=23.2; pct95w4=25.1; end;
if age_mw4=167 then do; pct05w4=16.4; pct85w4=23.2; pct95w4=25.2; end;
if age_mw4=168 then do; pct05w4=16.4; pct85w4=23.3; pct95w4=25.2; end;
if age_mw4=169 then do; pct05w4=16.5; pct85w4=23.3; pct95w4=25.2; end;
if age_mw4=170 then do; pct05w4=16.5; pct85w4=23.3; pct95w4=25.2; end;
if age_mw4=171 then do; pct05w4=16.6; pct85w4=23.3; pct95w4=25.3; end;
if age_mw4=172 then do; pct05w4=16.6; pct85w4=23.4; pct95w4=25.3; end;
if age_mw4=173 then do; pct05w4=16.6; pct85w4=23.4; pct95w4=25.3; end;
if age_mw4=174 then do; pct05w4=16.7; pct85w4=23.4; pct95w4=25.3; end;
end;

*BMI 카테고리;
if bmiw4^=. then do;
if bmiw4<pct05w4 then bmi_cw4=1;
else if pct05w4<=bmiw4<pct85w4 then bmi_cw4=2;
else if pct85w4<=bmiw4<pct95w4 then bmi_cw4=3;
else bmi_cw4=4;
end;

*비만;
if bmi_cw4^=. then do;
if bmi_cw4 in (1:3) then obesityw4=0;
else obesityw4=1;
end;



/*************/
/* depression */
/*************/

/********************************************** w1 (baseline) *************************************************/
depress1w1=ypsy4e01w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w1=ypsy4e02w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w1=ypsy4e03w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w1=ypsy4e04w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w1=ypsy4e05w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w1=ypsy4e06w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w1=ypsy4e07w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w1=ypsy4e08w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w1=ypsy4e09w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w1=ypsy4e10w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw1=sum(depress1w1, depress2w1, depress3w1, depress4w1, depress5w1, depress6w1, depress7w1, depress8w1, depress9w1, depress10w1); *range 10-40;


/********************************************** w2 *************************************************/
depress1w2=ypsy4e01w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w2=ypsy4e02w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w2=ypsy4e03w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w2=ypsy4e04w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w2=ypsy4e05w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w2=ypsy4e06w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w2=ypsy4e07w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w2=ypsy4e08w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w2=ypsy4e09w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w2=ypsy4e10w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw2=sum(depress1w2, depress2w2, depress3w2, depress4w2, depress5w2, depress6w2, depress7w2, depress8w2, depress9w2, depress10w2); 
*range 10-40;


/********************************************** w3 *************************************************/
depress1w3=ypsy4e01w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w3=ypsy4e02w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w3=ypsy4e03w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w3=ypsy4e04w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w3=ypsy4e05w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w3=ypsy4e06w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w3=ypsy4e07w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w3=ypsy4e08w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w3=ypsy4e09w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w3=ypsy4e10w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw3=sum(depress1w3, depress2w3, depress3w3, depress4w3, depress5w3, depress6w3, depress7w3, depress8w3, depress9w3, depress10w3); 
*range 10-40;


/********************************************** w4 *************************************************/
depress1w4=ypsy4e01w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w4=ypsy4e02w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w4=ypsy4e03w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w4=ypsy4e04w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w4=ypsy4e05w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w4=ypsy4e06w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w4=ypsy4e07w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w4=ypsy4e08w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w4=ypsy4e09w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w4=ypsy4e10w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw4=sum(depress1w4, depress2w4, depress3w4, depress4w4, depress5w4, depress6w4, depress7w4, depress8w4, depress9w4, depress10w4); 
*range 10-40;


run;





/*********************************************************************************************************************************************************************************/
/*********************************************************************************************************************************************************************************/
/*********************************************************************************************************************************************************************************/





/*중1*/
data m1;
set middle;

if ymda1a00w1 in (1,2,3) then sp1=(ymda1a00w1 in (1,2));

*월연령;
birth_d=15; *생년월일 중 '일' 고정;
surveydayw1=mdy(9,15,2018); *조사날짜 2018년 9월 15일로 간주;
surveydayw4=mdy(9,15,2021); *조사날짜 2021년 9월 15일로 간주;
birth=mdy(ybrt1bw1, birth_d, ybrt1aw1); *출생일;
age_mw1=intck('month' , birth, surveydayw1); *1차조사 월_연령. range 150-170;
age_mw4=intck('month' , birth, surveydayw4);


*성별;
sexw1=ygenderw1; *M=1405 F=1185, no missing;

*학년;
schoolw1=2;


/*스마트폰 이용시간*/
*평일;
if ytim1k01w1=1 then sp_use_wdw1=0;
else if ytim1k01w1=2 then sp_use_wdw1=15;
else if ytim1k01w1=3 then sp_use_wdw1=45;
else if ytim1k01w1=4 then sp_use_wdw1=90;
else if ytim1k01w1=5 then sp_use_wdw1=150;
else if ytim1k01w1=6 then sp_use_wdw1=210;
else if ytim1k01w1=7 then sp_use_wdw1=270;
sp_use_wdw1h=sp_use_wdw1/60; *단위를 시간으로변환;
*주말;
if ytim1k02w1=1 then sp_use_wkw1=0;
else if ytim1k02w1=2 then sp_use_wkw1=15;
else if ytim1k02w1=3 then sp_use_wkw1=45;
else if ytim1k02w1=4 then sp_use_wkw1=90;
else if ytim1k02w1=5 then sp_use_wkw1=150;
else if ytim1k02w1=6 then sp_use_wkw1=210;
else if ytim1k02w1=7 then sp_use_wkw1=270;
sp_use_wkw1h=sp_use_wkw1/60; *단위를 시간으로변환;
*일주일평균;
sp_usew1=sum(sp_use_wdw1*5, sp_use_wkw1*2)/7;
sp_usew1h=sp_usew1/60;


/*스마트폰 이용 컨텐츠*/
*SNS 이용; sp_snsw1=ymda1b05w1;
*게임; sp_gamew1=ymda1b06w1;
*TV 및 동영상 시청; sp_videow1=ymda1b08w1;


/*스마트폰 의존도점수*/
*총 15개의 문항으로 계산;
*5,10,15번은 역문항이라서 역코딩진행;
r_ymda1c05w1r=(5-ymda1c05w1);
r_ymda1c10w1r=(5-ymda1c10w1);
r_ymda1c15w1r=(5-ymda1c15w1);

sp_addictscorew1=sum(
ymda1c01w1, ymda1c02w1, ymda1c03w1, ymda1c04w1, r_ymda1c05w1r, /*일상생활장애 disturbance of adaptive functions*/
ymda1c06w1, ymda1c07w1, /*가상세계 지향성 virtual life orientation*/
ymda1c08w1, ymda1c09w1, r_ymda1c10w1r, ymda1c11w1, /*금단 withdrawl*/
ymda1c12w1, ymda1c13w1, ymda1c14w1, r_ymda1c15w1r /*내성 tolerance*/);

*20% 이상을 중독으로 구분 (1: 중독, 0: 정상);
if sp_addictscorew1 ne . then sp_addictw1=(sp_addictscorew1>=34);


/*수면시간*/
*평일;
wake_wd=hms(ytim1a01w1, ytim1a02w1, 0);
bed_wd=hms(ytim1b01w1, ytim1b02w1, 0);
sleep_wd_raw=intck('second', bed_wd, wake_wd);
if sleep_wd_raw<0 then sleep_wd=sleep_wd_raw+86400; /*24*60*60=86400 sec*/
else if sleep_wd_raw>=0 then sleep_wd=sleep_wd_raw;
sleep_wd_m=sleep_wd/60;
sleep_wd_h=sleep_wd/3600;
*주말;
wake_wk=hms(ytim1a03w1, ytim1a04w1, 0);
bed_wk=hms(ytim1b03w1, ytim1b04w1, 0);
sleep_wk_raw=intck('second', bed_wk, wake_wk);
if sleep_wk_raw<0 then sleep_wk=sleep_wk_raw+86400;
else if sleep_wk_raw>=0 then sleep_wk=sleep_wk_raw;
sleep_wk_m=sleep_wk/60;
sleep_wk_h=sleep_wk/3600;
*일주일평균;
sleep_all_m=((sleep_wd_m*5)+(sleep_wk_m*2))/7;
sleep_all_h=((sleep_wd_h*5)+(sleep_wk_h*2))/7;


/*부모님 대화시간*/
*평일;
if ytim1d01w1=1 then dayuse2_wdw1=0;
else if ytim1d01w1=2 then dayuse2_wdw1=15;
else if ytim1d01w1=3 then dayuse2_wdw1=45;
else if ytim1d01w1=4 then dayuse2_wdw1=90;
else if ytim1d01w1=5 then dayuse2_wdw1=150;
else if ytim1d01w1=6 then dayuse2_wdw1=210;
else if ytim1d01w1=7 then dayuse2_wdw1=270;
dayuse2_wdw1h=dayuse2_wdw1/60;
*주말;
if ytim1d02w1=1 then dayuse2_wkw1=0;
else if ytim1d02w1=2 then dayuse2_wkw1=15;
else if ytim1d02w1=3 then dayuse2_wkw1=45;
else if ytim1d02w1=4 then dayuse2_wkw1=90;
else if ytim1d02w1=5 then dayuse2_wkw1=150;
else if ytim1d02w1=6 then dayuse2_wkw1=210;
else if ytim1d02w1=7 then dayuse2_wkw1=270;
dayuse2_wkw1h=dayuse2_wkw1/60;
*일주일평균;
dayuse2w1=sum(dayuse2_wdw1*5, dayuse2_wkw1*2)/7;
dayuse2w1h=dayuse2w1/60;


/*학원 및 과외시간*/
*평일;
if ytim1e01w1=1 then dayuse3_wdw1=0;
else if ytim1e01w1=2 then dayuse3_wdw1=15;
else if ytim1e01w1=3 then dayuse3_wdw1=45;
else if ytim1e01w1=4 then dayuse3_wdw1=90;
else if ytim1e01w1=5 then dayuse3_wdw1=150;
else if ytim1e01w1=6 then dayuse3_wdw1=210;
else if ytim1e01w1=7 then dayuse3_wdw1=270;
dayuse3_wdw1h=dayuse3_wdw1/60;
*주말;
if ytim1e02w1=1 then dayuse3_wkw1=0;
else if ytim1e02w1=2 then dayuse3_wkw1=15;
else if ytim1e02w1=3 then dayuse3_wkw1=45;
else if ytim1e02w1=4 then dayuse3_wkw1=90;
else if ytim1e02w1=5 then dayuse3_wkw1=150;
else if ytim1e02w1=6 then dayuse3_wkw1=210;
else if ytim1e02w1=7 then dayuse3_wkw1=270;
dayuse3_wkw1h=dayuse3_wkw1/60;
*일주일평균;
dayuse3w1=sum(dayuse3_wdw1*5, dayuse3_wkw1*2)/7;
dayuse3w1h=dayuse3w1/60;


/*인터넷 및 TV강의 시간*/
*평일;
if ytim1f01w1=1 then dayuse4_wdw1=0;
else if ytim1f01w1=2 then dayuse4_wdw1=15;
else if ytim1f01w1=3 then dayuse4_wdw1=45;
else if ytim1f01w1=4 then dayuse4_wdw1=90;
else if ytim1f01w1=5 then dayuse4_wdw1=150;
else if ytim1f01w1=6 then dayuse4_wdw1=210;
else if ytim1f01w1=7 then dayuse4_wdw1=270;
dayuse4_wdw1h=dayuse4_wdw1/60;
*주말;
if ytim1f02w1=1 then dayuse4_wkw1=0;
else if ytim1f02w1=2 then dayuse4_wkw1=15;
else if ytim1f02w1=3 then dayuse4_wkw1=45;
else if ytim1f02w1=4 then dayuse4_wkw1=90;
else if ytim1f02w1=5 then dayuse4_wkw1=150;
else if ytim1f02w1=6 then dayuse4_wkw1=210;
else if ytim1f02w1=7 then dayuse4_wkw1=270;
dayuse4_wkw1h=dayuse4_wkw1/60;
*일주일평균;
dayuse4w1=sum(dayuse4_wdw1*5, dayuse4_wkw1*2)/7;
dayuse4w1h=dayuse4w1/60;


/*방과 후 학교*/
*평일;
if ytim1g01w1=1 then dayuse5_wdw1=0;
else if ytim1g01w1=2 then dayuse5_wdw1=15;
else if ytim1g01w1=3 then dayuse5_wdw1=45;
else if ytim1g01w1=4 then dayuse5_wdw1=90;
else if ytim1g01w1=5 then dayuse5_wdw1=150;
else if ytim1g01w1=6 then dayuse5_wdw1=210;
else if ytim1g01w1=7 then dayuse5_wdw1=270;
dayuse5_wdw1h=dayuse5_wdw1/60;
*주말;
if ytim1g02w1=1 then dayuse5_wkw1=0;
else if ytim1g02w1=2 then dayuse5_wkw1=15;
else if ytim1g02w1=3 then dayuse5_wkw1=45;
else if ytim1g02w1=4 then dayuse5_wkw1=90;
else if ytim1g02w1=5 then dayuse5_wkw1=150;
else if ytim1g02w1=6 then dayuse5_wkw1=210;
else if ytim1g02w1=7 then dayuse5_wkw1=270;
dayuse5_wkw1h=dayuse5_wkw1/60;
*일주일평균;
dayuse5w1=sum(dayuse5_wdw1*5, dayuse5_wkw1*2)/7;
dayuse5w1h=dayuse5w1/60;


/*스스로 공부하는 시간*/
*평일;
if ytim1h01w1=1 then dayuse6_wdw1=0;
else if ytim1h01w1=2 then dayuse6_wdw1=15;
else if ytim1h01w1=3 then dayuse6_wdw1=45;
else if ytim1h01w1=4 then dayuse6_wdw1=90;
else if ytim1h01w1=5 then dayuse6_wdw1=150;
else if ytim1h01w1=6 then dayuse6_wdw1=210;
else if ytim1h01w1=7 then dayuse6_wdw1=270;
dayuse6_wdw1h=dayuse6_wdw1/60;
*주말;
if ytim1h02w1=1 then dayuse6_wkw1=0;
else if ytim1h02w1=2 then dayuse6_wkw1=15;
else if ytim1h02w1=3 then dayuse6_wkw1=45;
else if ytim1h02w1=4 then dayuse6_wkw1=90;
else if ytim1h02w1=5 then dayuse6_wkw1=150;
else if ytim1h02w1=6 then dayuse6_wkw1=210;
else if ytim1h02w1=7 then dayuse6_wkw1=270;
dayuse6_wkw1h=dayuse6_wkw1/60;
*일주일평균;
dayuse6w1=sum(dayuse6_wdw1*5, dayuse6_wkw1*2)/7;
dayuse6w1h=dayuse6w1/60;


/*독서시간*/
*평일;
if ytim1i01w1=1 then dayuse7_wdw1=0;
else if ytim1i01w1=2 then dayuse7_wdw1=15;
else if ytim1i01w1=3 then dayuse7_wdw1=45;
else if ytim1i01w1=4 then dayuse7_wdw1=90;
else if ytim1i01w1=5 then dayuse7_wdw1=150;
else if ytim1i01w1=6 then dayuse7_wdw1=210;
else if ytim1i01w1=7 then dayuse7_wdw1=270;
dayuse7_wdw1h=dayuse7_wdw1/60;
*주말;
if ytim1i02w1=1 then dayuse7_wkw1=0;
else if ytim1i02w1=2 then dayuse7_wkw1=15;
else if ytim1i02w1=3 then dayuse7_wkw1=45;
else if ytim1i02w1=4 then dayuse7_wkw1=90;
else if ytim1i02w1=5 then dayuse7_wkw1=150;
else if ytim1i02w1=6 then dayuse7_wkw1=210;
else if ytim1i02w1=7 then dayuse7_wkw1=270;
dayuse7_wkw1h=dayuse7_wkw1/60;
*일주일평균;
dayuse7w1=sum(dayuse7_wdw1*5, dayuse7_wkw1*2)/7;
dayuse7w1h=dayuse7w1/60;


/*운동 및 신체활동시간*/
*평일;
if ytim1j01w1=1 then dayuse8_wdw1=0;
else if ytim1j01w1=2 then dayuse8_wdw1=15;
else if ytim1j01w1=3 then dayuse8_wdw1=45;
else if ytim1j01w1=4 then dayuse8_wdw1=90;
else if ytim1j01w1=5 then dayuse8_wdw1=150;
else if ytim1j01w1=6 then dayuse8_wdw1=210;
else if ytim1j01w1=7 then dayuse8_wdw1=270;
dayuse8_wdw1h=dayuse8_wdw1/60;
*주말;
if ytim1j02w1=1 then dayuse8_wkw1=0;
else if ytim1j02w1=2 then dayuse8_wkw1=15;
else if ytim1j02w1=3 then dayuse8_wkw1=45;
else if ytim1j02w1=4 then dayuse8_wkw1=90;
else if ytim1j02w1=5 then dayuse8_wkw1=150;
else if ytim1j02w1=6 then dayuse8_wkw1=210;
else if ytim1j02w1=7 then dayuse8_wkw1=270;
dayuse8_wkw1h=dayuse8_wkw1/60;
*일주일평균;
dayuse8w1=sum(dayuse8_wdw1*5, dayuse8_wkw1*2)/7;
dayuse8w1h=dayuse8w1/60;


/*컴퓨터를 가지고노는시간*/
*평일;
if ytim1l01w1=1 then dayuse9_wdw1=0;
else if ytim1l01w1=2 then dayuse9_wdw1=15;
else if ytim1l01w1=3 then dayuse9_wdw1=45;
else if ytim1l01w1=4 then dayuse9_wdw1=90;
else if ytim1l01w1=5 then dayuse9_wdw1=150;
else if ytim1l01w1=6 then dayuse9_wdw1=210;
else if ytim1l01w1=7 then dayuse9_wdw1=270;
dayuse9_wdw1h=dayuse9_wdw1/60;
*주말;
if ytim1l02w1=1 then dayuse9_wkw1=0;
else if ytim1l02w1=2 then dayuse9_wkw1=15;
else if ytim1l02w1=3 then dayuse9_wkw1=45;
else if ytim1l02w1=4 then dayuse9_wkw1=90;
else if ytim1l02w1=5 then dayuse9_wkw1=150;
else if ytim1l02w1=6 then dayuse9_wkw1=210;
else if ytim1l02w1=7 then dayuse9_wkw1=270;
dayuse9_wkw1h=dayuse9_wkw1/60;
*일주일평균;
dayuse9w1=sum(dayuse9_wdw1*5, dayuse9_wkw1*2)/7;
dayuse9w1h=dayuse9w1/60;


/*TV시청*/
*평일;
if ytim1m01w1=1 then dayuse10_wdw1=0;
else if ytim1m01w1=2 then dayuse10_wdw1=15;
else if ytim1m01w1=3 then dayuse10_wdw1=45;
else if ytim1m01w1=4 then dayuse10_wdw1=90;
else if ytim1m01w1=5 then dayuse10_wdw1=150;
else if ytim1m01w1=6 then dayuse10_wdw1=210;
else if ytim1m01w1=7 then dayuse10_wdw1=270;
dayuse10_wdw1h=dayuse10_wdw1/60;
*주말;
if ytim1m02w1=1 then dayuse10_wkw1=0;
else if ytim1m02w1=2 then dayuse10_wkw1=15;
else if ytim1m02w1=3 then dayuse10_wkw1=45;
else if ytim1m02w1=4 then dayuse10_wkw1=90;
else if ytim1m02w1=5 then dayuse10_wkw1=150;
else if ytim1m02w1=6 then dayuse10_wkw1=210;
else if ytim1m02w1=7 then dayuse10_wkw1=270;
dayuse10_wkw1h=dayuse10_wkw1/60;
*일주일평균;
dayuse10w1=sum(dayuse10_wdw1*5, dayuse10_wkw1*2)/7;
dayuse10w1h=dayuse10w1/60;


/*친구들과 노는시간*/
*평일;
if ytim1n01w1=1 then dayuse11_wdw1=0;
else if ytim1n01w1=2 then dayuse11_wdw1=15;
else if ytim1n01w1=3 then dayuse11_wdw1=45;
else if ytim1n01w1=4 then dayuse11_wdw1=90;
else if ytim1n01w1=5 then dayuse11_wdw1=150;
else if ytim1n01w1=6 then dayuse11_wdw1=210;
else if ytim1n01w1=7 then dayuse11_wdw1=270;
dayuse11_wdw1h=dayuse11_wdw1/60;
*주말;
if ytim1n02w1=1 then dayuse11_wkw1=0;
else if ytim1n02w1=2 then dayuse11_wkw1=15;
else if ytim1n02w1=3 then dayuse11_wkw1=45;
else if ytim1n02w1=4 then dayuse11_wkw1=90;
else if ytim1n02w1=5 then dayuse11_wkw1=150;
else if ytim1n02w1=6 then dayuse11_wkw1=210;
else if ytim1n02w1=7 then dayuse11_wkw1=270;
dayuse11_wkw1h=dayuse11_wkw1/60;
*일주일평균;
dayuse11w1=sum(dayuse11_wdw1*5, dayuse11_wkw1*2)/7;
dayuse11w1h=dayuse11w1/60;


/*학업성적*/
*1-6 categories: 매우 못함 - 매우 잘함 - 잘 모르겠음;
if yint1a00w1 in (1,2,3) then gradew1=1;
else if yint1a00w1 in (4,5) then gradew1=2;
else gradew1=3;


/*부모의양육태도*/
*강요;
parcare1dw1=yfam2d01w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare2dw1=yfam2d02w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare3dw1=yfam2d03w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcare4dw1=yfam2d04w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
parcaresumw1=sum(parcare1dw1, parcare2dw1, parcare3dw1, parcare4dw1); *range 4-16;


/*부모님 동거여부*/
if pfam1a00w1 in(1,4) then famnumw1=2;
else famnumw1=1;


/*부모님학력*/
if pschool1w1 in (5,6,7) or pschool2w1 in (5,6,7) then pschoolw1=2;
else if pschool1w1 in (1:4) or pschool2w1 in (1:4) then pschoolw1=1;
else pschoolw1=2;


/*월평균가구소득*/
if pincomew1 in(1:3) then incomew1=1;
else if pincomew1 in(4,5) then incomew1=2;
else if pincomew1 in(6,7) then incomew1=3;
else if pincomew1=. then incomew1=3;
else if pincomew1 in(8,9) then incomew1=4;
else incomew1=5;

/*층화분석용 가구소득*/
if incomew1 in (1,2) then incomew1r=1;
else if incomew1=3 then incomew1r=2;
else if incomew1 in (4,5) then incomew1r=3;


/*아버지 직업*/
if pjob1w1 in (1,2,3) then fjobw1=1;
else if pjob1w1 in (4,5) then fjobw1=2;
else if pjob1w1 in (6:11) then fjobw1=3;
else fjobw1=4;


/*어머니 직업*/
if pjob2w1 in (1,2,3) then mjobw1=1;
else if pjob2w1 in (4,5) then mjobw1=2;
else if pjob2w1 in (6:11) then mjobw1=3;
else mjobw1=4;



/*학습시간(학원 및 과외, 인터넷 및 TV강의, 방과 후 학교, 스스로 공부하는 시간의 합)*/;
daystudy_wdw1=sum(dayuse3_wdw1h, dayuse4_wdw1h, dayuse5_wdw1h, dayuse6_wdw1h);
daystudy_wkw1=sum(dayuse3_wkw1h, dayuse4_wkw1h, dayuse5_wkw1h, dayuse6_wkw1h);
daystudyw1=sum(daystudy_wdw1*5, daystudy_wkw1*2)/7;

/*시간변수 24시간 단위로 변환*/
*일주일평균;
atimew1=24-sleep_all_h-5;
btimew1=sum(dayuse2w1h, daystudyw1, dayuse7w1h, dayuse8w1h, dayuse9w1h, dayuse10w1h, dayuse11w1h, sp_usew1h);
ctime2w1=(dayuse2w1h/btimew1)*atimew1;
ctimestudyw1=(daystudyw1/btimew1)*atimew1;
ctime7w1=(dayuse7w1h/btimew1)*atimew1;
ctime8w1=(dayuse8w1h/btimew1)*atimew1;
ctime9w1=(dayuse9w1h/btimew1)*atimew1;
ctime10w1=(dayuse10w1h/btimew1)*atimew1;
ctime11w1=(dayuse11w1h/btimew1)*atimew1;
ctimespw1=(sp_usew1h/btimew1)*atimew1;
ctimetstw1=sum(ctimespw1, ctime9w1, ctime10w1);

/*스마트폰, 컴퓨터(day9), TV(day10)중 가장 많이 이용하는 것*/
*일주일평균;
if sp_usew1^=. then do;
if sp_usew1 > dayuse9w1 and sp_usew1> dayuse10w1 then uselongw1=1; *스마트폰을 제일 많이 이용;
else if dayuse9w1> sp_usew1 and dayuse9w1>dayuse10w1 then uselongw1=2; *컴퓨터를 제일 많이 이용;
else if dayuse10w1>sp_usew1 and dayuse10w1>dayuse9w1 then uselongw1=3; *TV를 제일 많이 이용;
else uselongw1=4; *그 외;
end;



/***************/
/*screentime cat*/
/***************/

/* smartphone */
*sp_new;
if sp_usew1=. or sp_usew1=0 then sp_new=1;
else if 0<sp_usew1<60 then sp_new=2;
else if 60<=sp_usew1<120 then sp_new=3;
else if 120<=sp_usew1<180 then sp_new=4;
else if sp_usew1>=180 then sp_new=5;
*sp_re;
if sp_usew1=. or 0<=sp_usew1<60 then sp_re=2;
else if 60<=sp_usew1<120 then sp_re=3;
else if 120<=sp_usew1<180 then sp_re=4;
else if sp_usew1>=180 then sp_re=5;


*com_new;
if dayuse9w1=. or dayuse9w1=0 then com_new=1;
else if 0<dayuse9w1<60 then com_new=2;
else if 60<=dayuse9w1<120 then com_new=3;
else if dayuse9w1>=120 then com_new=4;
*com_re;
if dayuse9w1=. or 0<=dayuse9w1<60 then com_re=2;
else if 60<=dayuse9w1<120 then com_re=3;
else if dayuse9w1>=120 then com_re=4;


*tv_new;
if dayuse10w1=. or dayuse10w1=0 then tv_new=1;
else if 0<dayuse10w1<60 then tv_new=2;
else if 60<=dayuse10w1<120 then tv_new=3;
else if dayuse10w1>=120 then tv_new=4;
*tv_re;
if dayuse10w1=. or 0<=dayuse10w1<60 then tv_re=2;
else if 60<=dayuse10w1<120 then tv_re=3;
else if dayuse10w1>=120 then tv_re=4;


*total_new;
tstw1=sum(sp_usew1, dayuse9w1, dayuse10w1);
if tstw1=. or tstw1=0 then total_new=1;
else if 0<tstw1<120 then total_new=2;
else if 120<=tstw1<180 then total_new=3;
else if 180<=tstw1<240 then total_new=4;
else if tstw1>=240 then total_new=5;
*total_re;
if tstw1=. or 0<=tstw1<120 then total_re=2;
else if 120<=tstw1<180 then total_re=3;
else if 180<=tstw1<240 then total_re=4;
else if tstw1>=240 then total_re=5;
*total_60;
if tstw1=. or 0<=tstw1<60 then total_60=2;
else if 60<=tstw1<120 then total_60=3;
else if 120<=tstw1<180 then total_60=4;
else if 180<=tstw1<240 then total_60=5;
else if tstw1>=240 then total_60=6;
*total_60a;
if tstw1=. or tstw1=0 then total_60a=1;
else if 0<tstw1<60 then total_60a=2;
else if 60<=tstw1<120 then total_60a=3;
else if 120<=tstw1<180 then total_60a=4;
else if 180<=tstw1<240 then total_60a=5;
else if tstw1>=240 then total_60a=6;




/**********/
/* obesity */
/**********/
surveydayw2=mdy(9,15,2019); *조사날짜 2019년 9월 15일로 간주;
surveydayw3=mdy(9,15,2020); *조사날짜 2020년 9월 15일로 간주;
surveydayw4=mdy(9,15,2021); *조사날짜 2021년 9월 15일로 간주;
age_mw2=intck('month' , birth, surveydayw2); 
age_mw3=intck('month' , birth, surveydayw3);
age_mw4=intck('month' , birth, surveydayw4);

/********************************************** w1 *************************************************/
*BMI;
heightw1=yphy2a00w1/100;
weightw1=yphy2b00w1;
if yphy2a00w1^=. and yphy2b00w1^=. then bmiw1=weightw1/(heightw1*heightw1);

/*남자*/

if sexw1=1 then do; 

if age_mw1=150 then do; pct05w1=15.8; pct85w1=23.3; pct95w1=25.4; end;
if age_mw1=151 then do; pct05w1=15.8; pct85w1=23.3; pct95w1=25.4; end;
if age_mw1=152 then do; pct05w1=15.8; pct85w1=23.4; pct95w1=25.5; end;
if age_mw1=153 then do; pct05w1=15.9; pct85w1=23.4; pct95w1=25.5; end;
if age_mw1=154 then do; pct05w1=15.9; pct85w1=23.5; pct95w1=25.6; end;
if age_mw1=155 then do; pct05w1=16.0; pct85w1=23.5; pct95w1=25.6; end;
if age_mw1=156 then do; pct05w1=16.0; pct85w1=23.6; pct95w1=25.7; end;
if age_mw1=157 then do; pct05w1=16.1; pct85w1=23.6; pct95w1=25.7; end;
if age_mw1=158 then do; pct05w1=16.1; pct85w1=23.6; pct95w1=25.7; end;
if age_mw1=159 then do; pct05w1=16.1; pct85w1=23.7; pct95w1=25.8; end;
if age_mw1=160 then do; pct05w1=16.2; pct85w1=23.7; pct95w1=25.8; end;
if age_mw1=161 then do; pct05w1=16.2; pct85w1=23.7; pct95w1=25.8; end;
if age_mw1=162 then do; pct05w1=16.3; pct85w1=23.8; pct95w1=25.8; end;
if age_mw1=163 then do; pct05w1=16.3; pct85w1=23.8; pct95w1=25.9; end;
if age_mw1=164 then do; pct05w1=16.3; pct85w1=23.8; pct95w1=25.9; end;
if age_mw1=165 then do; pct05w1=16.4; pct85w1=23.9; pct95w1=25.9; end;
if age_mw1=166 then do; pct05w1=16.4; pct85w1=23.9; pct95w1=26.0; end;
if age_mw1=169 then do; pct05w1=16.6; pct85w1=24.0; pct95w1=26.0; end;
if age_mw1=170 then do; pct05w1=16.6; pct85w1=24.0; pct95w1=26.1; end;
end;

/*여자*/
if sexw1=2 then do; 

if age_mw1=150 then do; pct05w1=15.6; pct85w1=22.4; pct95w1=24.5; end;
if age_mw1=151 then do; pct05w1=15.6; pct85w1=22.5; pct95w1=24.5; end;
if age_mw1=152 then do; pct05w1=15.7; pct85w1=22.5; pct95w1=24.6; end;
if age_mw1=153 then do; pct05w1=15.7; pct85w1=22.6; pct95w1=24.6; end;
if age_mw1=154 then do; pct05w1=15.8; pct85w1=22.7; pct95w1=24.7; end;
if age_mw1=155 then do; pct05w1=15.8; pct85w1=22.7; pct95w1=24.7; end;
if age_mw1=156 then do; pct05w1=15.9; pct85w1=22.8; pct95w1=24.8; end;
if age_mw1=157 then do; pct05w1=15.9; pct85w1=22.8; pct95w1=24.8; end;
if age_mw1=158 then do; pct05w1=16.0; pct85w1=22.8; pct95w1=24.8; end;
if age_mw1=159 then do; pct05w1=16.0; pct85w1=22.9; pct95w1=24.9; end;
if age_mw1=160 then do; pct05w1=16.0; pct85w1=22.9; pct95w1=24.9; end;
if age_mw1=161 then do; pct05w1=16.1; pct85w1=23.0; pct95w1=25.0; end;
if age_mw1=162 then do; pct05w1=16.1; pct85w1=23.0; pct95w1=25.0; end;
if age_mw1=163 then do; pct05w1=16.2; pct85w1=23.0; pct95w1=25.0; end;
if age_mw1=164 then do; pct05w1=16.2; pct85w1=23.1; pct95w1=25.1; end;
if age_mw1=165 then do; pct05w1=16.3; pct85w1=23.1; pct95w1=25.1; end;
if age_mw1=166 then do; pct05w1=16.3; pct85w1=23.2; pct95w1=25.1; end;
if age_mw1=169 then do; pct05w1=16.5; pct85w1=23.3; pct95w1=25.2; end;
if age_mw1=170 then do; pct05w1=16.5; pct85w1=23.3; pct95w1=25.2; end;
end;

*BMI 카테고리;
if bmiw1^=. then do;
if bmiw1<pct05w1 then bmi_cw1=1;
else if pct05w1<=bmiw1<pct85w1 then bmi_cw1=2;
else if pct85w1<=bmiw1<pct95w1 then bmi_cw1=3;
else bmi_cw1=4;
end;

*비만;
if bmi_cw1^=. then do;
if bmi_cw1 in (1:3) then obesityw1=0;
else obesityw1=1;
end;

/********************************************** w2 *************************************************/
*BMI;
heightw2=yphy2a00w2/100;
weightw2=yphy2b00w2;
if yphy2a00w2^=. and yphy2b00w2^=. then bmiw2=weightw2/(heightw2*heightw2);

/*남자 162-182*/

if sexw1=1 then do; 

if age_mw2=162 then do; pct05w2=16.3; pct85w2=23.8; pct95w2=25.8; end;
if age_mw2=163 then do; pct05w2=16.3; pct85w2=23.8; pct95w2=25.9; end;
if age_mw2=164 then do; pct05w2=16.3; pct85w2=23.8; pct95w2=25.9; end;
if age_mw2=165 then do; pct05w2=16.4; pct85w2=23.9; pct95w2=25.9; end;
if age_mw2=166 then do; pct05w2=16.4; pct85w2=23.9; pct95w2=26.0; end;
if age_mw2=167 then do; pct05w2=16.5; pct85w2=23.9; pct95w2=26.0; end;
if age_mw2=168 then do; pct05w2=16.5; pct85w2=23.9; pct95w2=26.0; end;
if age_mw2=169 then do; pct05w2=16.6; pct85w2=24.0; pct95w2=26.0; end;
if age_mw2=170 then do; pct05w2=16.6; pct85w2=24.0; pct95w2=26.1; end;
if age_mw2=171 then do; pct05w2=16.7; pct85w2=24.0; pct95w2=26.1; end;
if age_mw2=172 then do; pct05w2=16.7; pct85w2=24.0; pct95w2=26.1; end;
if age_mw2=173 then do; pct05w2=16.7; pct85w2=24.1; pct95w2=26.1; end;
if age_mw2=174 then do; pct05w2=16.8; pct85w2=24.1; pct95w2=26.1; end;
if age_mw2=175 then do; pct05w2=16.8; pct85w2=24.1; pct95w2=26.1; end;
if age_mw2=176 then do; pct05w2=16.9; pct85w2=24.1; pct95w2=26.2; end;
if age_mw2=177 then do; pct05w2=16.9; pct85w2=24.2; pct95w2=26.2; end;
if age_mw2=178 then do; pct05w2=17.0; pct85w2=24.2; pct95w2=26.2; end;
if age_mw2=179 then do; pct05w2=17.0; pct85w2=24.2; pct95w2=26.2; end;
if age_mw2=180 then do; pct05w2=17.0; pct85w2=24.2; pct95w2=26.2; end;
if age_mw2=181 then do; pct05w2=17.1; pct85w2=24.3; pct95w2=26.2; end;
if age_mw2=182 then do; pct05w2=17.1; pct85w2=24.3; pct95w2=26.3; end;
end;

/*여자 162-182*/
if sexw1=2 then do; 

if age_mw2=162 then do; pct05w2=16.1; pct85w2=23.0; pct95w2=25.0; end;
if age_mw2=163 then do; pct05w2=16.2; pct85w2=23.0; pct95w2=25.0; end;
if age_mw2=164 then do; pct05w2=16.2; pct85w2=23.1; pct95w2=25.1; end;
if age_mw2=165 then do; pct05w2=16.3; pct85w2=23.1; pct95w2=25.1; end;
if age_mw2=166 then do; pct05w2=16.3; pct85w2=23.2; pct95w2=25.1; end;
if age_mw2=167 then do; pct05w2=16.4; pct85w2=23.2; pct95w2=25.2; end;
if age_mw2=168 then do; pct05w2=16.4; pct85w2=23.3; pct95w2=25.2; end;
if age_mw2=169 then do; pct05w2=16.5; pct85w2=23.3; pct95w2=25.2; end;
if age_mw2=170 then do; pct05w2=16.5; pct85w2=23.3; pct95w2=25.2; end;
if age_mw2=171 then do; pct05w2=16.6; pct85w2=23.3; pct95w2=25.3; end;
if age_mw2=172 then do; pct05w2=16.6; pct85w2=23.4; pct95w2=25.3; end;
if age_mw2=173 then do; pct05w2=16.6; pct85w2=23.4; pct95w2=25.3; end;
if age_mw2=174 then do; pct05w2=16.7; pct85w2=23.4; pct95w2=25.3; end;
if age_mw2=175 then do; pct05w2=16.7; pct85w2=23.5; pct95w2=25.3; end;
if age_mw2=176 then do; pct05w2=16.8; pct85w2=23.5; pct95w2=25.4; end;
if age_mw2=177 then do; pct05w2=16.8; pct85w2=23.5; pct95w2=25.4; end;
if age_mw2=178 then do; pct05w2=16.9; pct85w2=23.6; pct95w2=25.4; end;
if age_mw2=179 then do; pct05w2=16.9; pct85w2=23.6; pct95w2=25.4; end;
if age_mw2=180 then do; pct05w2=16.9; pct85w2=23.6; pct95w2=25.4; end;
if age_mw2=181 then do; pct05w2=17.0; pct85w2=23.6; pct95w2=25.4; end;
if age_mw2=182 then do; pct05w2=17.0; pct85w2=23.6; pct95w2=25.5; end;
end;

*BMI 카테고리;
if bmiw2^=. then do;
if bmiw2<pct05w2 then bmi_cw2=1;
else if pct05w2<=bmiw2<pct85w2 then bmi_cw2=2;
else if pct85w2<=bmiw2<pct95w2 then bmi_cw2=3;
else bmi_cw2=4;
end;

*비만;
if bmi_cw2^=. then do;
if bmi_cw2 in (1:3) then obesityw2=0;
else obesityw2=1;
end;


/********************************************** w3 *************************************************/
*BMI;
heightw3=yphy2a00w3/100;
weightw3=yphy2b00w3;
if yphy2a00w3^=. and yphy2b00w3^=. then bmiw3=weightw3/(heightw3*heightw3);

/*남자 174-194*/

if sexw1=1 then do; 

if age_mw3=174 then do; pct05w3=16.8; pct85w3=24.1; pct95w3=26.1; end;
if age_mw3=175 then do; pct05w3=16.8; pct85w3=24.1; pct95w3=26.1; end;
if age_mw3=176 then do; pct05w3=16.9; pct85w3=24.1; pct95w3=26.2; end;
if age_mw3=177 then do; pct05w3=16.9; pct85w3=24.2; pct95w3=26.2; end;
if age_mw3=178 then do; pct05w3=17.0; pct85w3=24.2; pct95w3=26.2; end;
if age_mw3=179 then do; pct05w3=17.0; pct85w3=24.2; pct95w3=26.2; end;
if age_mw3=180 then do; pct05w3=17.0; pct85w3=24.2; pct95w3=26.2; end;
if age_mw3=181 then do; pct05w3=17.1; pct85w3=24.3; pct95w3=26.2; end;
if age_mw3=182 then do; pct05w3=17.1; pct85w3=24.3; pct95w3=26.3; end;
if age_mw3=183 then do; pct05w3=17.2; pct85w3=24.3; pct95w3=26.3; end;
if age_mw3=184 then do; pct05w3=17.2; pct85w3=24.3; pct95w3=26.3; end;
if age_mw3=185 then do; pct05w3=17.2; pct85w3=24.4; pct95w3=26.3; end;
if age_mw3=186 then do; pct05w3=17.3; pct85w3=24.4; pct95w3=26.3; end;
if age_mw3=187 then do; pct05w3=17.3; pct85w3=24.4; pct95w3=26.3; end;
if age_mw3=188 then do; pct05w3=17.4; pct85w3=24.4; pct95w3=26.4; end;
if age_mw3=189 then do; pct05w3=17.4; pct85w3=24.5; pct95w3=26.4; end;
if age_mw3=190 then do; pct05w3=17.4; pct85w3=24.5; pct95w3=26.4; end;
if age_mw3=191 then do; pct05w3=17.5; pct85w3=24.5; pct95w3=26.4; end;
if age_mw3=192 then do; pct05w3=17.5; pct85w3=24.5; pct95w3=26.4; end;
if age_mw3=193 then do; pct05w3=17.5; pct85w3=24.6; pct95w3=26.4; end;
if age_mw3=194 then do; pct05w3=17.6; pct85w3=24.6; pct95w3=26.5; end;
end;

/*여자 174-194*/
if sexw1=2 then do; 

if age_mw3=174 then do; pct05w3=16.7; pct85w3=23.4; pct95w3=25.3; end;
if age_mw3=175 then do; pct05w3=16.7; pct85w3=23.5; pct95w3=25.3; end;
if age_mw3=176 then do; pct05w3=16.8; pct85w3=23.5; pct95w3=25.4; end;
if age_mw3=177 then do; pct05w3=16.8; pct85w3=23.5; pct95w3=25.4; end;
if age_mw3=178 then do; pct05w3=16.9; pct85w3=23.6; pct95w3=25.4; end;
if age_mw3=179 then do; pct05w3=16.9; pct85w3=23.6; pct95w3=25.4; end;
if age_mw3=180 then do; pct05w3=16.9; pct85w3=23.6; pct95w3=25.4; end;
if age_mw3=181 then do; pct05w3=17.0; pct85w3=23.6; pct95w3=25.4; end;
if age_mw3=182 then do; pct05w3=17.0; pct85w3=23.6; pct95w3=25.5; end;
if age_mw3=183 then do; pct05w3=17.0; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=184 then do; pct05w3=17.1; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=185 then do; pct05w3=17.1; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=186 then do; pct05w3=17.1; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=187 then do; pct05w3=17.2; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=188 then do; pct05w3=17.2; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=189 then do; pct05w3=17.2; pct85w3=23.7; pct95w3=25.5; end;
if age_mw3=190 then do; pct05w3=17.3; pct85w3=23.8; pct95w3=25.5; end;
if age_mw3=191 then do; pct05w3=17.3; pct85w3=23.8; pct95w3=25.5; end;
if age_mw3=192 then do; pct05w3=17.3; pct85w3=23.8; pct95w3=25.5; end;
if age_mw3=193 then do; pct05w3=17.3; pct85w3=23.8; pct95w3=25.5; end;
if age_mw3=194 then do; pct05w3=17.3; pct85w3=23.8; pct95w3=25.5; end;
end;

*BMI 카테고리;
if bmiw3^=. then do;
if bmiw3<pct05w3 then bmi_cw3=1;
else if pct05w3<=bmiw3<pct85w3 then bmi_cw3=2;
else if pct85w3<=bmiw3<pct95w3 then bmi_cw3=3;
else bmi_cw3=4;
end;

*비만;
if bmi_cw3^=. then do;
if bmi_cw3 in (1:3) then obesityw3=0;
else obesityw3=1;
end;


/********************************************** w4 *************************************************/
*BMI;
heightw4=yphy2a00w4/100;
weightw4=yphy2b00w4;
if yphy2a00w4^=. and yphy2b00w4^=. then bmiw4=weightw4/(heightw4*heightw4);

/*남자 186-206 */

if sexw1=1 then do; 

if age_mw4=186 then do; pct05w4=17.3; pct85w4=24.4; pct95w4=26.3; end;
if age_mw4=187 then do; pct05w4=17.3; pct85w4=24.4; pct95w4=26.3; end;
if age_mw4=188 then do; pct05w4=17.4; pct85w4=24.4; pct95w4=26.4; end;
if age_mw4=189 then do; pct05w4=17.4; pct85w4=24.5; pct95w4=26.4; end;
if age_mw4=190 then do; pct05w4=17.4; pct85w4=24.5; pct95w4=26.4; end;
if age_mw4=191 then do; pct05w4=17.5; pct85w4=24.5; pct95w4=26.4; end;
if age_mw4=192 then do; pct05w4=17.5; pct85w4=24.5; pct95w4=26.4; end;
if age_mw4=193 then do; pct05w4=17.5; pct85w4=24.6; pct95w4=26.4; end;
if age_mw4=194 then do; pct05w4=17.6; pct85w4=24.6; pct95w4=26.5; end;
if age_mw4=195 then do; pct05w4=17.6; pct85w4=24.6; pct95w4=26.5; end;
if age_mw4=196 then do; pct05w4=17.6; pct85w4=24.6; pct95w4=26.5; end;
if age_mw4=197 then do; pct05w4=17.7; pct85w4=24.7; pct95w4=26.5; end;
if age_mw4=198 then do; pct05w4=17.7; pct85w4=24.7; pct95w4=26.5; end;
if age_mw4=199 then do; pct05w4=17.7; pct85w4=24.7; pct95w4=26.6; end;
if age_mw4=200 then do; pct05w4=17.8; pct85w4=24.7; pct95w4=26.6; end;
if age_mw4=201 then do; pct05w4=17.8; pct85w4=24.7; pct95w4=26.6; end;
if age_mw4=202 then do; pct05w4=17.8; pct85w4=24.8; pct95w4=26.6; end;
if age_mw4=203 then do; pct05w4=17.9; pct85w4=24.8; pct95w4=26.6; end;
if age_mw4=204 then do; pct05w4=17.9; pct85w4=24.8; pct95w4=26.7; end;
if age_mw4=205 then do; pct05w4=17.9; pct85w4=24.8; pct95w4=26.7; end;
if age_mw4=206 then do; pct05w4=18.0; pct85w4=24.9; pct95w4=26.7; end;
end;

/*여자 186-206 */
if sexw1=2 then do; 

if age_mw4=186 then do; pct05w4=17.1; pct85w4=23.7; pct95w4=25.5; end;
if age_mw4=187 then do; pct05w4=17.2; pct85w4=23.7; pct95w4=25.5; end;
if age_mw4=188 then do; pct05w4=17.2; pct85w4=23.7; pct95w4=25.5; end;
if age_mw4=189 then do; pct05w4=17.2; pct85w4=23.7; pct95w4=25.5; end;
if age_mw4=190 then do; pct05w4=17.3; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=191 then do; pct05w4=17.3; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=192 then do; pct05w4=17.3; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=193 then do; pct05w4=17.3; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=194 then do; pct05w4=17.3; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=195 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=196 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=197 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=198 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=199 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=200 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=201 then do; pct05w4=17.4; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=202 then do; pct05w4=17.5; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=203 then do; pct05w4=17.5; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=204 then do; pct05w4=17.5; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=205 then do; pct05w4=17.5; pct85w4=23.8; pct95w4=25.5; end;
if age_mw4=206 then do; pct05w4=17.5; pct85w4=23.8; pct95w4=25.5; end;
end;

*BMI 카테고리;
if bmiw4^=. then do;
if bmiw4<pct05w4 then bmi_cw4=1;
else if pct05w4<=bmiw4<pct85w4 then bmi_cw4=2;
else if pct85w4<=bmiw4<pct95w4 then bmi_cw4=3;
else bmi_cw4=4;
end;

*비만;
if bmi_cw4^=. then do;
if bmi_cw4 in (1:3) then obesityw4=0;
else obesityw4=1;
end;



/*************/
/* depression */
/*************/

/********************************************** w1 (baseline) *************************************************/
depress1w1=ypsy4e01w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w1=ypsy4e02w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w1=ypsy4e03w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w1=ypsy4e04w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w1=ypsy4e05w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w1=ypsy4e06w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w1=ypsy4e07w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w1=ypsy4e08w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w1=ypsy4e09w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w1=ypsy4e10w1; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw1=sum(depress1w1, depress2w1, depress3w1, depress4w1, depress5w1, depress6w1, depress7w1, depress8w1, depress9w1, depress10w1); *range 10-40;


/********************************************** w2 *************************************************/
depress1w2=ypsy4e01w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w2=ypsy4e02w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w2=ypsy4e03w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w2=ypsy4e04w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w2=ypsy4e05w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w2=ypsy4e06w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w2=ypsy4e07w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w2=ypsy4e08w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w2=ypsy4e09w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w2=ypsy4e10w2; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw2=sum(depress1w2, depress2w2, depress3w2, depress4w2, depress5w2, depress6w2, depress7w2, depress8w2, depress9w2, depress10w2); 
*range 10-40;


/********************************************** w3 *************************************************/
depress1w3=ypsy4e01w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w3=ypsy4e02w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w3=ypsy4e03w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w3=ypsy4e04w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w3=ypsy4e05w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w3=ypsy4e06w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w3=ypsy4e07w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w3=ypsy4e08w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w3=ypsy4e09w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w3=ypsy4e10w3; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw3=sum(depress1w3, depress2w3, depress3w3, depress4w3, depress5w3, depress6w3, depress7w3, depress8w3, depress9w3, depress10w3); 
*range 10-40;


/********************************************** w4 *************************************************/
depress1w4=ypsy4e01w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress2w4=ypsy4e02w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress3w4=ypsy4e03w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress4w4=ypsy4e04w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress5w4=ypsy4e05w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress6w4=ypsy4e06w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress7w4=ypsy4e07w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress8w4=ypsy4e08w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress9w4=ypsy4e09w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;
depress10w4=ypsy4e10w4; *1-4 categoreis: 전혀 그렇지 않다 - 매우 그렇다;

depsumw4=sum(depress1w4, depress2w4, depress3w4, depress4w4, depress5w4, depress6w4, depress7w4, depress8w4, depress9w4, depress10w4); 
*range 10-40;


run;


/***************************/
/* generating permanent data */
/***************************/
data a.e4; set e4; run;
data a.m1; set m1; run;
data a.all; set e4 m1; run;
data all; set a.all; run;



/**************/
/* obesity data */
/**************/
data obe; set a.all;
if obesityw1 in (0,1) and obesityw4 in (0,1);
run;
*2018년, 2021년 비만 결측 아닌사람만 포함;
data obe2; set obe;
if obesityw1=0;
run;
*2018년 비만 아니었던 사람만 포함;
data obe3; set obe2;
if obesityw2=1 or obesityw3=1 or obesityw4=1 then obe_tot=1;
else obe_tot=0;
run;
* obe_tot: 2019, 2020, 2021 중 한번이라도 비만이었던 사람=1 ;
/*obe_all*/
data obe_all; set obe3; run;
/*obe_e4*/
data obe_e4; set obe3;
if schoolw1=1;
run;*n=2024;
/*obe_m1*/
data obe_m1; set obe3;
if schoolw1=2;
run;*n=2061;



/******************/
/* depression data */
/******************/
data all; set all;
if total_new ne . then do;
if total_new=2 then dep_total_new=1;
else if total_new=1 then dep_total_new=2;
else if total_new=3 then dep_total_new=3;
else if total_new=4 then dep_total_new=4;
else if total_new=5 then dep_total_new=5;
end;

if total_60a ne . then do;
if total_60a=2 then dep_total_60a=1;
else if total_60a=1 then dep_total_60a=2;
else if total_60a=3 then dep_total_60a=3;
else if total_60a=4 then dep_total_60a=4;
else if total_60a=5 then dep_total_60a=5;
else if total_60a=6 then dep_total_60a=6;
end;

if sp_new ne . then do;
if sp_new=2 then dep_sp_new=1;
else if sp_new=1 then dep_sp_new=2;
else if sp_new=3 then dep_sp_new=3;
else if sp_new=4 then dep_sp_new=4;
else if sp_new=5 then dep_sp_new=5;
end;

if com_new ne . then do;
if com_new=2 then dep_com_new=1;
else if com_new=1 then dep_com_new=2;
else if com_new=3 then dep_com_new=3;
else if com_new=4 then dep_com_new=4;
end;

if tv_new ne . then do;
if tv_new=2 then dep_tv_new=1;
else if tv_new=1 then dep_tv_new=2;
else if tv_new=3 then dep_tv_new=3;
else if tv_new=4 then dep_tv_new=4;
end;
run;

data dep; set all;
if depsumw1 ne .;
run;
data dep_e4; set dep;
if schoolw1=1;
run;
data dep_m1; set dep;
if schoolw1=2;
run;

*2018, 2019 우울 결측 아닌사람만 포함;
data dep19; set all;
if depsumw1 ne . and depsumw2 ne .;
run;
data dep19_e4; set dep19;
if schoolw1=1;
run;
data dep19_m1; set dep19;
if schoolw1=2;
run;




/************/
/* sensitivity */
/************/

data e4; set e4;
sub_health=sum(ypsy4c01w1, ypsy4c02w1, ypsy4c03w1, ypsy4c04w1, ypsy4c05w1, ypsy4c06w1, ypsy4c07w1, ypsy4c08w1);
run;

data m1; set m1;
sub_health=sum(ypsy4c01w1, ypsy4c02w1, ypsy4c03w1, ypsy4c04w1, ypsy4c05w1, ypsy4c06w1, ypsy4c07w1, ypsy4c08w1);
run;

proc univariate data=m1; var sub_health; run;

data sen_e4; set e4;
if sub_health>17 then delete;
run;
data sen_m1; set m1;
if sub_health>18  then delete;
run;

data sen_all; set sen_e4 sen_m1; run;


/******/
/* HR */
/******/

data hr_e4; set e4;
if obesityw1=1 then delete;
if obesityw2=1 or obesityw3=1 or obesityw4=1 then obe_inc=1; else obe_inc=0;

if obesityw2 in (1,0) or obesityw3 in (1,0) or obesityw4 in (1,0) then do;
if obesityw2=1 or (obesityw2=0 and obesityw3=. and obesityw4=.) then py=intck('day',surveydayw1,surveydayw2);
else if (obesityw2 in (.,0) and obesityw3=1) or (obesityw2 in (.,0) and obesityw3=0 and obesityw4=.) then py=intck('day',surveydayw1,surveydayw3);
else if obesityw2 in (.,0) and obesityw3 in (.,0) and obesityw4 in (1,0) then py=intck('day',surveydayw1,surveydayw4);
end;

entry_age=age_mw1;
exit_age=age_mw1+py;
run;

data hr_m1; set m1;
if obesityw1=1 then delete;
if obesityw2=1 or obesityw3=1 or obesityw4=1 then obe_inc=1; else obe_inc=0;

if obesityw2 in (1,0) or obesityw3 in (1,0) or obesityw4 in (1,0) then do;
if obesityw2=1 or (obesityw2=0 and obesityw3=. and obesityw4=.) then py=intck('day',surveydayw1,surveydayw2);
else if (obesityw2 in (.,0) and obesityw3=1) or (obesityw2 in (.,0) and obesityw3=0 and obesityw4=.) then py=intck('day',surveydayw1,surveydayw3);
else if obesityw2 in (.,0) and obesityw3 in (.,0) and obesityw4 in (1,0) then py=intck('day',surveydayw1,surveydayw4);
end;

entry_age=age_mw1;
exit_age=age_mw1+py;
run;

data hr_all; set hr_e4 hr_m1; run;

/*
if obesityw4 in (1,0) then py=intck('day',surveydayw1,surveydayw4);
else if obesityw4=. and obesityw3 in (1,0) then py=intck('day',surveydayw1,surveydayw3);
else if obesityw4=. and obesityw3=. and obesityw2 in (1,0) then py=intck('day',surveydayw1,surveydayw2);
end;
run;
