/****** Create Table Area_StaffWise ******/

USE [MFiS-4]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Area_StaffWise](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BranchCode] [varchar](50) NOT NULL,
	[AreaCode] [varchar](50) NULL,
	[StaffID] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[StaffInitDate] [varchar](50) NULL,
	[StaffEndDate] [varchar](50) NULL,
 CONSTRAINT [PK_Area_StaffWise] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Add Column to 2 table ******/

ALTER TABLE Loan_DataEntry add EntryPlatform varchar(50)
ALTER TABLE Deposit_DataEntry add EntryPlatform varchar(50)


/****** Create Table Area_StaffWise ******/

CREATE PROCEDURE [dbo].[SelectLastLoanDepositHistory] @VoucherNo nvarchar(100),@CustID varchar(50)
AS

select LastAdded.*,CustInfo.* from(select PDate,Vou_ChqNo,Cr, 'Savings' as DType,CustAccNo as AccountNo from Deposit_DataEntry 
where Vou_ChqNo=@VoucherNo
union
select PDate,VoucherNo as Vou_ChqNo,Cr, 'Loan' as DType,LoanNo as AccountNo from Loan_DataEntry 
where VoucherNo=@VoucherNo) as LastAdded
cross join CustInfo where CustIDNO=@CustID
GO


/****** RegStaff, Area_Staffwise,User_login should match all the data ******/