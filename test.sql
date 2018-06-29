drop table if exists ced;
drop table if exists austmp;
drop table if exists census;

.mode csv
.separator ,
.import CED_2017_AUST.csv ced
.import 20180628-austmpdata.csv austmp
.import 2016Census_G01_AUS_SA1.csv census
.header on

select *, CED_NAME_2017 ||', '||STATE_NAME_2017 as district
  from ced ;


select * 
  from austmp 
 limit 5;


select SA1_7DIGITCODE_2016, Tot_P_M,Tot_P_F 
  from census 
 limit 5;


select twitter from austmp where twitter = ''; 
update austmp set twitter = null where twitter = '';