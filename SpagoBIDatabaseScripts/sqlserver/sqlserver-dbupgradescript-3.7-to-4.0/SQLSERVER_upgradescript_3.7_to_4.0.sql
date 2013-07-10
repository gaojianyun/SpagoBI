ALTER TABLE SBI_META_MODELS ADD CATEGORY_ID INTEGER NULL;

CREATE TABLE  SBI_EXT_ROLES_CATEGORY (
  EXT_ROLE_ID INTEGER NOT NULL,
  CATEGORY_ID INTEGER NOT NULL,
  PRIMARY KEY (EXT_ROLE_ID,CATEGORY_ID),
  CONSTRAINT FK_SB_EXT_ROLES_META_MODEL_CATEGORY_1 FOREIGN KEY (EXT_ROLE_ID) REFERENCES SBI_EXT_ROLES (EXT_ROLE_ID),
  CONSTRAINT FK_SB_EXT_ROLES_META_MODEL_CATEGORY_2 FOREIGN KEY (CATEGORY_ID) REFERENCES SBI_DOMAINS (VALUE_ID)
) ON [PRIMARY];

ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN IS_PERSISTED BIT DEFAULT 0;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN DATA_SOURCE_PERSIST_ID INTEGER NULL;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN IS_FLAT_DATASET BIT DEFAULT 0;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN FLAT_TABLE_NAME VARCHAR(50) NULL;
ALTER TABLE SBI_DATA_SET_HISTORY ADD COLUMN DATA_SOURCE_FLAT_ID INTEGER NULL;

ALTER TABLE SBI_DATA_SET_HISTORY ADD CONSTRAINT FK_SBI_DATA_SET_DS3 FOREIGN KEY ( DATA_SOURCE_PERSIST_ID ) REFERENCES SBI_DATA_SOURCE( DS_ID ) ON DELETE CASCADE;
ALTER TABLE SBI_DATA_SET_HISTORY ADD CONSTRAINT FK_SBI_DATA_SET_DS4 FOREIGN KEY ( DATA_SOURCE_FLAT_ID ) REFERENCES SBI_DATA_SOURCE( DS_ID ) ON DELETE CASCADE;

CREATE TABLE SBI_DATA_SET_TEMP (
	   DS_ID 		   		  INTEGER NOT NULL ,
	   VERSION_NUM	   		  INTEGER NOT NULL,
	   ACTIVE		   		  BIT NOT NULL,
	   DESCR 		   		  VARCHAR(160), 
	   LABEL	 	   		  VARCHAR(50) NOT NULL,
	   NAME	   	   			  VARCHAR(50) NOT NULL,   	   
	   OBJECT_TYPE   		  VARCHAR(50),
	   DS_METADATA    		  TEXT,
	   PARAMS         		  VARCHAR(4000),
	   CATEGORY_ID    		  INTEGER,
	   TRANSFORMER_ID 		  INTEGER,
       PIVOT_COLUMN   		  VARCHAR(50),
	   PIVOT_ROW      		  VARCHAR(50),
	   PIVOT_VALUE   		  VARCHAR(50),
	   NUM_ROWS	   		 	  BIT DEFAULT 0,	
	   IS_PERSISTED  		  BIT DEFAULT 0,
	   DATA_SOURCE_PERSIST_ID INTEGER NULL,
	   IS_FLAT_DATASET 		  SMALLINT DEFAULT 0,
	   FLAT_TABLE_NAME 		  VARCHAR(50) NULL,
	   DATA_SOURCE_FLAT_ID 	  INTEGER NULL,	   
	   CONFIGURATION          TEXT NULL,    	   	   
	   USER_IN                VARCHAR(100) NOT NULL,
	   USER_UP                VARCHAR(100),
	   USER_DE                VARCHAR(100),
	   TIME_IN                TIMESTAMP NOT NULL,
	   TIME_UP                TIMESTAMP NULL,
	   TIME_DE                TIMESTAMP NULL,
	   SBI_VERSION_IN         VARCHAR(10),
	   SBI_VERSION_UP         VARCHAR(10),
	   SBI_VERSION_DE         VARCHAR(10),
	   META_VERSION           VARCHAR(100),
	   ORGANIZATION           VARCHAR(20), 
	   CONSTRAINT AK2SBI_DATA_SET UNIQUE  (LABEL, VERSION_NUM, ORGANIZATION),
       CONSTRAINT PK_SBI_DATA_SET PRIMARY KEY  CLUSTERED(DS_ID, VERSION_NUM)
) ON [PRIMARY];

INSERT INTO SBI_DATA_SET_TEMP 
(DS_ID, VERSION_NUM, ACTIVE,  LABEL, DESCR, NAME, OBJECT_TYPE, DS_METADATA, PARAMS, CATEGORY_ID, TRANSFORMER_ID, PIVOT_COLUMN, PIVOT_ROW, PIVOT_VALUE, NUM_ROWS, IS_PERSISTED, 
DATA_SOURCE_PERSIST_ID, IS_FLAT_DATASET, FLAT_TABLE_NAME, DATA_SOURCE_FLAT_ID, USER_IN, USER_UP, USER_DE, TIME_IN, TIME_UP, TIME_DE, SBI_VERSION_IN, SBI_VERSION_UP, SBI_VERSION_DE,
META_VERSION, ORGANIZATION, CONFIGURATION)  
SELECT DS.DS_ID, ds_h.VERSION_NUM, ds_h.ACTIVE, ds.LABEL, ds.DESCR, ds.name,
ds_h.OBJECT_TYPE, ds_h.DS_METADATA,
ds_h.PARAMS, ds_h.CATEGORY_ID, ds_h.TRANSFORMER_ID, ds_h.PIVOT_COLUMN, ds_h.PIVOT_ROW,
ds_h.PIVOT_VALUE, ds_h.NUM_ROWS,
ds_h.IS_PERSISTED, ds_h.DATA_SOURCE_PERSIST_ID, ds_h.IS_FLAT_DATASET, ds_h.FLAT_TABLE_NAME, ds_h.DATA_SOURCE_FLAT_ID,
ds_h.USER_IN, 
null as USER_UP,null as USER_DE, ds_h.TIME_IN, null as TIME_UP, null as TIME_DE,
ds_h.SBI_VERSION_IN, null as SBI_VERSION_UP,  null as SBI_VERSION_DE, ds_h.META_VERSION,
ds_h.ORGANIZATION,
CASE WHEN ds_h.OBJECT_TYPE = 'SbiQueryDataSet' THEN 
'{"Query":"' + REPLACE(ds_h.QUERY,'"','\\"') + '","queryScript":"' + REPLACE(NVL(DS_H.QUERY_SCRIPT,''),'"','\\"') + '","queryScriptLanguage":"' + NVL(QUERY_SCRIPT_LANGUAGE,'') + '","dataSource":"' + NVL((SELECT LABEL FROM SBI_DATA_SOURCE WHERE DS_ID = DATA_SOURCE_ID),'') + '"}' 
WHEN ds_h.OBJECT_TYPE = 'SbiFileDataSet' THEN 
'{"fileName":"' + NVL(DS_H.FILE_NAME,'') + '"}'
WHEN ds_h.OBJECT_TYPE = 'SbiFileDataSet' THEN 
'{"SbiJClassDataSet":"' + NVL(DS_H.JCLASS_NAME,'') + '"}'
WHEN ds_h.OBJECT_TYPE = 'SbiFileDataSet' THEN 
'{"wsAddress":"' + NVL(DS_H.ADRESS,'') + '","wsOperation":"' + NVL(DS_H.OPERATION,'') + '"}'
WHEN ds_h.OBJECT_TYPE = 'SbiScriptDataSet' THEN 
'{"Script":"' + REPLACE(NVL(DS_H.SCRIPT,''),'"','\\"') + '","scriptLanguage":"' + NVL(DS_H.LANGUAGE_SCRIPT,'') + '"}'
WHEN ds_h.OBJECT_TYPE = 'SbiCustomDataSet' THEN 
'{"customData":"' + REPLACE(NVL(DS_H.CUSTOM_DATA,'"{}"'),'"','\\"') + '","jClassName":"' + NVL(DS_H.JCLASS_NAME,'') + '"}'
WHEN ds_h.OBJECT_TYPE = 'SbiQbeDataSet' THEN 
'{"qbeDatamarts":"' + NVL(DS_H.DATAMARTS,'') + '","qbeDataSource":"' + NVL((SELECT LABEL FROM SBI_DATA_SOURCE WHERE DS_ID = DATA_SOURCE_ID),'') + '","qbeJSONQuery":"' + REPLACE(NVL(DS_H.JSON_QUERY,''),'"','\\"') + '"}'
end AS CONFIGURATION
FROM SBI_DATA_SET DS INNER JOIN SBI_DATA_SET_HISTORY DS_H ON (DS.DS_ID = DS_H.DS_ID)
order by ds_id, version_num ;

commit;

-- to do at the end, when all it's ended correctly!
--DROP OLDER FK TO SBI_DATA_SET
--ALTER TABLE SBI_LOV DROP CONSTRAINT FK_SBI_LOV_2;
--ALTER TABLE SBI_OBJECTS DROP CONSTRAINT FK_SBI_OBJECTS_7;
--ALTER TABLE SBI_KPI DROP CONSTRAINT FK_SBI_KPI_3;

--ALTER TABLE SBI_DATA_SET_HISTORY DROP CONSTRAINT FK_SBI_DATA_SET_CAT;
--ALTER TABLE SBI_DATA_SET_HISTORY DROP CONSTRAINT FK_SBI_DATA_SET_DS;
--ALTER TABLE SBI_DATA_SET_HISTORY DROP CONSTRAINT FK_SBI_DATA_SET_DS2;
--ALTER TABLE SBI_DATA_SET_HISTORY DROP CONSTRAINT FK_SBI_DATA_SET_T;
--DROP TABLE SBI_DATA_SET_HISTORY;   
--ALTER TABLE SBI_DATA_SET DROP CONSTRAINT AK1SBI_DATA_SET;
--DROP TABLE SBI_DATA_SET;     
-- to do only after drop stmt
--ALTER TABLE SBI_DATA_SET ADD CONSTRAINT FK_SBI_DATA_SET_T  FOREIGN KEY ( TRANSFORMER_ID ) REFERENCES SBI_DOMAINS ( VALUE_ID ) ON DELETE CASCADE;
--ALTER TABLE SBI_DATA_SET ADD CONSTRAINT FK_SBI_DATA_SET_CAT  FOREIGN KEY (CATEGORY_ID) REFERENCES SBI_DOMAINS (VALUE_ID) ON DELETE CASCADE ON UPDATE RESTRICT;
--ALTER TABLE SBI_DATA_SET ADD CONSTRAINT FK_SBI_DATA_SET_DS3 FOREIGN KEY ( DATA_SOURCE_PERSIST_ID ) REFERENCES SBI_DATA_SOURCE( DS_ID ) ON DELETE CASCADE;
--ALTER TABLE SBI_DATA_SET ADD CONSTRAINT FK_SBI_DATA_SET_DS4 FOREIGN KEY ( DATA_SOURCE_FLAT_ID ) REFERENCES SBI_DATA_SOURCE( DS_ID ) ON DELETE CASCADE;
   
SP_RENAME 'SBI_DATA_SET','SBI_DATA_SET_OLD';
SP_RENAME 'SBI_DATA_SET_HISTORY','SBI_DATA_SET_HISTORY_OLD';
SP_RENAME 'SBI_DATA_SET_TEMP','SBI_DATA_SET';

-- insert records for selfservice dataset management 
INSERT INTO SBI_USER_FUNC (USER_FUNCT_ID, NAME, DESCRIPTION, USER_IN, TIME_IN)
    VALUES ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_USER_FUNC'), 
    'SelfServiceDatasetManagement','SelfServiceDatasetManagement', 'server', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_USER_FUNC';
commit;
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'USER' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceDatasetManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'ADMIN' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceDatasetManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'DEV_ROLE' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceDatasetManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'TEST_ROLE' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceDatasetManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'MODEL_ADMIN' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceDatasetManagement'));
commit;

UPDATE SBI_ENGINES SET USE_DATASET = TRUE WHERE DRIVER_NM = 'it.eng.spagobi.engines.drivers.worksheet.WorksheetDriver';
commit;

ALTER TABLE SBI_DATA_SET ADD COLUMN OWNER VARCHAR(50);
ALTER TABLE SBI_DATA_SET ADD COLUMN IS_PUBLIC BIT DEFAULT 0;

UPDATE SBI_DATA_SET SET IS_PUBLIC = TRUE, OWNER = USER_IN;
COMMIT;

INSERT INTO SBI_USER_FUNC (USER_FUNCT_ID, NAME, DESCRIPTION, USER_IN, TIME_IN)
    VALUES ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_USER_FUNC'), 
    'SelfServiceMetaModelManagement','SelfServiceMetaModelManagement', 'server', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_USER_FUNC';
commit;
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'USER' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceMetaModelManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'ADMIN' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceMetaModelManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'DEV_ROLE' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceMetaModelManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'TEST_ROLE' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceMetaModelManagement'));
INSERT INTO SBI_ROLE_TYPE_USER_FUNC (ROLE_TYPE_ID, USER_FUNCT_ID)
    VALUES ((SELECT VALUE_ID FROM SBI_DOMAINS WHERE VALUE_CD = 'MODEL_ADMIN' AND DOMAIN_CD = 'ROLE_TYPE'), 
    (SELECT USER_FUNCT_ID FROM SBI_USER_FUNC WHERE NAME = 'SelfServiceMetaModelManagement'));
commit;

ALTER TABLE SBI_META_MODELS  ADD DATA_SOURCE_ID INTEGER;
ALTER TABLE SBI_META_MODELS ADD CONSTRAINT FK_SBIDATA_SOURCE FOREIGN KEY ( DATA_SOURCE_ID ) REFERENCES SBI_DATA_SOURCE( DS_ID );

INSERT INTO SBI_CONFIG ( ID, LABEL, NAME, DESCRIPTION, IS_ACTIVE, VALUE_CHECK, VALUE_TYPE_ID, CATEGORY, USER_IN, TIME_IN) VALUES 
((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_CONFIG'), 
'SPAGOBI.DATASET_FILE_MAX_SIZE', 'DATASET FILE MAX SIZE', 'Max size for a file used as a dataset', true, '10485760',
(select VALUE_ID from SBI_DOMAINS where VALUE_CD = 'STRING' AND DOMAIN_CD = 'PAR_TYPE'), 'GENERIC_CONFIGURATION', 'biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_CONFIG';
commit;

UPDATE SBI_CONFIG SET VALUE_CHECK = 'dd/MM/yyyy HH:mm:ss' WHERE LABEL = 'SPAGOBI.TIMESTAMP-FORMAT.format';
commit;

-- 24/06/2013 Marco: Added default mandatory Dataset Metadata Properties
INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'fieldType','fieldType','DS_META_PROPERTY','Data Set Metadata Property','Data Set Metadata Property','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'type','type','DS_META_PROPERTY','Data Set Metadata Property','Data Set Metadata Property','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

ALTER TABLE SBI_EXT_ROLES ADD COLUMN SEE_DOCUMENT_BROWSER BIT DEFAULT 1;
ALTER TABLE SBI_EXT_ROLES ADD COLUMN SEE_FAVOURITES 	BIT DEFAULT 1;
ALTER TABLE SBI_EXT_ROLES ADD COLUMN SEE_SUBSCRIPTIONS 	BIT DEFAULT 1;
ALTER TABLE SBI_EXT_ROLES ADD COLUMN SEE_MY_DATA 		BIT DEFAULT 1;
ALTER TABLE SBI_EXT_ROLES ADD COLUMN SEE_TODO_LIST 		BIT DEFAULT 1;
ALTER TABLE SBI_EXT_ROLES ADD COLUMN CREATE_DOCUMENTS 	BIT DEFAULT 1;

-- 25/06/2013 Marco: Added default mandatory Dataset Metadata Properties' Values
INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'MEASURE','MEASURE','DS_META_VALUE','Data Set Metadata Value','Data Set Metadata Value','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'ATTRIBUTE','ATTRIBUTE','DS_META_VALUE','Data Set Metadata Value','Data Set Metadata Value','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'String','String','DS_META_VALUE','Data Set Metadata Value','Data Set Metadata Value','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'Integer','Integer','DS_META_VALUE','Data Set Metadata Value','Data Set Metadata Value','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

INSERT into SBI_DOMAINS (VALUE_ID,VALUE_CD,VALUE_NM,DOMAIN_CD,DOMAIN_NM,VALUE_DS, USER_IN, TIME_IN) values ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_DOMAINS'),'Double','Double','DS_META_VALUE','Data Set Metadata Value','Data Set Metadata Value','biadmin', current_timestamp);
update hibernate_sequences set next_val = next_val+1 where  sequence_name = 'SBI_DOMAINS';
commit;

update sbi_engines set label = 'SpagoBIGisEngine' where label = 'GeoReportEngine';
commit;