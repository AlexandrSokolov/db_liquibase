@rem ##########################################################################
@rem                                                                         ##
@rem  Install database script via liquibase maven plugin                     ##
@rem                                                                         ##
@rem ##########################################################################

@rem To keep from seeing all of the statements printed to the console as they execute,
@rem and instead just see the output of those that specifically begin with echo
@echo off

set CURRENT_SCRIPT_NAME=%~n0

for %%* in (.) do set CurrDirName=%%~n*
IF "%CurrDirName%"=="scripts" (
    echo The script should be run as:  'scripts/%CURRENT_SCRIPT_NAME%' command, but not as simple: ./%CURRENT_SCRIPT_NAME%
    echo Please change the current folder in order to run the command correctly.
    exit -1
)

echo Install database via liquibase maven plugin

@rem possible db_type values:
@rem hsql_embedded, mysql, postgres

@rem to load production data add -Ddataset=production
@rem to load test data add -Ddataset=test
mvn clean install -Ddb_type=hsql_embedded -Ddataset=production initialize liquibase:update

echo To move output to log file, run: "scripts/%CURRENT_SCRIPT_NAME%" > db.log 2>&1

