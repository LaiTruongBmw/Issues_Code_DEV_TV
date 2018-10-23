select PK, T.C6, SUBSTR(T.C6, -4)||SUBSTR(T.C6, 4, 2)||SUBSTR(T.C6, 1, 2) from tmp_cnv3 t
WHERE HR_F_CHECK_DATE(SUBSTR(T.C6, -4)||SUBSTR(T.C6, 4, 2)||SUBSTR(T.C6, 1, 2)) =0

SELECT * FROM TMP_CNV3

select * from tmp_cnv3 t
--where length(t.c6) <> 10

UPDATE TMP_CNV3 T
SET T.C30 = (CASE WHEN T.C7 = 'HÐ th?i v?' THEN '03'
                 WHEN T.C7 =  'HÐ th? vi?c (chua d? tu?i)' THEN '04'
                 WHEN T.C7 = 'HÐLÐ 12 tháng' THEN '05'
                 WHEN T.C7 = 'HÐLÐ 24 tháng' THEN '06'
                 WHEN T.C7 = 'HÐLÐ 36 tháng' THEN '07'
                 WHEN T.C7 = 'HÐLÐ không xác d?nh th?i h?n' THEN '08' END)
WHERE T.C7 IS NOT NULL

SELECT * FROM TMP_CNV3 T
WHERE T.C30 IS NULL 
AND T.C7 IS NOT NULL

UPDATE TMP_CNV3 T
SET T.C31 = (CASE WHEN T.C10 = 'HÐ th?i v?' THEN '03'
                  WHEN T.C10 = 'HÐLÐ th?i v?' THEN '03'
                 WHEN T.C10 =  'HÐ th? vi?c (chua d? tu?i)' THEN '04'
                 WHEN T.C10 = 'HÐLÐ 12 tháng' THEN '05'
                 WHEN T.C10 = 'HÐLÐ 24 tháng' THEN '06'
                 WHEN T.C10 = 'HÐLÐ 36 tháng' THEN '07'
                 WHEN T.C10 = 'HÐLÐ không xác d?nh th?i h?n' THEN '08' END)
WHERE T.C10 IS NOT NULL

SELECT * FROM TMP_CNV3 T
WHERE T.C31 IS NULL 
AND T.C10 IS NOT NULL

UPDATE TMP_CNV3 T
SET T.C32 = (CASE WHEN T.C13 = 'HÐ th?i v?' THEN '03'
                  
                 WHEN T.C13 =  'HÐ th? vi?c (chua d? tu?i)' THEN '04'
                 WHEN T.C13 = 'HÐLÐ 12 tháng' THEN '05'
                 WHEN T.C13 = 'HÐLÐ 24 tháng' THEN '06'
                 WHEN T.C13 = 'HÐLÐ 36 tháng' THEN '07'
                 WHEN T.C13 = 'HÐLÐ không xác d?nh th?i h?n' THEN '08' END)
WHERE T.C13 IS NOT NULL

SELECT * FROM TMP_CNV3 T
WHERE T.C32 IS NULL 
AND T.C13 IS NOT NULL

-- HOP DONG THU 1

insert into thr_labour_contract a(pk, thr_employee_pk, A.PROB_TYPE, begin_probation, end_probation
, A.CONTRACT_TYPE, A.CONTRACT_NO, A.CONTRACT_TIMES, A.BEGIN_CONTRACT, A.END_CONTRACT
, A.POS_TYPE, A.JOB_TYPE, del_if, crt_by, crt_dt)
select thr_labour_contract_seq.nextval, e.pk, E.PROB_TYPE, NVL(E.BEGIN_PROBATION, E.JOIN_DT), NVL(E.END_PROBATION, E.JOIN_DT)
, '01', t.c1||'/1', 1, DECODE(T.C5, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c5 , 'dd/mm/yyyy'), 'yyyymmdd')) 
, DECODE(T.C6, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c6, 'dd/mm/yyyy'), 'yyyymmdd')) 
, E.POS_TYPE, E.JOB_TYPE, 0, 'MR PHONG', sysdate
from tmp_cnv3 t, thr_employee e
where t.c1 = e.emp_id

update thr_employee a
set (A.CONTRACT_NO, A.CONTRACT_TIMES, A.CONTRACT_TYPE)
    = (select C.CONTRACT_NO, C.CONTRACT_TIMES, C.CONTRACT_TYPE from thr_labour_contract c
            where c.del_if=0
            and C.THR_EMPLOYEE_PK = a.pk
            and C.CONTRACT_TIMES = 1)
            

-- HOP DONG THU 2

insert into thr_labour_contract a(pk, thr_employee_pk, A.PROB_TYPE, begin_probation, end_probation
, A.CONTRACT_TYPE, A.CONTRACT_NO, A.CONTRACT_TIMES, A.BEGIN_CONTRACT, A.END_CONTRACT
, A.POS_TYPE, A.JOB_TYPE, del_if, crt_by, crt_dt)
select thr_labour_contract_seq.nextval, e.pk, E.PROB_TYPE, NVL(E.BEGIN_PROBATION, E.JOIN_DT), NVL(E.END_PROBATION, E.JOIN_DT)
, T.C30, t.c1||'/2', 2, DECODE(T.C8, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c8 , 'dd/mm/yyyy'), 'yyyymmdd')) 
, DECODE(T.C9, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c9, 'dd/mm/yyyy'), 'yyyymmdd')) 
, E.POS_TYPE, E.JOB_TYPE, 0, 'MR PHONG', sysdate
from tmp_cnv3 t, thr_employee e
where t.c1 = e.emp_id
AND T.C30 IS NOT NULL

update thr_employee a
set (A.CONTRACT_NO, A.CONTRACT_TIMES, A.CONTRACT_TYPE)
    = (select C.CONTRACT_NO, C.CONTRACT_TIMES, C.CONTRACT_TYPE from thr_labour_contract c
            where c.del_if=0
            and C.THR_EMPLOYEE_PK = a.pk
            and C.CONTRACT_TIMES = 2)
WHERE A.DEL_IF=0
AND A.PK IN (SELECT C.THR_EMPLOYEE_PK FROM THR_LABOUR_CONTRACT C WHERE C.DEL_iF=0
                AND C.CONTRACT_TIMES = 2)
                
                
-- HOP DONG THU 3

insert into thr_labour_contract a(pk, thr_employee_pk, A.PROB_TYPE, begin_probation, end_probation
, A.CONTRACT_TYPE, A.CONTRACT_NO, A.CONTRACT_TIMES, A.BEGIN_CONTRACT, A.END_CONTRACT
, A.POS_TYPE, A.JOB_TYPE, del_if, crt_by, crt_dt)
select thr_labour_contract_seq.nextval, e.pk, E.PROB_TYPE, NVL(E.BEGIN_PROBATION, E.JOIN_DT), NVL(E.END_PROBATION, E.JOIN_DT)
, T.C31, t.c1||'/3', 3, DECODE(T.C11, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c11 , 'dd/mm/yyyy'), 'yyyymmdd')) 
, DECODE(T.C12, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c12, 'dd/mm/yyyy'), 'yyyymmdd')) 
, E.POS_TYPE, E.JOB_TYPE, 0, 'MR PHONG', sysdate
from tmp_cnv3 t, thr_employee e
where t.c1 = e.emp_id
AND T.C31 IS NOT NULL

update thr_employee a
set (A.CONTRACT_NO, A.CONTRACT_TIMES, A.CONTRACT_TYPE)
    = (select C.CONTRACT_NO, C.CONTRACT_TIMES, C.CONTRACT_TYPE from thr_labour_contract c
            where c.del_if=0
            and C.THR_EMPLOYEE_PK = a.pk
            and C.CONTRACT_TIMES = 3)
WHERE A.DEL_IF=0
AND A.PK IN (SELECT C.THR_EMPLOYEE_PK FROM THR_LABOUR_CONTRACT C WHERE C.DEL_iF=0
                AND C.CONTRACT_TIMES = 3)
                
                
 -- HOP DONG THU 4

insert into thr_labour_contract a(pk, thr_employee_pk, A.PROB_TYPE, begin_probation, end_probation
, A.CONTRACT_TYPE, A.CONTRACT_NO, A.CONTRACT_TIMES, A.BEGIN_CONTRACT, A.END_CONTRACT
, A.POS_TYPE, A.JOB_TYPE, del_if, crt_by, crt_dt)
select thr_labour_contract_seq.nextval, e.pk, E.PROB_TYPE, NVL(E.BEGIN_PROBATION, E.JOIN_DT), NVL(E.END_PROBATION, E.JOIN_DT)
, T.C32, t.c1||'/4', 4, DECODE(T.C14, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c14 , 'dd/mm/yyyy'), 'yyyymmdd')) 
, DECODE(T.C15, '0', E.JOIN_DT, NULL, E.JOIN_DT, to_char(to_date(t.c15, 'dd/mm/yyyy'), 'yyyymmdd')) 
, E.POS_TYPE, E.JOB_TYPE, 0, 'MR PHONG', sysdate
from tmp_cnv3 t, thr_employee e
where t.c1 = e.emp_id
AND T.C32 IS NOT NULL

update thr_employee a
set (A.CONTRACT_NO, A.CONTRACT_TIMES, A.CONTRACT_TYPE)
    = (select C.CONTRACT_NO, C.CONTRACT_TIMES, C.CONTRACT_TYPE from thr_labour_contract c
            where c.del_if=0
            and C.THR_EMPLOYEE_PK = a.pk
            and C.CONTRACT_TIMES = 4)
WHERE A.DEL_IF=0
AND A.PK IN (SELECT C.THR_EMPLOYEE_PK FROM THR_LABOUR_CONTRACT C WHERE C.DEL_iF=0
                AND C.CONTRACT_TIMES = 4)