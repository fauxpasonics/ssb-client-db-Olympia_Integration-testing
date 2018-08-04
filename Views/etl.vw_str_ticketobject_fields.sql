SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_str_ticketobject_fields]
AS

SELECT DISTINCT
	  c.crm_id ContactID
	, ssbid.SSB_CRMSYSTEM_CONTACT_ID
	, CASE WHEN t.add_user = 'reissue2' THEN 'TicketsNow'
		   WHEN t.add_user = 'reissue4' THEN 'TM+'
		   ELSE NULL END AS str_string1
	, t.price_code AS str_string2
	, t.event_name AS str_string3
	, CAST(NULL AS NVARCHAR(255)) AS str_pricelevelidname
	, CASE WHEN t.plan_event_name = '' THEN NULL
		   ELSE t.plan_event_name END AS str_code
	, t.section_name AS str_section
	, CASE WHEN t.Ticket_Type = '' THEN NULL
		   ELSE t.Ticket_Type END AS str_type
FROM Olympia.ods.TM_Ticket t (NOLOCK)
JOIN Olympia.dbo.DimCustomer dc (NOLOCK)
	ON t.acct_id = dc.AccountId
	AND dc.SourceSystem = 'TM'
	AND dc.CustomerType = 'Primary'
JOIN Olympia.dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerId
JOIN Olympia_Integration.dbo.Contact c (NOLOCK)
	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID



GO
