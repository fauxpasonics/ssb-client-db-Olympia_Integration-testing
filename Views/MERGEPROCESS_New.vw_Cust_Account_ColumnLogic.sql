SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE VIEW [MERGEPROCESS_New].[vw_Cust_Account_ColumnLogic]
AS
SELECT  ID AS targetid ,
		Slave_ID AS subordinateid ,					--	DCH 2016-10-04
		1 AS CoalesceNonEmptyValues,
        CAST(SUBSTRING(donotbulkemail, 2, 1) AS BIT) donotbulkemail ,
        CAST(SUBSTRING(donotemail, 2, 1) AS BIT) donotemail ,
        CAST(SUBSTRING(aa.donotbulkpostalmail, 2, 1) AS BIT) donotbulkpostalmail,
		CAST(SUBSTRING(aa.donotfax, 2, 1) AS BIT) donotfax,
		CAST(SUBSTRING(donotphone, 2, 1) AS BIT) donotphone ,
		CAST(SUBSTRING(donotpostalmail, 2, 1) AS BIT) donotpostalmail ,
		CAST(SUBSTRING(donotsendmm, 2, 1) AS BIT) donotsendmm
FROM    ( SELECT    Master_SFID AS ID ,
					Slave_SFID AS Slave_ID ,					--	DCH 2016-10-04
					/*These statements rank the values in the given field for the Master (winning) and Slave (losing) records.*/
                    MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotbulkemail,0) <> 0
                             THEN '2' + CAST(donotbulkemail AS VARCHAR(10)) /*If donotbulkemail = 0 on the winning record, this is null*/
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotbulkemail,0) <> 0
                             THEN '1' + CAST(donotbulkemail AS VARCHAR(10)) /*If donotbulkemail = 1 on the losing record, this = 11, and will win over the previous null value*/
                        END) donotbulkemail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotemail,0) <> 0
                             THEN '2' + CAST(donotemail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotemail,0) <> 0
                             THEN '1' + CAST(donotemail AS VARCHAR(10))
                        END) donotemail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotbulkpostalmail,0) <> 0
                             THEN '2' + CAST(donotbulkpostalmail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotbulkpostalmail,0) <> 0
                             THEN '1' + CAST(donotbulkpostalmail AS VARCHAR(10))
                        END) donotbulkpostalmail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotfax,0)  <> 0
                             THEN '2' + CAST(donotfax AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotfax,0) <> 0
                             THEN '1' + CAST(donotfax AS VARCHAR(10))
                        END) donotfax ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotphone,0) <> 0
                             THEN '2' + CAST(donotphone AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotphone,0) <> 0
                             THEN '1' + CAST(donotphone AS VARCHAR(10))
                        END) donotphone ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotpostalmail,0)  <> 0
                             THEN '2' + CAST(dta.donotpostalmail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(dta.donotpostalmail,0) <> 0
                             THEN '1' + CAST(dta.donotpostalmail AS VARCHAR(10))
                        END) donotpostalmail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(dta.donotsendmm,0) <> 0
                             THEN '2' + CAST(dta.donotsendmm AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(dta.donotsendmm,0) <> 0
                             THEN '1' + CAST(dta.donotsendmm AS VARCHAR(10))
                        END) donotsendmm

          FROM      ( SELECT    *
                      FROM      ( SELECT    'Master' xtype ,
                                            a.Master_SFID ,
											a.Slave_SFID ,					--	DCH 2016-10-04
                                            b.*
                                  FROM      [MERGEPROCESS_New].[Queue] a
                                            JOIN mergeprocess_new.tmp_pcaccount b ON a.Master_SFID = b.accountid
											--where fk_mergeid < 1000
                                  UNION ALL
                                  SELECT    'Slave' xtype ,
                                            a.Master_SFID ,
											a.Slave_SFID ,					--	DCH 2016-10-04
                                            b.*
                                  FROM      [MERGEPROCESS_New].[Queue] a
                                            JOIN mergeprocess_new.tmp_pcaccount b ON a.Slave_SFID = b.accountid
											--where fk_mergeid < 1000
                                ) x
                    ) dta
          GROUP BY  Master_SFID ,
					Slave_SFID					--	DCH 2016-10-04				
        ) aa
/*
where ID IN ('E4E2D6F3-C470-DC11-8633-001143E50512','54E777B7-1D1D-E211-BF41-001D0967E0FC','8A445D0C-10FF-E011-A528-001D0967E0FC')

*/

;




GO
