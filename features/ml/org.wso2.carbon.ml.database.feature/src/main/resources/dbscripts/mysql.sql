# DATASET
CREATE TABLE IF NOT EXISTS ML_DATASET_SCHEMA(
DATASET_SCHEMA_ID BIGINT AUTO_INCREMENT,
NAME VARCHAR(50),
TENANT_ID INT,
USERNAME VARCHAR(50),
COMMENTS TEXT,
SOURCE_TYPE VARCHAR(50),
TARGET_TYPE VARCHAR(50),
DATA_TYPE VARCHAR(50),
CONSTRAINT PK_DATASET_SCHEMA PRIMARY KEY(DATASET_SCHEMA_ID)
)DEFAULT CHARACTER SET = utf8;

# FEATURE_DEFAULTS
CREATE TABLE IF NOT EXISTS ML_FEATURE_DEFAULTS(
FEATURE_ID BIGINT AUTO_INCREMENT,
DATASET_SCHEMA_ID BIGINT,
FEATURE_INDEX INT,
FEATURE_NAME VARCHAR(100) NOT NULL,
TYPE VARCHAR(20),
CONSTRAINT PK_FEATURE_DEFAULTS PRIMARY KEY(FEATURE_ID),
CONSTRAINT FK_DATASET_SCHEMA_FEATURE_DEFAULTS FOREIGN KEY(DATASET_SCHEMA_ID) REFERENCES ML_DATASET_SCHEMA(DATASET_SCHEMA_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# DATASET_VERSION
CREATE TABLE IF NOT EXISTS ML_DATASET_VERSION(
DATASET_VERSION_ID BIGINT AUTO_INCREMENT,
DATASET_SCHEMA_ID BIGINT,
NAME VARCHAR(50),
VERSION VARCHAR(50),
TENANT_ID INT,
USERNAME VARCHAR(50),
URI VARCHAR(300),
SAMPLE_POINTS BLOB,
CONSTRAINT PK_DATASET_VERSION PRIMARY KEY(DATASET_VERSION_ID),
CONSTRAINT FK_DATASET_SCHEMA_DATASET_VERSION FOREIGN KEY(DATASET_SCHEMA_ID) REFERENCES ML_DATASET_SCHEMA(DATASET_SCHEMA_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# FEATURE_SUMMARY
CREATE TABLE IF NOT EXISTS ML_FEATURE_SUMMARY(
  FEATURE_ID BIGINT,
  FEATURE_NAME VARCHAR(100),
  DATASET_VERSION_ID BIGINT,
  SUMMARY TEXT,
  CONSTRAINT FK_FEATURE_DEFAULTS_FEATURE_SUMMARY FOREIGN KEY(FEATURE_ID) REFERENCES ML_FEATURE_DEFAULTS(FEATURE_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT FK_DATASET_VERSION_FEATURE_SUMMARY FOREIGN KEY(DATASET_VERSION_ID) REFERENCES ML_DATASET_VERSION(DATASET_VERSION_ID)
    ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# DATA_SOURCE
CREATE TABLE IF NOT EXISTS ML_DATA_SOURCE(
DATASET_VERSION_ID BIGINT,
TENANT_ID INT,
USERNAME VARCHAR(50),
`KEY` VARCHAR(50),
VALUE VARCHAR(50),
CONSTRAINT FK_DATASET_VERSION_DATA_SOURCE FOREIGN KEY(DATASET_VERSION_ID) REFERENCES ML_DATASET_VERSION(DATASET_VERSION_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# PROJECT
CREATE TABLE IF NOT EXISTS ML_PROJECT(
PROJECT_ID BIGINT AUTO_INCREMENT,
NAME VARCHAR(50),
DESCRIPTION VARCHAR(100),
DATASET_SCHEMA_ID BIGINT,
TENANT_ID INT,
USERNAME VARCHAR(5),
CREATED_TIME TIMESTAMP,
CONSTRAINT PK_PROJECT PRIMARY KEY(PROJECT_ID),
CONSTRAINT FK_DATASET_SCHEMA_PROJECT FOREIGN KEY(DATASET_SCHEMA_ID) REFERENCES ML_DATASET_SCHEMA(DATASET_SCHEMA_ID)
ON UPDATE CASCADE ON DELETE SET NULL
)DEFAULT CHARACTER SET = utf8;

# ANALYSIS
CREATE TABLE IF NOT EXISTS ML_ANALYSIS(
ANALYSIS_ID BIGINT AUTO_INCREMENT,
PROJECT_ID BIGINT,
NAME VARCHAR(50),
TENANT_ID INT,
USERNAME VARCHAR(50),
COMMENTS TEXT,
CONSTRAINT PK_ANALYSIS PRIMARY KEY(ANALYSIS_ID),
CONSTRAINT FK_PROJECT_ANALYSIS FOREIGN KEY(PROJECT_ID) REFERENCES ML_PROJECT(PROJECT_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# MODEL
CREATE TABLE IF NOT EXISTS ML_MODEL(
MODEL_ID BIGINT AUTO_INCREMENT,
NAME VARCHAR(100),
ANALYSIS_ID BIGINT,
DATASET_VERSION_ID BIGINT,
TENANT_ID INT,
USERNAME VARCHAR(50),
CREATED_TIME TIMESTAMP,
SUMMARY BLOB,
STORAGE_TYPE VARCHAR(50),
STORAGE_LOCATION VARCHAR(500),
STATUS VARCHAR(20),
ERROR VARCHAR(10000),
CONSTRAINT PK_MODEL PRIMARY KEY(MODEL_ID),
CONSTRAINT FK_ANALYSIS_MODEL FOREIGN KEY(ANALYSIS_ID) REFERENCES ML_ANALYSIS(ANALYSIS_ID)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_DATASET_VERSION_MODEL FOREIGN KEY(DATASET_VERSION_ID) REFERENCES ML_DATASET_VERSION(DATASET_VERSION_ID)
ON UPDATE CASCADE ON DELETE SET NULL
)DEFAULT CHARACTER SET = utf8;

# MODEL_CONFIGURATION
CREATE TABLE IF NOT EXISTS ML_MODEL_CONFIGURATION(
ANALYSIS_ID BIGINT,
`KEY` VARCHAR(50),
VALUE VARCHAR(50),
CONSTRAINT PK_MODEL_CONFIGURATION PRIMARY KEY(ANALYSIS_ID,`KEY`),
CONSTRAINT FK_ANALYSIS_MODEL_CONFIGURATION FOREIGN KEY(ANALYSIS_ID) REFERENCES ML_ANALYSIS(ANALYSIS_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# FEATURE_CUSTOMIZED
CREATE TABLE IF NOT EXISTS ML_FEATURE_CUSTOMIZED(
ANALYSIS_ID BIGINT,
TENANT_ID INT,
FEATURE_NAME VARCHAR(50),
FEATURE_INDEX INT,
FEATURE_TYPE VARCHAR(50),
IMPUTE_OPTION VARCHAR(50),
INCLUSION BOOLEAN,
LAST_MODIFIED_USER VARCHAR(50),
USERNAME VARCHAR(50),
LAST_MODIFIED_TIME TIMESTAMP,
FEATURE_ID BIGINT,
CONSTRAINT PK_FEATURE_CUSTOMIZED PRIMARY KEY(ANALYSIS_ID,FEATURE_NAME),
CONSTRAINT FK_FEATURE_DEFAULTS_FEATURE_CUSTOMIZED FOREIGN KEY(FEATURE_ID) REFERENCES ML_FEATURE_DEFAULTS(FEATURE_ID)
  ON UPDATE CASCADE ON DELETE SET NULL,
CONSTRAINT FK_MODEL_FEATURE_CUSTOMIZED FOREIGN KEY(ANALYSIS_ID) REFERENCES ML_ANALYSIS(ANALYSIS_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

# HYPER_PARAMETER
CREATE TABLE IF NOT EXISTS ML_HYPER_PARAMETER(
ANALYSIS_ID BIGINT,
ALGORITHM_NAME VARCHAR(50),
NAME VARCHAR(50),
TENANT_ID INT,
VALUE VARCHAR(50),
LAST_MODIFIED_USER VARCHAR(50),
USERNAME VARCHAR(50),
LAST_MODIFIED_TIME TIMESTAMP,
CONSTRAINT PK_HYPER_PARAMETER PRIMARY KEY(ANALYSIS_ID,NAME),
CONSTRAINT FK_MODEL_HYPER_PARAMETER FOREIGN KEY(ANALYSIS_ID) REFERENCES ML_ANALYSIS(ANALYSIS_ID)
ON UPDATE CASCADE ON DELETE CASCADE
)DEFAULT CHARACTER SET = utf8;

