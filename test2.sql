.header on
.null null

-- https://twitter.com/pettulda/status/1012270311927001088
-- percentage of each party twitter active

drop view if exists ceddistrictcode;
create view ceddistrictcode as
select *, CED_NAME_2017 ||', '||STATE_NAME_2017 as district, substr(SA1_maincode_2016,5,7) as SA1_7DIGITCODE_2016
  from ced ;


select * 
  from austmp 
 limit 5;

select * 
  from census
  limit 2;

select SA1_7DIGITCODE_2016, Tot_P_M,Tot_P_F 
  from census 
 limit 5;

select name, district, sum(AREA_ALBERS_SQKM)
 from ceddistrictcode
 JOIN austmp USING (district)
GROUP BY name
limit 5;

select SA1_7DIGITCODE_2016, Tot_P_M,Tot_P_F, CED_NAME_2017 ||', '||STATE_NAME_2017
  from ceddistrictcode
  join census USING (SA1_7DIGITCODE_2016)
 limit 5;




select party, count(twitter), count(name)
  from austmp
  group by party;
  


-- exercise, figure out population of these districtis


select party, sum(AREA_ALBERS_SQKM)
  from (select *, CED_NAME_2017 ||', '||STATE_NAME_2017 as district from ced) ced 
  JOIN (select * from austmp) USING (district)
group by party;


drop view if exists totalPeopleDistrict;

create view totalPeopleDistrict as 
select district, sum(Tot_P_P) as totalPeopleDistrict
  from ceddistrictcode
  join census using (SA1_7DIGITCODE_2016)
  group by district;

select * from totalPeopleDistrict limit 5;

select party, sum(totalPeopleDistrict)
  from austmp
  join totalPeopleDistrict using (district)
  where twitter is not null
  group by party;
