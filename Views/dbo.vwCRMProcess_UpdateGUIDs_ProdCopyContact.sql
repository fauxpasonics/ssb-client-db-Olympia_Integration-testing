SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vwCRMProcess_UpdateGUIDs_ProdCopyContact]
AS

SELECT DISTINCT b.SSID contactid, b.SSB_CRMSYSTEM_ACCT_ID [new_ssbcrmsystemacctid], b.SSB_CRMSYSTEM_CONTACT_ID [new_ssbcrmsystemcontactid]
, cc.new_ssbcrmsystemssidwinner AS new_ssbcrmsystemssidwinner							  --,c.new_ssbcrmsystemssidwinner
, cc.new_ssbcrmsystemssidwinnerSourceSystem AS new_ssbssidwinnersourcesystem					  --,c.new_ssbcrmsystemssidwinner
--, REPLACE(REPLACE(c.[new_ssbcrmsystemcontactid],'{',''),'}','')
--SELECT COUNT(*)
FROM dbo.vwDimCustomer_ModAcctId b
INNER JOIN ProdCopy.vw_Contact c WITH(NOLOCK) ON b.SSID = CAST(c.contactid AS VARCHAR(50))
INNER JOIN dbo.contact comp ON comp.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
INNER JOIN dbo.Contact_Custom cc ON cc.SSB_CRMSYSTEM_CONTACT_ID = comp.SSB_CRMSYSTEM_CONTACT_ID
--LEFT JOIN dbo.KeyAccounts k ON CAST(k.SSID AS NVARCHAR(100)) = CAST(c.contactid AS NVARCHAR(100))
WHERE 
c.[new_ssbcrmsystemcontactid] IS NULL OR c.[new_ssbcrmsystemcontactid] <> b.[SSB_CRMSYSTEM_CONTACT_ID]
--OR (
--comp.crm_id != CAST(c.contactid AS NVARCHAR(100)) AND (1=2 
--OR (c.new_ssbcrmsystemssidwinner != cc.new_ssbcrmsystemssidwinner AND cc.new_ssbcrmsystemssidwinner != 'CRM_Contact')
--OR (c.new_ssbssidwinnersourcesystem != cc.new_ssbcrmsystemssidwinnerSourceSystem AND cc.new_ssbcrmsystemssidwinnerSourceSystem != 'CRM_Contact')
--OR (ISNULL(c.new_ssbcrmsystemssidwinner,'') = '' AND cc.new_ssbcrmsystemssidwinner != 'CRM_Contact')
--)
--OR k.SSBID IS NOT NULL

--)



GO
