CREATE TABLE [MERGEPROCESS_New].[ForceMerge]
(
[ForceMergeID] [int] NOT NULL IDENTITY(1, 1),
[FK_MergeID] [int] NOT NULL,
[CreatedDate] [datetime] NULL CONSTRAINT [DF__ForceMerg__Creat__45BE5BA9] DEFAULT (getdate()),
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Complete] [bit] NULL CONSTRAINT [DF__ForceMerg__Compl__46B27FE2] DEFAULT ((0)),
[CompletedDate] [datetime] NULL,
[CompletionNotes] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
