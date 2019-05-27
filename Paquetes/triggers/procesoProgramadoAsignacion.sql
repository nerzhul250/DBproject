BEGIN
DBMS_SCHEDULER.DROP_JOB('job_asignacion');
COMMIT;
END;
/
BEGIN
DBMS_SCHEDULER.CREATE_JOB
(job_name        => 'job_asignacion',
job_type        =>'PLSQL_BLOCK',
job_action      =>'BEGIN pkAsignacionNivel2.asignacionProgramada; END;',
start_date      => SYSDATE,
repeat_interval =>'FREQ=MINUTELY;BYSECOND=50;INTERVAL=1',
 enabled         => true,
 auto_drop       => false,
  comments        => 'your description here.'
);
END;
/