select * from tmp_cnv2

insert into thr_employee a(pk, emp_id, id_num, full_name, full_fname, join_dt, birth_dt, A.THR_SALARY_MANAGE_PK , tco_company_pk
, tco_org_pk, A.PLACE_BIRTH, A.TEL, A.PRESENT_ADDR, A.PERMANENT_ADDR, a.sex, A.PERSON_ID
, A.ISSUE_DT, A.PLACE_PER_ID, A.NATION, A.ETHNIC_TYPE, A.EDU_TYPE, A.POS_TYPE
, A.PROB_TYPE, A.BEGIN_PROBATION, A.END_PROBATION, A.CONTRACT_TYPE, A.CONTRACT_NO, A.CONTRACT_TIMES
, A.SOCIAL_YN, A.HEALTH_YN, A.UNEMP_YN, A.SOCIAL_BOOK, A.SOCIAL_PLACE, A.SOCIAL_DT
, A.STATUS, A.LEFT_DT, A.PAY_TYPE, A.BANK_TYPE, A.BANK_BRANCH, A.ACCOUNT, A.PIT_TAX_NO)
select thr_employee_seq.nextval, t.c3, t.c5, t.c4, t.c4
, decode(t.c6, '0', '20000101', to_char(to_date(t.c6, 'dd/mm/yyyy'), 'yyyymmdd'))
, decode(length(t.c7) , 10, to_char(to_date(t.c7, 'dd/mm/yyyy'), 'yyyymmdd'), '20000101')
,1, 99 
, t.c2, t.c24, null , t.c17, t.c17, t.c20, t.c21
, decode(length(t.c22) , 10, to_char(to_date(t.c22, 'dd/mm/yyyy'), 'yyyymmdd'), '20000101')
, t.c24, t.c27, t.c29, t.c31, t.c34
, t.c36, to_char(to_date(t.c37, 'dd/mm/yyyy'), 'yyyymmdd'), to_char(to_date(t.c38, 'dd/mm/yyyy'), 'yyyymmdd'), '01', t.c3||'/1', 1
, t.c45, t.c45, t.c45, t.c46, t.c48
, decode(length(t.c49) , 10, to_char(to_date(t.c49, 'dd/mm/yyyy'), 'yyyymmdd'), '')
, t.c60, decode(length(t.c61) , 10, to_char(to_date(t.c61, 'dd/mm/yyyy'), 'yyyymmdd'), '')
, t.c63, t.c65, t.c67, t.c68, t.c70
from tmp_cnv2 t



select * from thr_employee a

DELETE THR_LABOUR_CONTRACT

select hr_sequence('VAUDE') FROM DUAL

delete thr_employee

create table thr_employee_21082018 as select * from thr_employee 


select t.c6 from tmp_cnv2 t
where length(t.c6) <> 10
