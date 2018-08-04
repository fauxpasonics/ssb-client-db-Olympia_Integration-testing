SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vwCRMLoad_Account_Std_Update] AS

SELECT a.new_ssbcrmsystemacctid, a.Name, a.address1_line1, a.address1_city, a.address1_stateorprovince, a.address1_postalcode, a.address1_country, a.telephone1, a.accountid, LoadType, a.emailaddress1
--,b.Name, b.address1_line1, b.address1_city, b.address1_stateorprovince, b.address1_postalcode, b.address1_country, b.telephone1, b.accountid,  b.emailaddress1
FROM [dbo].[vwCRMLoad_Account_Std_Prep] a
JOIN prodcopy.vw_account b ON a.accountid = b.accountid
LEFT JOIN (SELECT DISTINCT c.SSB_CRMSYSTEM_ACCT_ID AS SSBID, ka.Withhold_StandardUpdate
				FROM dbo.KeyAccounts_Materialized ka
				INNER JOIN dbo.contact c ON c.SSB_CRMSYSTEM_CONTACT_ID = ka.SSBID) k
		ON a.new_ssbcrmsystemacctid = k.SSBID AND k.Withhold_StandardUpdate = 1
WHERE LoadType = 'Update'
AND k.SSBID IS NULL
AND  (HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(a.Name ))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.Name ))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(a.address1_line1 ))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.address1_line1 ))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(REPLACE(REPLACE(REPLACE(REPLACE(a.telephone1,')',''),'(',''),'-',''),' ','') ))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(REPLACE(REPLACE(REPLACE(REPLACE(b.telephone1,')',''),'(',''),'-',''),' ','') ))),'') )
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(a.emailaddress1 ))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(LOWER(b.emailaddress1 ))),'')) 
	)

GO
