SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[vwCRMLoad_Contact_Custom_Update]
AS

/*  CHANGE LOG
2018-03-28	KS:		Updated str_clientdrwealerts and str_clientoeionlineclub logic to include
					case statements. The case statements ensure that if a contact unsubscribes
					from either of these mailing lists they won't be re-subscribed until they
					make a new qualifying purchase.

*/

SELECT  z.[crm_id] contactid
, b.new_ssbcrmsystemssidwinner																									--,c.new_ssbcrmsystemssidwinner
, b.new_ssbcrmsystemSSIDWinnerSourceSystem new_ssbssidwinnersourcesystem														--,c.new_ssbssidwinnersourcesystem
, DimCustIDs new_ssbcrmsystemdimcustomerids																						--,c.new_ssbcrmsystemdimcustomerids
, b.str_number																													--,c.str_number
, b.telephone2																													--,c.telephone2
, b.mobilephone																													--,c.mobilephone
, b.fax																															--,c.fax
, ISNULL(b.ownerid,c.ownerid) ownerid																							--,c.ownerid
, ISNULL(b.owneridtype, c.owneridtype) owneridtype																				--,c.owneridtype
, b.str_since																													--,c.str_since
, b.str_category																												--,c.str_category
, CASE	WHEN c.str_clientdrwealerts = 2 AND b.str_clientdrwealertsticketingdate < (GETDATE() - 1)
			THEN c.str_clientdrwealerts
		ELSE ISNULL(b.str_clientdrwealerts,c.str_clientdrwealerts) END AS str_clientdrwealerts 													--,c.str_clientdrwealerts
, ISNULL(b.str_clientdrwealertsticketingdate,c.str_clientdrwealertsticketingdate) str_clientdrwealertsticketingdate				--,c.str_clientdrwealertsticketingdate
, CASE	WHEN c.str_clientoeionlineclub = 2 AND b.str_clientoeionlineclubticketingdate < (GETDATE() - 1)
			THEN c.str_clientoeionlineclub
		ELSE ISNULL(b.str_clientoeionlineclub,c.str_clientoeionlineclub) END AS str_clientoeionlineclub											--,c.str_clientoeionlineclub
, ISNULL(b.str_clientoeionlineclubticketingdate,c.str_clientoeionlineclubticketingdate) str_clientoeionlineclubticketingdate	--,c.str_clientoeionlineclubticketingdate
, b.str_truesincedate																											--,c.str_truesincedate
, ma.SSUpdatedDate AS str_dwmodifiedon																							--,c.str_dwmodifiedon

----[str_client313presents] -is deprecated		
----b.str_id -is deprecated	
----b.str_idtext -is deprecated														 


	--, case when HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemssidwinner)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemssidwinner AS VARCHAR(MAX)))),''))                                                                                                 		   then 1 else 0 end as new_ssbcrmsystemssidwinner
	--, case when HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.DimCustIDs)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemdimcustomerids AS VARCHAR(MAX)))),''))                                                                                                 		   then 1 else 0 end as new_ssbcrmsystemdimcustomerids
	--, case when HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemSSIDWinnerSourceSystem)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbssidwinnersourcesystem AS VARCHAR(MAX)))),''))                                                                                                		   then 1 else 0 end as new_ssbssidwinnersourcesystem
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.str_number)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_number AS NVARCHAR(MAX)))),''))                                                                                                			then 1 else 0 end as str_number
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.telephone2)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.telephone2 AS NVARCHAR(MAX)))),''))                                                                                                			then 1 else 0 end as telephone2
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.mobilephone)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.mobilephone AS NVARCHAR(MAX)))),''))                                                                                                				then 1 else 0 end as mobilephone
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.fax)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.fax AS NVARCHAR(MAX)))),''))                                                                                                				THEN 1 else 0 end as fax
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.ownerid)),c.ownerid) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.ownerid AS VARCHAR(MAX)))),''))                                                                                                			THEN 1 else 0 end as ownerid
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.owneridtype AS VARCHAR(MAX)))),CAST(c.owneridtype AS VARCHAR(MAX))) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.owneridtype AS VARCHAR(MAX)))),''))                                                                                               	then 1 else 0 end as owneridtype
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_since AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_since AS DATE))),''))                                                                                                			THEN 1 else 0 end as str_since
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.str_category)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_category AS NVARCHAR(MAX)))),''))                                                                                                			then 1 else 0 end as str_category
	--,case when  HASHBYTES('SHA2_256',CAST(ISNULL(LTRIM(RTRIM(b.str_clientdrwealerts)),c.str_clientdrwealerts) AS NVARCHAR(100)))  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientdrwealerts AS NVARCHAR(MAX)))),''))                                                                                               					then 1 else 0 end as str_clientdrwealerts
	--,case when  HASHBYTES('SHA2_256',CAST(ISNULL(LTRIM(RTRIM(b.str_clientoeionlineclub)),c.str_clientoeionlineclub) AS NVARCHAR(100)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientoeionlineclub AS NVARCHAR(MAX)))),''))                                                                                     											then 1 else 0 end as str_clientoeionlineclub
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_clientdrwealertsticketingdate AS DATE))),CAST(C.str_clientdrwealertsticketingdate AS DATE)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientdrwealertsticketingdate AS DATE))),''))                                                                                        then       1 else 0 end as str_clientdrwealertsticketingdate
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_clientoeionlineclubticketingdate AS DATE))),CAST(c.str_clientoeionlineclubticketingdate AS DATE)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientoeionlineclubticketingdate AS DATE))),''))                                                                        	then 1 else 0 end as str_clientoeionlineclubticketingdate
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_truesincedate AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_truesincedate AS DATE))),''))                                                                                                				then 1 else 0 end as str_truesincedate
	--,case when  HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(ma.SSUpdatedDate AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_dwmodifiedon AS DATE))),''))                                                                                                				then 1 else 0 end as str_dwmodifiedon
		

																																																								
-- SELECT *																	  
-- SELECT COUNT(*) 															  
FROM dbo.[Contact_Custom] b 
INNER JOIN dbo.Contact z ON b.SSB_CRMSYSTEM_CONTACT_ID = z.[SSB_CRMSYSTEM_CONTACT_ID]
LEFT JOIN  prodcopy.vw_contact c ON z.[crm_id] = c.contactID
LEFT JOIN dbo.KeyAccounts_Materialized k ON k.ssbid = z.SSB_CRMSYSTEM_CONTACT_ID AND k.Withhold_CustomUpdate = 1
--INNER JOIN dbo.CRMLoad_Contact_ProcessLoad_Criteria pl ON b.SSB_CRMSYSTEM_CONTACT_ID = pl.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN dbo.vwCompositeRecord_ModAcctID ma ON z.SSB_CRMSYSTEM_CONTACT_ID = ma.SSB_CRMSYSTEM_CONTACT_ID AND ma.SourceSystem = 'tm'
WHERE z.[SSB_CRMSYSTEM_CONTACT_ID] <> z.[crm_id]
AND k.ssid IS NULL
AND  (1=2
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemssidwinner)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemssidwinner AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.DimCustIDs)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbcrmsystemdimcustomerids AS VARCHAR(MAX)))),'')) 
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.new_ssbcrmsystemSSIDWinnerSourceSystem)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.new_ssbssidwinnersourcesystem AS VARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.str_number)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_number AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.telephone2)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.telephone2 AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.mobilephone)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.mobilephone AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.fax)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.fax AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.ownerid)),c.ownerid) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.ownerid AS VARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.owneridtype AS VARCHAR(MAX)))),CAST(c.owneridtype AS VARCHAR(MAX))) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.owneridtype AS VARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_since AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_since AS DATE))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(b.str_category)),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_category AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',CAST(ISNULL(LTRIM(RTRIM(b.str_clientdrwealerts)),c.str_clientdrwealerts) AS NVARCHAR(100)))  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientdrwealerts AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',CAST(ISNULL(LTRIM(RTRIM(b.str_clientoeionlineclub)),c.str_clientoeionlineclub) AS NVARCHAR(100)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientoeionlineclub AS NVARCHAR(MAX)))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_clientdrwealertsticketingdate AS DATE))),CAST(C.str_clientdrwealertsticketingdate AS DATE)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientdrwealertsticketingdate AS DATE))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_clientoeionlineclubticketingdate AS DATE))),CAST(c.str_clientoeionlineclubticketingdate AS DATE)) )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_clientoeionlineclubticketingdate AS DATE))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(b.str_truesincedate AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_truesincedate AS DATE))),''))
	OR HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(ma.SSUpdatedDate AS DATE))),'') )  <> HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(CAST(c.str_dwmodifiedon AS DATE))),''))
	)










GO
