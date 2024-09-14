select  C.company_code,
        C.founder,
        count(distinct L.lead_manager_code),
        count(distinct S.senior_manager_code),
        count(distinct M.manager_code),
        count(distinct E.employee_code) 
from    Company as C, Lead_manager as L, Senior_manager as S, 
        Manager as M, Employee as E
where   C.company_code = L.company_code and 
        L.lead_manager_code = S.lead_manager_code and
        S.senior_manager_code = M.senior_manager_code and
        M.manager_code = E.manager_code
group by C.company_code, C.founder
order by C.company_code asc
