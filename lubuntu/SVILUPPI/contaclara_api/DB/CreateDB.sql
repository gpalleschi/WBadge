drop table cc_decode_fields;
drop table cc_invoices_data;
drop table cc_invoices;
drop table cc_type_invoices;
drop table cc_group_invoices;
drop table cc_users;
drop table cc_clients;

create table cc_clients (
 ID_CLIENT              int NOT NULL AUTO_INCREMENT,
 CLIENT_NAME            varchar(100),
 DESC_CLIENT            varchar(256),
 ELECTR_COMPANY         varchar(100),
 DIR_LOGO_CLIENT        varchar(256)
 PRIMARY KEY (ID_CLIENT));

create table cc_users (
  ID_CLIENT             int NOT NULL,
  ID_USER               int NOT NULL AUTO_INCREMENT,
  USER_NAME             varchar(80) NOT NULL,
  USER_PASSWORD         varchar(100) NOT NULL,
  USER_TYPE             varchar(100) NOT NULL,
  USER_EMAIL            varchar(100) NOT NULL,
  PRIMARY KEY (ID_USER),
  FOREIGN KEY (ID_CLIENT)
        REFERENCES cc_clients (ID_CLIENT)
        ON DELETE CASCADE);

create unique index idx_CC_USERS_PK on cc_users (USER_NAME);

create table cc_type_invoices (
  TYPE_INVOICE       varchar(20) NOT NULL,
  DESC_TYPE_INVOICE  varchar(80) NOT NULL,
  PRIMARY KEY (TYPE_INVOICE)
);

create table cc_group_invoices (
  GROUP_INVOICE      varchar(20) NOT NULL,
  DESC_GROUP_INVOICE varchar(80) NOT NULL,
  PRIMARY KEY (GROUP_INVOICE)
);

create table cc_invoices (
   ID_CLIENT            int NOT NULL,
   ID_INVOICE           int NOT NULL AUTO_INCREMENT,
   COD_USER             varchar(64),
   COD_CONTRACT         varchar(64),
   COD_INVOICE          varchar(64) NOT NULL,
   TYPE_INVOICE         varchar(10) NOT NULL,
   GROUP_INVOICE        varchar(20) NOT NULL,
   PERIOD               varchar(20) NOT NULL,
   EXPIRATION           date  NOT NULL,
   TOTAL_AMOUNT         double(15,5) NOT NULL,
   UPLOAD_DATE          datetime NOT NULL,
   FILE_NAME            varchar(500),
   USER_UPLOAD          int,
   COD_CONTRACT varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
   COD_USER varchar(64) DEFAULT NULL,
   LEITURA_ANTERIOR date DEFAULT NULL,
   LEITURA_ATUAL date DEFAULT NULL,   
   NDEDIAS              varchar(20) NOT NULL,
   LEITURA_PROXIMA date DEFAULT NULL,   
   PRIMARY KEY (ID_INVOICE),
   FOREIGN KEY (ID_CLIENT) 
        REFERENCES cc_clients (ID_CLIENT)
        ON DELETE CASCADE,
   FOREIGN KEY (TYPE_INVOICE)
        REFERENCES cc_type_invoices (TYPE_INVOICE),
   FOREIGN KEY (GROUP_INVOICE)
        REFERENCES cc_group_invoices (GROUP_INVOICE) 	 
);

create table cc_invoices_data (
	ID_INVOICE           int NOT NULL,
	FIELD_1              varchar(256),
	FIELD_2              varchar(256),
	FIELD_3              varchar(256),
	FIELD_4              varchar(256),
	FIELD_5              varchar(256),
	FIELD_6              varchar(256),
	FIELD_7              varchar(256),
	FIELD_8              varchar(256),
	FIELD_9              varchar(256),
	FIELD_10             varchar(256),
	METRIC_1             double(15,5),
	METRIC_2             double(15,5),
	METRIC_3             double(15,5),
	METRIC_4             double(15,5),
	METRIC_5             double(15,5),
	METRIC_6             double(15,5),
	METRIC_7             double(15,5),
	METRIC_8             double(15,5),
	METRIC_9             double(15,5),
	METRIC_10            double(15,5),
	FOREIGN KEY (ID_INVOICE)
        REFERENCES cc_invoices (ID_INVOICE) 
	ON DELETE CASCADE
);

create table cc_decode_fields (
    	ID_CLIENT            int NOT NULL,
        TYPE_INVOICE         varchar(10) NOT NULL,
        GROUP_INVOICE        varchar(20) NOT NULL,	
    	FIELD_NAME	     	 varchar(16),
	DESC_FIELD           varchar(256),
	LANGUAGE             varchar(5), -- pt, en, it, es, ---
	LABEL_FIELD          varchar(32),
	FOREIGN KEY (ID_CLIENT) 
        REFERENCES cc_clients (ID_CLIENT)
        ON DELETE CASCADE,
        FOREIGN KEY (TYPE_INVOICE)
        REFERENCES cc_type_invoices (TYPE_INVOICE),
        FOREIGN KEY (GROUP_INVOICE)
        REFERENCES cc_group_invoices (GROUP_INVOICE) 	
);

create table cc_cod_invoice (
        ID_CLIENT            int NOT NULL,
        TYPE_INVOICE         varchar(10) NOT NULL,
        GROUP_INVOICE        varchar(20) NOT NULL,        
        COD_INVOICE_FATHER   varchar(64),
        COD_INVOICE          varchar(64) NOT NULL,
        DESC_COD_INVOICE     varchar(256) NOT NULL,
        TYPE_CLIENT          varchar(64),
        PRIMARY KEY (ID_CLIENT, TYPE_INVOICE, GROUP_INVOICE, COD_INVOICE),
	FOREIGN KEY (ID_CLIENT) 
        REFERENCES cc_clients (ID_CLIENT)
        ON DELETE CASCADE,
        FOREIGN KEY (TYPE_INVOICE)
        REFERENCES cc_type_invoices (TYPE_INVOICE),
        FOREIGN KEY (GROUP_INVOICE)
        REFERENCES cc_group_invoices (GROUP_INVOICE)
);

create table cc_type_clients (
        ID_TYPE_CLIENT       int NOT NULL AUTO_INCREMENT,
        ID_CLIENT            int NOT NULL,
        TYPE_CLIENT          varchar(64) NOT NULL,
        DESC_TYPE_CLIENT     varchar(256) NOT NULL,
        PRIMARY KEY (ID_TYPE_CLIENT),
	FOREIGN KEY (ID_CLIENT) 
        REFERENCES cc_clients (ID_CLIENT)
        ON DELETE CASCADE
);

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `ccv_invoices` AS
select
    `cci`.`ID_CLIENT` AS `ID_CLIENT`,
    `cci`.`ID_INVOICE` AS `ID_INVOICE`,
    `cci`.`COD_INVOICE` AS `COD_INVOICE`,
    `ccci`.`DESC_COD_INVOICE` AS `DESC_COD_INVOICE`,
    `cci`.`TYPE_INVOICE` AS `TYPE_INVOICE`,
    `cci`.`GROUP_INVOICE` AS `GROUP_INVOICE`,
    `cci`.`PERIOD` AS `PERIOD`,
    `cci`.`EXPIRATION` AS `EXPIRATION`,
    `cci`.`FILE_NAME` AS `FILE_NAME`,
    `cci`.`TOTAL_AMOUNT` AS `TOTAL_AMOUNT`,
    `cci`.`UPLOAD_DATE` AS `UPLOAD_DATE`,
    `cci`.`USER_UPLOAD` AS `USER_UPLOAD`,
    `cci`.`LEITURA_ANTERIOR` AS `LEITURA_ANTERIOR`,
    `cci`.`LEITURA_ATUAL` AS `LEITURA_ATUAL`,
    `cci`.`NDEDIAS` AS `NDEDIAS`,
    `cci`.`LEITURA_PROXIMA` AS `LEITURA_PROXIMA`
from
    (`cc_invoices` `cci`
join `cc_cod_invoice` `ccci`)
where
    ((`cci`.`ID_CLIENT` = `ccci`.`ID_CLIENT`)
    and (`cci`.`TYPE_INVOICE` = `ccci`.`TYPE_INVOICE`)
    and (`cci`.`GROUP_INVOICE` = `ccci`.`GROUP_INVOICE`)
    and (`cci`.`COD_INVOICE` = `ccci`.`COD_INVOICE`));

--CREATE OR REPLACE VIEW ccv_invoices_data AS
--SELECT cci.ID_CLIENT, cci.ID_INVOICE, cci.COD_INVOICE, ccci.DESC_COD_INVOICE, cci.TYPE_INVOICE, cci.GROUP_INVOICE, cci.PERIOD, cci.EXPIRATION, cci.FILE_NAME, cci.TOTAL_AMOUNT,
--       cci.UPLOAD_DATE, cci.USER_UPLOAD, ccid.FIELD_1,  ccid.FIELD_2, ccid.FIELD_3, ccid.FIELD_4, ccid.FIELD_5, ccid.FIELD_6, ccid.FIELD_7, ccid.FIELD_8, ccid.FIELD_9, ccid.FIELD_10,
--       ccid.METRIC_1, ccid.METRIC_2, ccid.METRIC_3, ccid.METRIC_4, ccid.METRIC_5, ccid.METRIC_6, ccid.METRIC_7, ccid.METRIC_8, ccid.METRIC_9, ccid.METRIC_10 
--FROM cc_invoices cci, cc_invoices_data ccid, cc_cod_invoice ccci
--WHERE cci.ID_INVOICE = ccid.ID_INVOICE AND 
--      cci.ID_CLIENT = ccci.ID_CLIENT AND 
--      cci.TYPE_INVOICE = ccci.TYPE_INVOICE AND 
--      cci.GROUP_INVOICE = ccci.GROUP_INVOICE AND
--      cci.COD_INVOICE = ccci.COD_INVOICE;

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `ccv_invoices_data` AS
select
    `cci`.`ID_CLIENT` AS `ID_CLIENT`,
    `cci`.`ID_INVOICE` AS `ID_INVOICE`,
    `cci`.`COD_INVOICE` AS `COD_INVOICE`,
    `ccci`.`TYPE_CLIENT` AS `TYPE_CLIENT`,
    `ccci`.`DESC_COD_INVOICE` AS `DESC_COD_INVOICE`,
    `cci`.`TYPE_INVOICE` AS `TYPE_INVOICE`,
    `cci`.`GROUP_INVOICE` AS `GROUP_INVOICE`,
    `cci`.`PERIOD` AS `PERIOD`,
    `cci`.`EXPIRATION` AS `EXPIRATION`,
    `cci`.`FILE_NAME` AS `FILE_NAME`,
    `cci`.`TOTAL_AMOUNT` AS `TOTAL_AMOUNT`,
    `cci`.`UPLOAD_DATE` AS `UPLOAD_DATE`,
    `cci`.`USER_UPLOAD` AS `USER_UPLOAD`,
    `ccid`.`FIELD_1` AS `FIELD_1`,
    `ccid`.`FIELD_2` AS `FIELD_2`,
    `ccid`.`FIELD_3` AS `FIELD_3`,
    `ccid`.`FIELD_4` AS `FIELD_4`,
    `ccid`.`FIELD_5` AS `FIELD_5`,
    `ccid`.`FIELD_6` AS `FIELD_6`,
    `ccid`.`FIELD_7` AS `FIELD_7`,
    `ccid`.`FIELD_8` AS `FIELD_8`,
    `ccid`.`FIELD_9` AS `FIELD_9`,
    `ccid`.`FIELD_10` AS `FIELD_10`,
    `ccid`.`METRIC_1` AS `METRIC_1`,
    `ccid`.`METRIC_2` AS `METRIC_2`,
    `ccid`.`METRIC_3` AS `METRIC_3`,
    `ccid`.`METRIC_4` AS `METRIC_4`,
    `ccid`.`METRIC_5` AS `METRIC_5`,
    `ccid`.`METRIC_6` AS `METRIC_6`,
    `ccid`.`METRIC_7` AS `METRIC_7`,
    `ccid`.`METRIC_8` AS `METRIC_8`,
    `ccid`.`METRIC_9` AS `METRIC_9`,
    `ccid`.`METRIC_10` AS `METRIC_10`
from
    ((`cc_invoices` `cci`
join `cc_invoices_data` `ccid`)
join `cc_cod_invoice` `ccci`)
where
    ((`cci`.`ID_INVOICE` = `ccid`.`ID_INVOICE`)
        and (`cci`.`ID_CLIENT` = `ccci`.`ID_CLIENT`)
            and (`cci`.`TYPE_INVOICE` = `ccci`.`TYPE_INVOICE`)
                and (`cci`.`GROUP_INVOICE` = `ccci`.`GROUP_INVOICE`)
                    and (`cci`.`COD_INVOICE` = `ccci`.`COD_INVOICE`));

create or replace view ccv_energy_report_a as
select ID_CLIENT, SUBSTR(PERIOD,4) YEAR, COD_INVOICE, DESC_COD_INVOICE, FIELD_1 ITEM,
       SUM(case when SUBSTR(PERIOD,1,2)='01' then METRIC_1 end ) M01,
       SUM(case when SUBSTR(PERIOD,1,2)='01' then METRIC_4 end ) V01,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then METRIC_1 end ) M02,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then METRIC_4 end ) V02,    
       SUM(case when SUBSTR(PERIOD,1,2)='03' then METRIC_1 end ) M03,
       SUM(case when SUBSTR(PERIOD,1,2)='03' then METRIC_4 end ) V03,       
       SUM(case when SUBSTR(PERIOD,1,2)='04' then METRIC_1 end ) M04,
       SUM(case when SUBSTR(PERIOD,1,2)='04' then METRIC_4 end ) V04,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then METRIC_1 end ) M05,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then METRIC_4 end ) V05,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then METRIC_1 end ) M06,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then METRIC_4 end ) V06,      
       SUM(case when SUBSTR(PERIOD,1,2)='07' then METRIC_1 end ) M07,
       SUM(case when SUBSTR(PERIOD,1,2)='07' then METRIC_4 end ) V07,       
       SUM(case when SUBSTR(PERIOD,1,2)='08' then METRIC_1 end ) M08,
       SUM(case when SUBSTR(PERIOD,1,2)='08' then METRIC_4 end ) V08,          
       SUM(case when SUBSTR(PERIOD,1,2)='09' then METRIC_1 end ) M09,
       SUM(case when SUBSTR(PERIOD,1,2)='09' then METRIC_4 end ) V09,          
       SUM(case when SUBSTR(PERIOD,1,2)='10' then METRIC_1 end ) M10,
       SUM(case when SUBSTR(PERIOD,1,2)='10' then METRIC_4 end ) V10,          
       SUM(case when SUBSTR(PERIOD,1,2)='11' then METRIC_1 end ) M11,
       SUM(case when SUBSTR(PERIOD,1,2)='11' then METRIC_4 end ) V11,          
       SUM(case when SUBSTR(PERIOD,1,2)='12' then METRIC_1 end ) M12,
       SUM(case when SUBSTR(PERIOD,1,2)='12' then METRIC_4 end ) V12          
from ccv_invoices_data cid 
where type_invoice = 'A' AND
      GROUP_INVOICE = 'FILHA'
group by SUBSTR(PERIOD,4), COD_INVOICE, DESC_COD_INVOICE, FIELD_1;

create or replace view ccv_type_client_report as
select ID_CLIENT, SUBSTR(PERIOD,4) YEAR, IFNULL(TRIM(TYPE_CLIENT),'NULL'),
       SUM(case when SUBSTR(PERIOD,1,2)='01' then METRIC_1 end ) M01,
       SUM(case when SUBSTR(PERIOD,1,2)='01' then METRIC_4 end ) V01,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then METRIC_1 end ) M02,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then METRIC_4 end ) V02,    
       SUM(case when SUBSTR(PERIOD,1,2)='03' then METRIC_1 end ) M03,
       SUM(case when SUBSTR(PERIOD,1,2)='03' then METRIC_4 end ) V03,       
       SUM(case when SUBSTR(PERIOD,1,2)='04' then METRIC_1 end ) M04,
       SUM(case when SUBSTR(PERIOD,1,2)='04' then METRIC_4 end ) V04,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then METRIC_1 end ) M05,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then METRIC_4 end ) V05,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then METRIC_1 end ) M06,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then METRIC_4 end ) V06,      
       SUM(case when SUBSTR(PERIOD,1,2)='07' then METRIC_1 end ) M07,
       SUM(case when SUBSTR(PERIOD,1,2)='07' then METRIC_4 end ) V07,       
       SUM(case when SUBSTR(PERIOD,1,2)='08' then METRIC_1 end ) M08,
       SUM(case when SUBSTR(PERIOD,1,2)='08' then METRIC_4 end ) V08,          
       SUM(case when SUBSTR(PERIOD,1,2)='09' then METRIC_1 end ) M09,
       SUM(case when SUBSTR(PERIOD,1,2)='09' then METRIC_4 end ) V09,          
       SUM(case when SUBSTR(PERIOD,1,2)='10' then METRIC_1 end ) M10,
       SUM(case when SUBSTR(PERIOD,1,2)='10' then METRIC_4 end ) V10,          
       SUM(case when SUBSTR(PERIOD,1,2)='11' then METRIC_1 end ) M11,
       SUM(case when SUBSTR(PERIOD,1,2)='11' then METRIC_4 end ) V11,          
       SUM(case when SUBSTR(PERIOD,1,2)='12' then METRIC_1 end ) M12,
       SUM(case when SUBSTR(PERIOD,1,2)='12' then METRIC_4 end ) V12          
from ccv_invoices_data cid 
where GROUP_INVOICE = 'FILHA'
group by ID_CLIENT, SUBSTR(PERIOD,4), TYPE_CLIENT;

create or replace view ccv_energy_report as
select ID_CLIENT, TYPE_INVOICE, SUBSTR(PERIOD,4) YEAR, COD_INVOICE, DESC_COD_INVOICE, FIELD_1 ITEM,
       SUM(case when SUBSTR(PERIOD,1,2)='01' then METRIC_1 end ) M01,
       SUM(case when SUBSTR(PERIOD,1,2)='01' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V01,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then METRIC_1 end ) M02,
       SUM(case when SUBSTR(PERIOD,1,2)='02' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V02,    
       SUM(case when SUBSTR(PERIOD,1,2)='03' then METRIC_1 end ) M03,
       SUM(case when SUBSTR(PERIOD,1,2)='03' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V03,       
       SUM(case when SUBSTR(PERIOD,1,2)='04' then METRIC_1 end ) M04,
       SUM(case when SUBSTR(PERIOD,1,2)='04' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V04,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then METRIC_1 end ) M05,
       SUM(case when SUBSTR(PERIOD,1,2)='05' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V05,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then METRIC_1 end ) M06,
       SUM(case when SUBSTR(PERIOD,1,2)='06' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V06,      
       SUM(case when SUBSTR(PERIOD,1,2)='07' then METRIC_1 end ) M07,
       SUM(case when SUBSTR(PERIOD,1,2)='07' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V07,       
       SUM(case when SUBSTR(PERIOD,1,2)='08' then METRIC_1 end ) M08,
       SUM(case when SUBSTR(PERIOD,1,2)='08' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V08,          
       SUM(case when SUBSTR(PERIOD,1,2)='09' then METRIC_1 end ) M09,
       SUM(case when SUBSTR(PERIOD,1,2)='09' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V09,          
       SUM(case when SUBSTR(PERIOD,1,2)='10' then METRIC_1 end ) M10,
       SUM(case when SUBSTR(PERIOD,1,2)='10' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V10,          
       SUM(case when SUBSTR(PERIOD,1,2)='11' then METRIC_1 end ) M11,
       SUM(case when SUBSTR(PERIOD,1,2)='11' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V11,          
       SUM(case when SUBSTR(PERIOD,1,2)='12' then METRIC_1 end ) M12,
       SUM(case when SUBSTR(PERIOD,1,2)='12' then case when TYPE_INVOICE = 'A' then METRIC_4 else METRIC_3 end end ) V12          
from ccv_invoices_data cid 
where GROUP_INVOICE = 'FILHA'
group by ID_CLIENT, SUBSTR(PERIOD,4), TYPE_INVOICE, COD_INVOICE, DESC_COD_INVOICE, FIELD_1;

CREATE OR REPLACE VIEW ccv_energy_graph AS
select
    cid.ID_CLIENT AS ID_CLIENT,
    cid.TYPE_INVOICE AS TYPE_INVOICE,
    cid.PERIOD AS PERIOD,
    cid.COD_INVOICE AS COD_INVOICE,
    cid.DESC_COD_INVOICE AS DESC_COD_INVOICE,
    sum(cid.METRIC_1) AS TOTAL_CONSUM,
    sum(case when (cid.TYPE_INVOICE = 'A') then cid.METRIC_4 else cid.METRIC_3 end) AS TOTAL_AMOUNT
from
    ccv_invoices_data cid
where
    (cid.GROUP_INVOICE = 'FILHA')
group by
    cid.ID_CLIENT,
    cid.PERIOD,
    cid.TYPE_INVOICE,
    cid.COD_INVOICE,
    cid.DESC_COD_INVOICE
order by STR_TO_DATE(cid.PERIOD,'%m/%Y');

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `ccv_energy_graph_e` AS
select
    `cid`.`ID_CLIENT` AS `ID_CLIENT`,
    `cid`.`TYPE_INVOICE` AS `TYPE_INVOICE`,
    `cid`.`PERIOD` AS `PERIOD`,
    `cid`.`COD_INVOICE` AS `COD_INVOICE`,
    replace(replace(trim(`cid`.`FIELD_1`),
    ' TUSD',
    ''),
    ' TE',
    '') AS `TYPE_ENERGY`,
    `cid`.`DESC_COD_INVOICE` AS `DESC_COD_INVOICE`,
    sum(`cid`.`METRIC_1`) AS `TOTAL_CONSUM`,
    sum((case when (`cid`.`TYPE_INVOICE` = 'A') then `cid`.`METRIC_4` else `cid`.`METRIC_3` end)) AS `TOTAL_AMOUNT`
from
    `ccv_invoices_data` `cid`
where
    ((`cid`.`GROUP_INVOICE` = 'FILHA')
    and ((`cid`.`FIELD_1` like 'Energia Atv Forn F Ponta%')
    or (`cid`.`FIELD_1` like 'Energia Atv Forn Ponta%')
    or (`cid`.`FIELD_1` like 'Energia Ativa Fornecida%')
    or (`cid`.`FIELD_1` like 'EnergiaAtivakWhHFP%')
    or (`cid`.`FIELD_1` like 'EnergiaAtivakWhHP%')
    or (`cid`.`FIELD_1` like 'EnergiaElétricakWh%')
    ))
group by
    `cid`.`ID_CLIENT`,
    `cid`.`PERIOD`,
    `cid`.`TYPE_INVOICE`,
    `cid`.`COD_INVOICE`,
    replace(replace(trim(`cid`.`FIELD_1`),
    ' TUSD',
    ''),
    ' TE',
    ''),
    `cid`.`DESC_COD_INVOICE`
order by
    str_to_date(`cid`.`PERIOD`,
    '%m/%Y');

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `ccv_cod_invoice` AS
select
    `cci`.`ID_CLIENT` AS `ID_CLIENT`,
    `cci`.`TYPE_INVOICE` AS `TYPE_INVOICE`,
    `cci`.`GROUP_INVOICE` AS `GROUP_INVOICE`,
    `cci`.`COD_INVOICE` AS `COD_INVOICE`,
    `cci`.`DESC_COD_INVOICE` AS `DESC_COD_INVOICE`,
    `cci`.`COD_INVOICE_FATHER` AS `COD_INVOICE_FATHER`,
    `cci`.`TYPE_CLIENT` AS `TYPE_CLIENT`,
    `ccif`.`DESC_COD_INVOICE` AS `DESC_COD_INVOICE_FATHER`
from
    (`cc_cod_invoice` `cci`
join `cc_cod_invoice` `ccif`)
where
    ((`cci`.`GROUP_INVOICE` = 'FILHA')
        and (`ccif`.`GROUP_INVOICE` = 'MAE')
            and (`cci`.`COD_INVOICE_FATHER` = `ccif`.`COD_INVOICE`));