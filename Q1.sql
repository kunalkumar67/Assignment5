CREATE PROCEDURE sp_export_data_to_csv
AS
BEGIN
    DECLARE @bcp_command NVARCHAR(4000)
    SET @bcp_command = 'bcp "SELECT * FROM your_table_name" queryout "C:\path\to\your_file.csv" -c -t, -S your_server_name -U your_username -P your_password'
    EXEC master..xp_cmdshell @bcp_command
END


CREATE PROCEDURE sp_export_data_to_parquet
AS
BEGIN
    DECLARE @parquet_command NVARCHAR(4000)
    SET @parquet_command = 'python -m sqlmlutils.parquet_export --server your_server_name --database your_database_name --username your_username --password your_password --query "SELECT * FROM your_table_name" --output "C:\path\to\your_file.parquet"'
    EXEC master..xp_cmdshell @parquet_command
END

CREATE PROCEDURE sp_export_data_to_avro
AS
BEGIN
    DECLARE @avro_command NVARCHAR(4000)
    SET @avro_command = 'python -m sqlavro.export --server your_server_name --database your_database_name --username your_username --password your_password --query "SELECT * FROM your_table_name" --output "C:\path\to\your_file.avro"'
    EXEC master..xp_cmdshell @avro_command