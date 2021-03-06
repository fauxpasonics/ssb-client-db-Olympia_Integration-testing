CREATE TABLE [MERGEPROCESS_New].[LogPreMergeAccount]
(
[FK_MergeID] [int] NOT NULL,
[ObjectType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MergeRecordType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LogDate] [datetime] NULL,
[accountcategorycode] [int] NULL,
[accountcategorycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountclassificationcode] [int] NULL,
[accountclassificationcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountid] [uniqueidentifier] NOT NULL,
[accountnumber] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountratingcode] [int] NULL,
[accountratingcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_addressid] [uniqueidentifier] NULL,
[address1_addresstypecode] [int] NULL,
[address1_addresstypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_city] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_composite] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_country] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_county] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_freighttermscode] [int] NULL,
[address1_freighttermscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_latitude] [float] NULL,
[address1_line1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_line2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_line3] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_longitude] [float] NULL,
[address1_name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_postalcode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_postofficebox] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_primarycontactname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_shippingmethodcode] [int] NULL,
[address1_shippingmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_stateorprovince] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_upszone] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1_utcoffset] [int] NULL,
[address2_addressid] [uniqueidentifier] NULL,
[address2_addresstypecode] [int] NULL,
[address2_addresstypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_city] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_composite] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_country] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_county] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_freighttermscode] [int] NULL,
[address2_freighttermscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_latitude] [float] NULL,
[address2_line1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_line2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_line3] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_longitude] [float] NULL,
[address2_name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_postalcode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_postofficebox] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_primarycontactname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_shippingmethodcode] [int] NULL,
[address2_shippingmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_stateorprovince] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_upszone] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2_utcoffset] [int] NULL,
[aging30] [money] NULL,
[aging30_base] [money] NULL,
[aging60] [money] NULL,
[aging60_base] [money] NULL,
[aging90] [money] NULL,
[aging90_base] [money] NULL,
[businesstypecode] [int] NULL,
[businesstypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdby] [uniqueidentifier] NULL,
[createdbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdon] [datetime] NULL,
[createdonbehalfby] [uniqueidentifier] NULL,
[createdonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[creditlimit] [money] NULL,
[creditlimit_base] [money] NULL,
[creditonhold] [bit] NULL,
[creditonholdname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customersizecode] [int] NULL,
[customersizecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customertypecode] [int] NULL,
[customertypecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[defaultpricelevelid] [uniqueidentifier] NULL,
[defaultpricelevelidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotbulkemail] [bit] NULL,
[donotbulkemailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotbulkpostalmail] [bit] NULL,
[donotbulkpostalmailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotemail] [bit] NULL,
[donotemailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotfax] [bit] NULL,
[donotfaxname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotphone] [bit] NULL,
[donotphonename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotpostalmail] [bit] NULL,
[donotpostalmailname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotsendmarketingmaterialname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotsendmm] [bit] NULL,
[emailaddress1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[emailaddress2] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[emailaddress3] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[entityimage] [varbinary] (max) NULL,
[entityimage_timestamp] [bigint] NULL,
[entityimage_url] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[entityimageid] [uniqueidentifier] NULL,
[et_lastbouncedate] [datetime] NULL,
[et_lastbouncesendid] [uniqueidentifier] NULL,
[et_lastbouncesendidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[et_lastbouncetype] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchangerate] [decimal] (28, 0) NULL,
[fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ftpsiteurl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[importsequencenumber] [int] NULL,
[industrycode] [int] NULL,
[industrycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[isprivatename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lastusedincampaign] [datetime] NULL,
[marketcap] [money] NULL,
[marketcap_base] [money] NULL,
[masteraccountidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[masteraccountidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[masterid] [uniqueidentifier] NULL,
[merged] [bit] NULL,
[mergedname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedby] [uniqueidentifier] NULL,
[modifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedon] [datetime] NULL,
[modifiedonbehalfby] [uniqueidentifier] NULL,
[modifiedonbehalfbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedonbehalfbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[numberofemployees] [int] NULL,
[opendeals] [int] NULL,
[opendeals_date] [datetime] NULL,
[opendeals_state] [int] NULL,
[openrevenue] [money] NULL,
[openrevenue_base] [money] NULL,
[openrevenue_date] [datetime] NULL,
[openrevenue_state] [int] NULL,
[originatingleadid] [uniqueidentifier] NULL,
[originatingleadidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[originatingleadidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[overriddencreatedon] [datetime] NULL,
[ownerid] [uniqueidentifier] NULL,
[owneridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridtype] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ownershipcode] [int] NULL,
[ownershipcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owningbusinessunit] [uniqueidentifier] NULL,
[owningteam] [uniqueidentifier] NULL,
[owninguser] [uniqueidentifier] NULL,
[parentaccountid] [uniqueidentifier] NULL,
[parentaccountidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentaccountidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[participatesinworkflow] [bit] NULL,
[participatesinworkflowname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[paymenttermscode] [int] NULL,
[paymenttermscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredappointmentdaycode] [int] NULL,
[preferredappointmentdaycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredappointmenttimecode] [int] NULL,
[preferredappointmenttimecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredcontactmethodcode] [int] NULL,
[preferredcontactmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredequipmentid] [uniqueidentifier] NULL,
[preferredequipmentidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredserviceid] [uniqueidentifier] NULL,
[preferredserviceidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredsystemuserid] [uniqueidentifier] NULL,
[preferredsystemuseridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferredsystemuseridyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primarycontactid] [uniqueidentifier] NULL,
[primarycontactidname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primarycontactidyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[processid] [uniqueidentifier] NULL,
[revenue] [money] NULL,
[revenue_base] [money] NULL,
[sharesoutstanding] [int] NULL,
[shippingmethodcode] [int] NULL,
[shippingmethodcodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sic] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stageid] [uniqueidentifier] NULL,
[statecode] [int] NULL,
[statecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[statuscode] [int] NULL,
[statuscodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[stockexchange] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_averagefbspend] [money] NULL,
[str_averagefbspend_base] [money] NULL,
[str_category] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientaccountnumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientclubname] [int] NULL,
[str_clientclubnamename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientcontractedpasses] [int] NULL,
[str_clientcorporatepartner] [int] NULL,
[str_clientcorporatepartnername] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientendingseason] [uniqueidentifier] NULL,
[str_clientendingseasonname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientfiscalyearend] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientidentifier] [int] NULL,
[str_clientidentifiername] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientparkinglocation] [int] NULL,
[str_clientparkinglocationname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientpif] [int] NULL,
[str_clientpifname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientprimeseatcontact] [bit] NULL,
[str_clientprimeseatcontactname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientrefundoption] [int] NULL,
[str_clientrefundoptionname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientrevenueperyear] [money] NULL,
[str_clientrevenueperyear_base] [money] NULL,
[str_clientrevenueyear2] [money] NULL,
[str_clientrevenueyear2_base] [money] NULL,
[str_clientrevenueyear3] [money] NULL,
[str_clientrevenueyear3_base] [money] NULL,
[str_clientrevenueyear4] [money] NULL,
[str_clientrevenueyear4_base] [money] NULL,
[str_clientrevenueyear5] [money] NULL,
[str_clientrevenueyear5_base] [money] NULL,
[str_clientrevenueyear6] [money] NULL,
[str_clientrevenueyear6_base] [money] NULL,
[str_clientrevenueyear7] [money] NULL,
[str_clientrevenueyear7_base] [money] NULL,
[str_clientstartingseason] [uniqueidentifier] NULL,
[str_clientstartingseasonname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientterm] [int] NULL,
[str_clienttermname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clienttotalrevenue] [money] NULL,
[str_clienttotalrevenue_base] [money] NULL,
[str_custom1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_custom2] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_custom3] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_custom4] [nvarchar] (550) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_decisionapprovalprocess] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_dwduplicate] [bit] NULL,
[str_dwduplicatename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_dwid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_dwmodifiedon] [datetime] NULL,
[str_id] [int] NULL,
[str_idtext] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_leadsourcecode] [int] NULL,
[str_leadsourcecodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_league1] [int] NULL,
[str_league2] [int] NULL,
[str_league3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_league4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_league5] [int] NULL,
[str_league6] [int] NULL,
[str_league7] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_league8] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_level1tpsperqtr] [int] NULL,
[str_level2tpsperqtr] [int] NULL,
[str_marketingaccountindustryid] [uniqueidentifier] NULL,
[str_marketingaccountindustryidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_marketingaccountsourceid] [uniqueidentifier] NULL,
[str_marketingaccountsourceidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_naeducatedondecpricing] [bit] NULL,
[str_naeducatedondecpricingname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartactivation] [bit] NULL,
[str_napartactivationname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartcamvissignage] [bit] NULL,
[str_napartcamvissignagename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartentitlementnaming] [bit] NULL,
[str_napartentitlementnamingname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartiegcategory] [int] NULL,
[str_napartiegcategoryname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartlastmodifiedby] [uniqueidentifier] NULL,
[str_napartlastmodifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartlastmodifiedbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartlastmodifieddate] [datetime] NULL,
[str_napartmedia] [bit] NULL,
[str_napartmediadigitalsocial] [bit] NULL,
[str_napartmediadigitalsocialname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartmedianame] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartnewarenacontact] [uniqueidentifier] NULL,
[str_napartnewarenacontactname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartnewarenacontactyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothernotesreq] [bit] NULL,
[str_napartothernotesreqname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuecollege] [bit] NULL,
[str_napartothervenuecollegename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuelions] [bit] NULL,
[str_napartothervenuelionsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuemis] [bit] NULL,
[str_napartothervenuemisname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuepistons] [bit] NULL,
[str_napartothervenuepistonsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuespartner] [bit] NULL,
[str_napartothervenuespartnername] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartothervenuetigers] [bit] NULL,
[str_napartothervenuetigersname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartpotentialspend] [int] NULL,
[str_napartpotentialspendname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napartrevenuetarget] [money] NULL,
[str_napartrevenuetarget_base] [money] NULL,
[str_napremclubseats] [bit] NULL,
[str_napremclubseatsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremlastmodifiedby] [uniqueidentifier] NULL,
[str_napremlastmodifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremlastmodifiedbyyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremlastmodifieddate] [datetime] NULL,
[str_napremminisuites] [bit] NULL,
[str_napremminisuitesname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremnewarenacontact] [uniqueidentifier] NULL,
[str_napremnewarenacontactname] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremnewarenacontactyominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremnewarenanotes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremother] [bit] NULL,
[str_napremothername] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuecollege] [bit] NULL,
[str_napremothervenuecollegename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuemis] [bit] NULL,
[str_napremothervenuemisname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuepistons] [bit] NULL,
[str_napremothervenuepistonsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuesclubs] [bit] NULL,
[str_napremothervenuesclubsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenueslions] [bit] NULL,
[str_napremothervenueslionsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuessuites] [bit] NULL,
[str_napremothervenuessuitesname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremothervenuetigers] [bit] NULL,
[str_napremothervenuetigersname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_naprempotentialspend] [int] NULL,
[str_naprempotentialspendname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremseasontickets] [bit] NULL,
[str_napremseasonticketsname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_napremsuites] [bit] NULL,
[str_napremsuitesname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_number] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnersalesperson] [uniqueidentifier] NULL,
[str_partnersalespersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnersalespersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnerserviceperson] [uniqueidentifier] NULL,
[str_partnerservicepersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnerservicepersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnershipclosedate] [datetime] NULL,
[str_partnershipcloseprobability] [int] NULL,
[str_partnershipcomments] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnershipnewarenanotes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnershipphase] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_partnershiprevenue] [money] NULL,
[str_partnershiprevenue_base] [money] NULL,
[str_partnershipstatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_premiumsalesperson] [uniqueidentifier] NULL,
[str_premiumsalespersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_premiumsalespersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_premiumserviceperson] [uniqueidentifier] NULL,
[str_premiumservicepersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_premiumservicepersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_revenueyear5] [money] NULL,
[str_revenueyear5_base] [money] NULL,
[str_search] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_select] [bit] NULL,
[str_selectname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_serviceperson] [uniqueidentifier] NULL,
[str_servicepersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_servicepersonyominame] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_source] [nvarchar] (121) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_suiteholdersince] [datetime] NULL,
[telephone1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[telephone2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[telephone3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[territorycode] [int] NULL,
[territorycodename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[territoryid] [uniqueidentifier] NULL,
[territoryidname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tickersymbol] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[timezoneruleversionnumber] [int] NULL,
[transactioncurrencyid] [uniqueidentifier] NULL,
[transactioncurrencyidname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[traversedpath] [nvarchar] (1250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[utcconversiontimezonecode] [int] NULL,
[versionnumber] [bigint] NULL,
[websiteurl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[yominame] [nvarchar] (160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[copyloaddate] [datetime] NULL,
[str_clientssbmerge] [bit] NULL,
[str_ssbcrmsystemacctid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_clientssbmergename] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemSSIDWinnerSourceSystem] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemssidwinner] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemdimcustomerids] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[new_ssbcrmsystemacctid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
