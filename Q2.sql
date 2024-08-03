CREATE PROCEDURE sp_pipeline_process
AS
BEGIN
    EXEC sp_export_data_to_csv
    EXEC sp_export_data_to_parquet
    EXEC sp_export_data_to_avro
END


EXEC msdb.dbo.sp_add_job @job_name = 'Pipeline Process Job'

EXEC msdb.dbo.sp_add_jobstep @job_name = 'Pipeline Process Job',
    @step_name = 'Execute Pipeline Process',
    @step_id = 1,
    @cmdexec_success_code = 0,
    @on_success_action = 1,
    @on_fail_action = 2,
    @retry_attempts = 0,
    @retry_interval = 0,
    @os_run_priority = 0,
    @subsystem = 'TSQL',
    @command = 'EXEC sp_pipeline_process',
    @database_name = 'your_database_name'

EXEC msdb.dbo.sp_add_jobschedule @job_name = 'Pipeline Process Job',
    @name = 'Daily Pipeline Process',
    @enabled = 1,
    @freq_type = 4, -- Daily
    @freq_interval = 1, -- Every 1 day
    @freq_subday_type = 1, -- At a specific time
    @freq_subday_interval = 0,
    @freq_relative_interval = 0,
    @freq_recurrence_factor = 0,
    @active_start_date = 20230101,
    @active_end_date = 99991231,
    @active_start_time = 020000, -- 2:00 AM
    @active_end_time = 235959


CREATE TRIGGER tr_pipeline_process_on