create database singo;

use singo;

select 유형별1, 유형별2, 2018총계,2019총계, 2020총계 from 신고자_유형
where 유형별2 != '소계';

select * from 학대_사례_학대행위자와_피해아동과의_관계 학사학피관;

-- select '부모 소계' from 재학대_사례_학대행위자와_피해아동과의_관계 학사학피관;

select `원가정보호 원가정보호 유지`, `가정복귀 소계`, `분리조치 소계`, `기타 소계`, `사망` from 피해아동_상황;

select 학.연도, 학.부모, 학.친인척, 학.대리양육자, 학.기타, 재.`부모 소계` as 재_부모, 재.`친인척 소계` as 재_친인척, 재.`대리양육자 소계` as 재_대리, 재.`기타 소계` as 재_기타 from 학대_사례_학대행위자와_피해아동과의_관계 학
inner join 
재학대_사례_학대행위자와_피해아동과의_관계 재
on 학.연도  = 재.연도;

select * from 신고자_유형;