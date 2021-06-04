library(redCohort)

#usethis::edit_r_environ()

# Maximum number of cores to be used:
maxCores <- parallel::detectCores() 

# The folder where the study intermediate and result files will be written:
outputFolder <- "c:/REDCDM"

# Details for connecting to the server:
connectionDetails <-
        DatabaseConnector::createConnectionDetails(
                dbms = Sys.getenv("usethis_dbms"),
                server = Sys.getenv("usethis_server"),
                user = Sys.getenv("usethis_user"),
                password = Sys.getenv("usethis_password"),
                port = Sys.getenv("usethis_port"),
                #pathToDriver=Sys.getenv("usethis_jdbc")
                )

# The name of the database schema where the CDM data can be found:
cdmDatabaseSchema <- ""

# The name of the database schema and table where the study-specific cohorts will be instantiated:
cohortDatabaseSchema <- ""
cohortTable <- ""

# Some meta-information that will be used by the export function:
databaseId <- "REDCDM"
databaseName <- "REDCDM"
databaseDescription <- "REDCDM"

# For Oracle: define a schema that can be used to emulate temp tables:
tempEmulationSchema <- NULL

redCohort::execute(
        connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        tempEmulationSchema = tempEmulationSchema,
        outputFolder = outputFolder,
        databaseId = databaseId,
        databaseName = databaseName,
        databaseDescription = databaseDescription,
        
)

CohortDiagnostics::preMergeDiagnosticsFiles(dataFolder = outputFolder)

CohortDiagnostics::launchDiagnosticsExplorer(dataFolder = outputFolder)

