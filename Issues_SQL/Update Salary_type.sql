--Select * from tmp_cnv4 t 
--where T.C3 not in (select a.emp_id from thr_employee a where a.del_if = 0 and t.c3 = a.emp_id) 


--Update thr_employee a
-- set  a.SALARY_TYPE = (select t.c7 from tmp_cnv4 t where t.c3 = a.emp_id)
--     ,a.crt_by = 'MR.LAI'
--     ,a.crt_dt = sysdate
--     ,a. remark = 'MR.LAI UPDATE SALARY_TYPE'
--Where a.del_if = 0 
--    and a.emp_id in (select t.c3 from tmp_cnv4 t )
    
--Select from thr_employee a where a.del_if = 0 

 