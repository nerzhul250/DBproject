BEGIN
DBMS_SCHEDULER.DROP_JOB('job_atencion');
COMMIT;
END;
/
BEGIN
DBMS_SCHEDULER.CREATE_JOB
(job_name        => 'job_atencion',
job_type        =>'PLSQL_BLOCK',
job_action      =>'BEGIN pkAtencionNivel2.pAutoAccept; END;',
start_date      => SYSDATE,
repeat_interval =>'FREQ=HOURLY;INTERVAL=12',
enabled         => true,
auto_drop       => false,
comments        => 'your description here.'
);
END;
/