SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [wrk].[sp_Contact_Custom]
AS 

-------------------------------------------------------------------------------

-- Author name:		Kaitlyn Nelson
-- Created date:	2017
-- Purpose:			Populate custom fields for CRM outbound integration
-- Copyright © 2017, SSB, All Rights Reserved

-------------------------------------------------------------------------------

-- Modification History --
-- 2018-06-11		Kaitlyn Nelson
-- Change notes:	Added logic for a new custom field, str_clientcontacttype

-- Peer reviewed by:	Keegan Schmitt
-- Peer review notes:	Looks good.
-- Peer review date:	2018-06-11

-- Deployed by:
-- Deployment date:
-- Deployment notes:

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

MERGE INTO dbo.Contact_Custom Target
USING dbo.Contact source
ON source.[SSB_CRMSYSTEM_CONTACT_ID] = target.[SSB_CRMSYSTEM_CONTACT_ID]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([SSB_CRMSYSTEM_ACCT_ID], [SSB_CRMSYSTEM_CONTACT_ID]) VALUES (source.[SSB_CRMSYSTEM_ACCT_ID], Source.[SSB_CRMSYSTEM_CONTACT_ID])
WHEN NOT MATCHED BY SOURCE THEN
DELETE ;

EXEC dbo.sp_CRMProcess_ConcatIDs 'Contact'


--UPDATE a
--SET SeasonTicket_Years = recent.SeasonTicket_Years
----SELECT *
--FROM dbo.[Contact_Custom] a
--INNER JOIN dbo.CRMProcess_DistinctContacts recent ON [recent].[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_CONTACT_ID]

UPDATE a
SET a.new_ssbcrmsystemssidwinner = b.[SSID]
, a.new_ssbcrmsystemssidwinnerSourceSystem = b.SourceSystem
, a.mobilephone = b.PhoneCell
, a.telephone2 = b.PhoneHome
, a.fax = b.PhoneFax
, a.str_id = CASE WHEN b.sourcesystem = 'tm' THEN b.AccountId ELSE NULL end
, a.str_idtext = CASE WHEN b.sourcesystem = 'tm' THEN CAST(b.AccountId AS NVARCHAR(100)) ELSE NULL END
FROM [dbo].Contact_Custom a
INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON b.[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_CONTACT_ID]


-- str_Since --
SELECT cc.SSB_CRMSYSTEM_CONTACT_ID, MIN(tm.Since_date) AS sincedate
INTO #sincedate
FROM dbo.Contact_Custom cc
INNER JOIN dbo.vwDimCustomer_ModAcctId ma ON ma.SSB_CRMSYSTEM_CONTACT_ID = cc.SSB_CRMSYSTEM_CONTACT_ID AND ma.SourceSystem = 'tm'
INNER JOIN olympia.ods.TM_Cust tm ON ma.AccountId = tm.acct_id
GROUP BY cc.ssb_crmsystem_contact_id

UPDATE a 
SET str_since = sincedate 
FROM dbo.Contact_Custom a INNER JOIN #sincedate s ON s.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID

-- str_truesincedate --
UPDATE dbo.Contact_Custom
SET str_truesincedate = CASE WHEN pcc.str_truesincedate IS NOT NULL THEN pcc.str_truesincedate ELSE cc.str_since end
FROM dbo.Contact_Custom cc
INNER JOIN dbo.Contact c ON c.SSB_CRMSYSTEM_CONTACT_ID = cc.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN Prodcopy.vw_Contact pcc ON c.crm_id = CAST(pcc.contactid AS NVARCHAR(100))

DROP TABLE #sincedate



-- STR_CATEGORY --
SELECT DISTINCT
	ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, CASE 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and plan_event_name like 'ERWNG16L%' and t.section_name like 'LC%' then '16 Ticket - LC Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and t.plan_event_name like 'ERWNG17L%' and t.section_name like 'LC%' then '17 Ticket - LC Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and ((t.plan_event_name like 'ERWLCA16%' or t.plan_event_name like 'ERWLCB16%') or (t.ticket_type like '%Half%' and (t.ticket_type like '%Legends%' or t.ticket_type like '%LC%'))) and t.section_name like '%LC%' then '16 Ticket - LC Half'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and ((t.plan_event_name like 'ERWLCA17%' or t.plan_event_name like 'ERWLCB17%') or (t.ticket_type like '%Half%' and (t.ticket_type like '%Legends%' or t.ticket_type like '%LC%'))) and t.section_name like '%LC%' then '17 Ticket - LC Half'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.plan_event_name like 'ERWNG16O%' or t.plan_event_name like 'PARTOC16%') and (t.section_name like '%BOWL%' or t.section_name like '%TABLE%' or t.section_name like '%GA%') then '16 Ticket - Oly Club'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.plan_event_name like 'ERWNG17O%' or t.plan_event_name like 'PARTOC17%') and (t.section_name like '%BOWL%' or t.section_name like '%TABLE%') then '17 Ticket - Oly Club'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.plan_event_name like 'ERWING%' or t.plan_event_name = 'ERWNG16G') and t.ticket_type like '%Broker%' then '16 Ticket - Full Broker'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.plan_event_name like 'ERWING%' or t.plan_event_name = 'ERWNG17G') and t.ticket_type like '%Broker%' then '17 Ticket - Full Broker'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and t.ticket_type not like '%broker%' and (t.plan_event_name like 'ERWING%' or t.plan_event_name like 'ERWNG%' or t.ticket_type like '%full season%') and t.ticket_type not like '%presale%' then '16 Ticket - Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and t.ticket_type not like '%broker%' and (t.plan_event_name like 'ERWING%' or t.plan_event_name like 'ERWNG%' or t.ticket_type like '%full season%') and t.ticket_type not like '%presale%' then '17 Ticket - Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_1%' or (t.plan_event_name like '%16WKEND%' or t.plan_event_name like '%16WKNITE%')) and t.ticket_type not like '%Broker%' then '16 Ticket - 10 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_1%' or t.plan_event_name like '%10PLAN%') and t.ticket_type not like '%Broker%' then '17 Ticket - 10 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_2%' or (t.plan_event_name like '%16RED%' or t.plan_event_name like '%16WHITE%')) and t.ticket_type not like '%Broker%' then '16 Ticket - 20 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_2%' or t.plan_event_name like '%20PLAN%') and t.ticket_type not like '%Broker%' then '17 Ticket - 20 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_5%') and t.ticket_type not like '%Broker%' then '16 Ticket - 5 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_5%') and t.ticket_type not like '%Broker%' then '17 Ticket - 5 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_03%') and t.ticket_type not like '%Broker%' then '16 Ticket - 3 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_03%') and t.ticket_type not like '%Broker%' then '17 Ticket - 3 Game' 
	  WHEN sh.SeasonCode = 'RW16' and (t.ticket_type like '%Individual%' or t.price_code like '%__1' or t.price_code like '%__2') and t.ticket_type not like '%group%' then '16 Ticket - Individual'
	  WHEN sh.SeasonCode = 'RW17' and (t.ticket_type like '%Individual%' or t.price_code like '%__1' or t.price_code like '%__2') and t.ticket_type not like '%group%' then '17 Ticket - Individual'
	  WHEN sh.SeasonCode = 'RW16' and (t.ticket_type like '%Group%' or t.ticket_type like '%social%') then '16 Group' 
	  WHEN sh.SeasonCode = 'RW17' and (t.ticket_type like '%Group%' or t.ticket_type like '%social%') then '17 Group'
	  END AS Category
INTO #Categories
FROM Olympia.ods.TM_Ticket t (NOLOCK)
JOIN Olympia.dbo.dimevent e (NOLOCK)
	ON t.event_id = e.SSID_event_id
JOIN Olympia.dbo.DimEventHeader eh (NOLOCK)
	ON e.DimEventHeaderId = eh.DimEventHeaderId
JOIN Olympia.dbo.DimSeasonHeader sh (NOLOCK)
	ON eh.DimSeasonHeaderId = sh.DimSeasonHeaderId
JOIN dbo.DimCustomer dc (NOLOCK)
	ON t.acct_id = dc.AccountId
	AND dc.SourceSystem = 'TM'
	AND dc.CustomerType = 'Primary'
JOIN dbo.DimCustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
WHERE CASE 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and plan_event_name like 'ERWNG16L%' and t.section_name like 'LC%' then '16 Ticket - LC Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and t.plan_event_name like 'ERWNG17L%' and t.section_name like 'LC%' then '17 Ticket - LC Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and ((t.plan_event_name like 'ERWLCA16%' or t.plan_event_name like 'ERWLCB16%') or (t.ticket_type like '%Half%' and (t.ticket_type like '%Legends%' or t.ticket_type like '%LC%'))) and t.section_name like '%LC%' then '16 Ticket - LC Half'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and ((t.plan_event_name like 'ERWLCA17%' or t.plan_event_name like 'ERWLCB17%') or (t.ticket_type like '%Half%' and (t.ticket_type like '%Legends%' or t.ticket_type like '%LC%'))) and t.section_name like '%LC%' then '17 Ticket - LC Half'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.plan_event_name like 'ERWNG16O%' or t.plan_event_name like 'PARTOC16%') and (t.section_name like '%BOWL%' or t.section_name like '%TABLE%' or t.section_name like '%GA%') then '16 Ticket - Oly Club'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.plan_event_name like 'ERWNG17O%' or t.plan_event_name like 'PARTOC17%') and (t.section_name like '%BOWL%' or t.section_name like '%TABLE%') then '17 Ticket - Oly Club'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.plan_event_name like 'ERWING%' or t.plan_event_name = 'ERWNG16G') and t.ticket_type like '%Broker%' then '16 Ticket - Full Broker'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.plan_event_name like 'ERWING%' or t.plan_event_name = 'ERWNG17G') and t.ticket_type like '%Broker%' then '17 Ticket - Full Broker'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and t.ticket_type not like '%broker%' and (t.plan_event_name like 'ERWING%' or t.plan_event_name like 'ERWNG%' or t.ticket_type like '%full season%') and t.ticket_type not like '%presale%' then '16 Ticket - Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and t.ticket_type not like '%broker%' and (t.plan_event_name like 'ERWING%' or t.plan_event_name like 'ERWNG%' or t.ticket_type like '%full season%') and t.ticket_type not like '%presale%' then '17 Ticket - Full'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_1%' or (t.plan_event_name like '%16WKEND%' or t.plan_event_name like '%16WKNITE%')) and t.ticket_type not like '%Broker%' then '16 Ticket - 10 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_1%' or t.plan_event_name like '%10PLAN%') and t.ticket_type not like '%Broker%' then '17 Ticket - 10 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_2%' or (t.plan_event_name like '%16RED%' or t.plan_event_name like '%16WHITE%')) and t.ticket_type not like '%Broker%' then '16 Ticket - 20 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_2%' or t.plan_event_name like '%20PLAN%') and t.ticket_type not like '%Broker%' then '17 Ticket - 20 Game'
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_5%') and t.ticket_type not like '%Broker%' then '16 Ticket - 5 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_5%') and t.ticket_type not like '%Broker%' then '17 Ticket - 5 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' and (t.price_code like '_03%') and t.ticket_type not like '%Broker%' then '16 Ticket - 3 Game' 
	  WHEN t.add_user NOT IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' and (t.price_code like '_03%') and t.ticket_type not like '%Broker%' then '17 Ticket - 3 Game' 
	  WHEN sh.SeasonCode = 'RW16' and (t.ticket_type like '%Individual%' or t.price_code like '%__1' or t.price_code like '%__2') and t.ticket_type not like '%group%' then '16 Ticket - Individual'
	  WHEN sh.SeasonCode = 'RW17' and (t.ticket_type like '%Individual%' or t.price_code like '%__1' or t.price_code like '%__2') and t.ticket_type not like '%group%' then '17 Ticket - Individual'
	  WHEN sh.SeasonCode = 'RW16' and (t.ticket_type like '%Group%' or t.ticket_type like '%social%') then '16 Group' 
	  WHEN sh.SeasonCode = 'RW17' and (t.ticket_type like '%Group%' or t.ticket_type like '%social%') then '17 Group'
	  END IS NOT NULL

UNION ALL

SELECT DISTINCT
	  ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, CASE 
	  WHEN t.add_user IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' then '16 Ticket - Secondary'
	  WHEN t.add_user IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' then '17 Ticket - Secondary'
	  END AS Category
FROM Olympia.ods.TM_Tex t (NOLOCK)
JOIN Olympia.dbo.dimevent e (NOLOCK)
	ON t.event_id = e.SSID_event_id
JOIN Olympia.dbo.DimEventHeader eh (NOLOCK)
	ON e.DimEventHeaderId = eh.DimEventHeaderId
JOIN Olympia.dbo.DimSeasonHeader sh (NOLOCK)
	ON eh.DimSeasonHeaderId = sh.DimSeasonHeaderId
JOIN dbo.DimCustomer dc (NOLOCK)
	ON t.assoc_acct_id = dc.AccountId
	AND dc.SourceSystem = 'TM'
	AND dc.CustomerType = 'Primary'
JOIN dbo.DimCustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
WHERE CASE 
	  WHEN t.add_user IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW16' then '16 Ticket - Secondary'
	  WHEN t.add_user IN ('reissue2', 'reissue4') and sh.SeasonCode = 'RW17' then '17 Ticket - Secondary'
	  END IS NOT NULL



UPDATE a
SET a.str_category = b.Category
--SELECT a.SSB_CRMSYSTEM_CONTACT_ID, b.Category
FROM dbo.Contact_Custom a
LEFT JOIN (
	SELECT DISTINCT c.SSB_CRMSYSTEM_CONTACT_ID,
		SUBSTRING (
			(
				SELECT ' | ' + cat.Category AS [text()]
				FROM #Categories cat
				WHERE cat.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
				ORDER BY cat.SSB_CRMSYSTEM_CONTACT_ID, cat.Category DESC
				FOR XML PATH ('')
			), 4, 1000) AS [Category]
	FROM #Categories c
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID

DROP TABLE #Categories


/*
--FROM STR - STR_CATEGORY

update contact
SET STR_category =  SELECT SUBSTRING(ids, 0, len(ids)) 
FROM 
	(select distinct contactid, 
		(
			SELECT distinct
				case 
				when str_string1 is null and str_pricelevelidname = '2016-2017' and str_code like 'ERWNG16L%' and str_section like 'LC%' then '16 Ticket - LC Full'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and str_code like 'ERWNG17L%' and str_section like 'LC%' then '17 Ticket - LC Full'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and ((str_code like 'ERWLCA16%' or str_code like 'ERWLCB16%') or (str_type like '%Half%' and (str_type like '%Legends%' or str_type like '%LC%'))) and STR_Section like '%LC%' then '16 Ticket - LC Half'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and ((str_code like 'ERWLCA17%' or str_code like 'ERWLCB17%') or (str_type like '%Half%' and (str_type like '%Legends%' or str_type like '%LC%'))) and STR_Section like '%LC%' then '17 Ticket - LC Half'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_code like 'ERWNG16O%' or str_code like 'PARTOC16%') and (str_section like '%BOWL%' or str_section like '%TABLE%' or str_section like '%GA%') then '16 Ticket - Oly Club'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_code like 'ERWNG17O%' or str_code like 'PARTOC17%') and (str_section like '%BOWL%' or str_section like '%TABLE%') then '17 Ticket - Oly Club'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_code like 'ERWING%' or str_code = 'ERWNG16G') and STR_type like '%Broker%' then '16 Ticket - Full Broker'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_code like 'ERWING%' or str_code = 'ERWNG17G') and STR_type like '%Broker%' then '17 Ticket - Full Broker'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and str_type not like '%broker%' and (str_code like 'ERWING%' or str_code like 'ERWNG%' or str_type like '%full season%') and str_type not like '%presale%' then '16 Ticket - Full'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and str_type not like '%broker%' and (str_code like 'ERWING%' or str_code like 'ERWNG%' or str_type like '%full season%') and str_type not like '%presale%' then '17 Ticket - Full'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_string2 like '_1%' or (str_code like '%16WKEND%' or str_code like '%16WKNITE%')) and str_type not like '%Broker%' then '16 Ticket - 10 Game'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_string2 like '_1%' or str_code like '%10PLAN%') and str_type not like '%Broker%' then '17 Ticket - 10 Game'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_string2 like '_2%' or (str_code like '%16RED%' or str_code like '%16WHITE%')) and str_type not like '%Broker%' then '16 Ticket - 20 Game'
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_string2 like '_2%' or str_code like '%20PLAN%') and str_type not like '%Broker%' then '17 Ticket - 20 Game'
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_string2 like '_5%') and str_type not like '%Broker%' then '16 Ticket - 5 Game' 
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_string2 like '_5%') and str_type not like '%Broker%' then '17 Ticket - 5 Game' 
				when str_string1 is null and str_pricelevelidname = '2016-2017' and (str_string2 like '_03%') and str_type not like '%Broker%' then '16 Ticket - 3 Game' 
				when str_string1 is null and str_pricelevelidname = '2017-2018' and (str_string2 like '_03%') and str_type not like '%Broker%' then '17 Ticket - 3 Game' 
				when str_string1 is not null and str_pricelevelidname = '2016-2017' then '16 Ticket - Secondary'
				when str_string1 is not null and str_pricelevelidname = '2017-2018' then '17 Ticket - Secondary'
				when str_pricelevelidname = '2016-2017' and (str_type like '%Individual%' or str_string2 like '%__1' or str_string2 like '%__2') and str_type not like '%group%' then '16 Ticket - Individual'
				when str_pricelevelidname = '2017-2018' and (str_type like '%Individual%' or str_string2 like '%__1' or str_string2 like '%__2') and str_type not like '%group%' then '17 Ticket - Individual'
				when str_pricelevelidname = '2016-2017' and (str_type like '%Group%' or str_type like '%social%') then '16 Group' 
				when str_pricelevelidname = '2017-2018' and (str_type like '%Group%' or str_type like '%social%') then '17 Group'
				end + ' | '
			from etl.vw_str_ticketobject_fields
			where str_ticketorder.str_pricelevelidname in ('2016-2017','2017-2018') and str_category like '$ Red Wings%' and str_ticketorder.str_contactid = contact.contactid 
			order by 1 desc for XML PATH('')
		) ids
	from contact
	) contactids
JOIN contact
	ON contactids.contactid = contact.contactid
where contactids.ids is not null

*/

    
/*====================================
Owner (Salesperson) from Archtics
====================================*/
	UPDATE dbo.Contact_Custom
	SET ownerid = pcc.ownerid
	FROM dbo.Contact_Custom cc
	INNER JOIN dbo.contact c
		ON c.SSB_CRMSYSTEM_CONTACT_ID = cc.SSB_CRMSYSTEM_CONTACT_ID
	INNER JOIN Olympia_Reporting.prodcopy.Contact pcc
		ON pcc.contactid = c.crm_id

	UPDATE dbo.Contact_Custom
	SET ownerid = pcsu.systemuserid
	--SELECT cc.SSB_CRMSYSTEM_CONTACT_ID, pcsu.fullname, pcsu.systemuserid, cc.ownerid, pcsu.fullname
	FROM dbo.Contact_Custom cc
	INNER JOIN dbo.vwDimCustomer_ModAcctId dc
		ON cc.SSB_CRMSYSTEM_CONTACT_ID = dc.SSB_CRMSYSTEM_CONTACT_ID AND dc.SourceSystem = 'tm'
	INNER JOIN Olympia_Reporting.prodcopy.systemuser pcsu
		ON pcsu.fullname = dc.AccountRep AND pcsu.isdisabled = 0
	WHERE 
	1= 1
	--AND cc.ownerid IS NOT NULL 
	AND pcsu.systemuserid != cc.ownerid

--Don't overwrite CRM for specific users
	UPDATE dbo.Contact_Custom
	SET ownerid = pcc.ownerid
	--SELECT DISTINCT su.fullname
	FROM dbo.Contact_Custom cc
	INNER JOIN dbo.contact c
		ON c.SSB_CRMSYSTEM_CONTACT_ID = cc.SSB_CRMSYSTEM_CONTACT_ID
	INNER JOIN Olympia_Reporting.prodcopy.Contact pcc
		ON pcc.contactid = c.crm_id
	INNER JOIN Olympia_Reporting.prodcopy.systemuser su
		ON su.systemuserid = pcc.ownerid and su.isdisabled = 0
	INNER JOIN Olympia_Reporting.prodcopy.TeamMembership tm
		ON tm.systemuserid = su.systemuserid
	INNER JOIN Olympia_Reporting.prodcopy.team t
		ON t.teamid = tm.teamid
	WHERE t.teamid IN (
	'DF43CAAE-400C-E811-A81D-0050568E0FF7',	--All Sales - ISR & SS
	'816A6D81-4AD5-E711-8107-005056B0625E',	--Corporate Partnership
	'C0FE4A73-6151-E311-985B-005056B04C30',	--Group Sales
	'C806BC12-A3C8-E711-8105-005056B0625E'	--Premium Sales and Service
	)




	--default for new records being created that don't have an owner --Process Load Criteria sproc must run before this in order for this to work.
UPDATE contact_custom 
SET ownerid = '261EE697-1AB9-E011-B148-00155D013F02'
--SELECT COUNT(*)
 FROM contact_custom cc
INNER JOIN dbo.CRMLoad_Contact_ProcessLoad_Criteria pl
ON pl.SSB_CRMSYSTEM_CONTACT_ID = cc.SSB_CRMSYSTEM_CONTACT_ID
WHERE pl.LoadType = 'upsert' AND cc.ownerid IS NULL


--Owner Type from above
	UPDATE dbo.Contact_Custom SET owneridtype  = 'systemuser'
	FROM contact_custom cc
	INNER JOIN Olympia_Reporting.prodcopy.SystemUser su
	ON cc.ownerid = su.systemuserid

/*====================================
Owner (Salesperson) from Archtics
====================================*/

--str_SubCategory - Amy TO Provide Logic

--tickets, Event, Spend, etc. fields for Current, Previous, All Prior Seaons, and Current year Arena spends.

--Group Game Date

--Group buyer for Activity Creation workflow
	--had 8 or more tickets
	--amount greater than $0
	--order type != group
	--salesperson != andre davis or ashley dolin or clark rowenkamp or jaime clark or susan tuladzieck
	--contact name not like ivr !!!transcription
	--and email or businessphone has a value
	--and category like '%wings%' or (category contains arena and event contains wings) or (order string contains EJL1229 or 1230 or 0316 or 0317 or 0318) -- college hockey

--TouchPoint workflow field

--New Full workflow field - (String 2: B0 or BN) 

--Attendance percentage of initial purchaser

--Attendance percentage for tickets (regardless of final owner)


-- Set str_drwealerts, str_drw_ealertsticketingdate
UPDATE a
SET a.str_clientdrwealerts = 1
, a.str_clientdrwealertsticketingdate = b.MaxPurchaseDate
FROM dbo.Contact_Custom a
JOIN (
		SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, MAX(dd.CalDate) MaxPurchaseDate
		FROM (
				SELECT FactTicketSalesId, DimCustomerId, DimDateId
					, DimEventId, DimSeasonId
				FROM Olympia.dbo.FactTicketSales

				UNION ALL

				SELECT FactTicketSalesId, DimCustomerId, DimDateId
					, DimEventId, DimSeasonId
				FROM Olympia.dbo.FactTicketSalesHistory
			) f
		JOIN Olympia.dbo.DimCustomer dc
			ON f.DimCustomerId = dc.DimCustomerId
		JOIN Olympia.dbo.DimCustomerssbid ssbid
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN Olympia.dbo.DimDate dd
			ON f.DimDateId = dd.DimDateId
		JOIN Olympia.dbo.DimSeason s
			ON f.DimSeasonId = s.DimSeasonId
		WHERE s.SeasonName LIKE '%Season%' AND s.DimArenaId IN (1, 4)--f.DimSeasonId IN (30, 342, 29, 31, 301, 313, 304, 338, 341)
		GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Set str_clientoeionlineclub, str_clientoeionlineclubticketingdate
UPDATE a
SET a.str_clientoeionlineclub = 1 --1 = Yes, 2 = No
, a.str_clientoeionlineclubticketingdate = b.MaxPurchaseDate
FROM dbo.Contact_Custom a
JOIN (
		SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, MAX(dd.CalDate) MaxPurchaseDate
		FROM Olympia.dbo.FactTicketSales f
		JOIN Olympia.dbo.DimCustomer dc
			ON f.DimCustomerId = dc.DimCustomerId
		JOIN Olympia.dbo.DimCustomerssbid ssbid
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN Olympia.dbo.DimDate dd
			ON f.DimDateId = dd.DimDateId
		JOIN Olympia.dbo.DimEvent e
			ON f.DimEventId = e.DimEventId
		WHERE LEFT(e.EventCode,2) NOT IN ('ER', 'LR', 'SR', 'XR', 'PR')
		GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID


-- Set str_clientcontacttype
UPDATE a
SET a.str_clientcontacttype = ISNULL(b.ContactType, '')
FROM dbo.Contact_Custom a
LEFT JOIN (
		SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
			, CASE WHEN tmc.name_type = 'I' THEN 'Individual'
				WHEN tmc.name_type = 'C' THEN 'Business'
				END AS ContactType
		FROM Olympia.dbo.DimCustomer dc (NOLOCK)
		JOIN Olympia.dbo.DimCustomerssbid ssbid (NOLOCK)
			ON dc.DimCustomerId = ssbid.DimCustomerId
		JOIN Olympia.ods.TM_Cust tmc (NOLOCK)
			ON dc.AccountId = tmc.acct_id
			AND dc.SourceSystem = 'TM'
			AND dc.CustomerType = 'Primary'
	) b ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID

EXEC dbo.sp_CRMLoad_Contact_ProcessLoad_Criteria;

EXEC wrk.Materialize_KeyAccounts;

GO
