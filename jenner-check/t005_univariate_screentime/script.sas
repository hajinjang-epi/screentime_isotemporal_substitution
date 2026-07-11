/* Adapted from analysis_cross-sectional.sas (hajinjang-epi/screentime_isotemporal_substitution)
   The opening proc univariate calls profile the distribution (mean, quartiles,
   extreme values) of the three daily screen-time components -- TV, computer,
   and smartphone use in minutes/day -- across the study's pooled and
   sub-cohort samples, ahead of the categorical exposure cut-points used
   later in the script. Kept unmodified except for reducing three separate
   univariate calls (cross_pool/cross_e4/cross_m1) to one representative
   cohort; the input rows below are synthetic (mock daily-minutes rows in
   place of the KCYPS2018 survey extract the original script reads via a
   local OneDrive libname). */

data cross_pool;
  input dayuse10w1 dayuse9w1 sp_usew1;
  datalines;
21.7 171.1 45.0
177.4 151.4 224.1
72.5 63.3 216.6
231.8 119.3 162.2
93.1 73.0 215.7
102.9 96.2 189.3
151.8 7.4 69.2
169.4 102.7 251.4
12.6 41.7 150.6
179.3 35.1 229.4
98.5 55.0 248.8
25.7 168.1 93.2
87.0 36.6 140.4
202.1 39.8 166.2
105.7 54.3 39.1
167.5 74.7 140.9
144.6 19.3 245.3
213.8 45.8 244.8
167.7 53.7 81.0
20.1 74.5 135.4
116.8 86.7 164.6
30.0 40.4 167.7
113.4 31.4 83.0
235.0 143.8 218.1
85.3 75.3 211.5
134.8 115.3 10.7
171.0 36.0 98.2
127.4 170.9 121.7
155.1 37.5 281.9
59.5 97.4 204.2
167.8 80.2 194.1
2.5 177.3 167.5
142.8 45.8 144.0
154.2 74.2 36.5
47.1 157.3 61.7
123.4 128.0 66.4
193.9 85.7 284.1
49.2 76.6 108.8
65.5 76.7 128.1
94.6 156.3 97.6
13.5 135.0 130.4
6.0 135.8 217.8
157.2 147.6 80.9
201.7 65.5 257.7
239.7 99.8 126.5
176.4 129.5 151.6
19.5 64.0 204.1
3.3 73.6 274.9
171.6 46.9 40.7
137.1 110.7 85.9
123.8 178.5 195.0
130.2 11.3 142.3
5.4 173.5 155.1
144.2 122.5 12.1
197.1 125.8 21.6
219.5 155.9 297.0
22.2 164.8 233.8
61.0 14.3 203.0
15.0 98.6 241.7
95.1 59.9 125.1
;
run;

proc univariate data=cross_pool;
var dayuse10w1 dayuse9w1 sp_usew1;
run;
