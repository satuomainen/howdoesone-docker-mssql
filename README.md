Get MS SQL Server running in Docker
===

These are my notes for getting MS SQL Server running in Docker on an Ubuntu host.


Tools in this directory
---

* `Dockerfile` - describes the image to be built
* `env.sh` - basic settings, names and such used by the build script and the run script
* `build.sh` - builds the Docker image
* `run.sh` - runs the docker image


Install MS SQL command line tools for Linux
---

See [installation instructions](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools#ubuntu)
or just do this:

* `curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`
* `curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list`
* `sudo apt-get update`
* `sudo apt-get install mssql-tools unixodbc-dev`
* Add `/opt/mssql-tools/bin/` to your PATH env variable (in `.profile`/`.bash_profile` or whatever you use)

The you can get started with `sqlcmd -S localhost,1433 -U SA -P 'VeryVeryS3cret'`. With the sysadmin user you can
create the database and the user you want your application to use.

Finally, if you have a database backup, use Microsoft SQL Server Management Studio to restore the database.


Potentially helpful MS SQL stuff
---

* Apparently in "Transact-SQL" you need to enter the command `GO` in order to run the SQL command...
* Create a database: `CREATE DATABASE database_name`
* Activate the new database: `USE database_name`
* Make configuration changes so that a user can be created associated with the new database:
  ```sql
  exec sp_configure 'contained database authentication', 1
  go
  reconfigure
  go
  alter database database_name set containment = partial
  go
  ```
* Create a user: `CREATE USER Mary WITH PASSWORD = '********';`. (NB! With default settings the username
  must contain lower case and upper case letters and at least one number)
* List all databases: `SELECT database_id, name FROM sys.databases;`
* List all tables: `Select Table_name as "Table name" From Information_schema.Tables
  Where Table_type = 'BASE TABLE' and Objectproperty (Object_id(Table_name), 'IsMsShipped') = 0;`
* Now you can connect to your database: `jdbc:sqlserver://localhost:1433;databaseName=database_name`
