SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE VIEW [dbo].[vwCRMLoad_Contact_Std_Update] AS
SELECT a.new_ssbcrmsystemacctid										  
, a.new_ssbcrmsystemcontactid										  
, a.Prefix															  --,b.Salutation
, a.FirstName														  --,b.FirstName
, a.LastName														  --,b.LastName
, a.Suffix															  --,b.Suffix
, a.address1_line1													  --,b.address1_line1, b.address1_line2
																	  --
, a.address1_city													  --,b.address1_city
, a.address1_stateorprovince										  --,b.address1_stateorprovince
, a.address1_postalcode												  --,b.address1_postalcode
, a.address1_country												  --,b.address1_country
, a.telephone1														  --,b.telephone1
, a.contactid														  --
, LoadType															  --
, a.emailaddress1													  --,b.emailaddress1

--,case when  a.Hash_FirstName !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.FirstName))),'')) 																					 then 1 else 0 end as FirstName
--,case when  a.Hash_lastname !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.lastname))),'')) 																					 then 1 else 0 end as lastname
--,case when  a.Hash_suffix !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.suffix))),'')) 																						 then 1 else 0 end as suffix
--,case when  a.Hash_Address1_Line1 !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.address1_line1))),'')) 																		 then 1 else 0 end as address1_line1
--,case when  a.Hash_Telephone1 !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(REPLACE(REPLACE(REPLACE(REPLACE(b.telephone1,')',''),'(',''),'-',''),' ','')))),''))				 then 1 else 0 end as telephone1
--,case when  a.Hash_emailaddress1 !=  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.emailaddress1))),'')) 																			 THEN 1 else 0 end as emailaddress1

FROM [dbo].[vwCRMLoad_Contact_Std_Prep] a
JOIN prodcopy.vw_contact b ON a.contactid = b.contactID
LEFT JOIN dbo.KeyAccounts_Materialized k ON k.SSBID = a.new_ssbcrmsystemcontactid AND Withhold_StandardUpdate = 1
WHERE 1=1
AND LoadType = 'Update'
AND k.ssid IS NULL
AND (1=2
OR ISNULL(a.FirstName,'') != ISNULL(b.firstname,'')
OR ISNULL(a.LastName,'') != ISNULL(b.LastName,'') 
OR ISNULL(a.Suffix,'') != ISNULL(b.Suffix,'') 
OR ISNULL(a.address1_line1,'') != ISNULL(b.address1_line1,'') 
OR ISNULL(a.address1_city,'') != ISNULL(b.address1_city,'') 
OR ISNULL(a.address1_stateorprovince,'') != ISNULL(b.address1_stateorprovince,'') 
OR ISNULL(a.address1_country,'') != ISNULL(b.address1_country,'') 
OR ISNULL(a.telephone1,'') != ISNULL(b.telephone1,'') 
OR ISNULL(a.emailaddress1,'') != ISNULL(b.emailaddress1,'') 

)









GO
