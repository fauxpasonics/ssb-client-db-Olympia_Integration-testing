SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vwCRMLoad_Account_Custom_Update]
AS

SELECT  z.[crm_id] accountid
, b.new_ssbcrmsystemssidwinner
, b.new_ssbcrmsystemSSIDWinnerSourceSystem
--, TM_Ids [new_ssbcrmsystemarchticsids]
, DimCustIDs new_ssbcrmsystemdimcustomerids
, b.AccountId str_number
-- SELECT *
-- SELECT COUNT(*) 
FROM dbo.[Account_Custom] b 
INNER JOIN dbo.Account z ON b.SSB_CRMSYSTEM_Acct_ID = z.[SSB_CRMSYSTEM_Acct_ID]
LEFT JOIN  prodcopy.vw_Account c ON z.[crm_id] = c.AccountID
----INNER JOIN dbo.CRMLoad_Acct_ProcessLoad_Criteria pl ON b.SSB_CRMSYSTEM_Acct_ID = pl.SSB_CRMSYSTEM_Acct_ID
LEFT JOIN (SELECT DISTINCT c.SSB_CRMSYSTEM_ACCT_ID AS SSBID, ka.Withhold_CustomUpdate
				FROM dbo.KeyAccounts_Materialized ka
				INNER JOIN dbo.contact c ON c.SSB_CRMSYSTEM_CONTACT_ID = ka.SSBID) k
		ON z.SSB_CRMSYSTEM_ACCT_ID = k.SSBID AND k.Withhold_CustomUpdate = 1
WHERE z.[SSB_CRMSYSTEM_Acct_ID] <> z.[crm_id]
AND k.SSBID IS NULL
AND  (HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemssidwinner)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemssidwinner AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.DimCustIDs)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemdimcustomerids AS VARCHAR(MAX)))),'')) 
	--OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.AccountId)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.[new_ssbcrmsystemarchticsids] AS VARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemSSIDWinnerSourceSystem)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.[new_ssbcrmsystemSSIDWinnerSourceSystem] AS VARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.TM_Ids)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.[str_number] AS VARCHAR(MAX)))),''))
	)




GO
