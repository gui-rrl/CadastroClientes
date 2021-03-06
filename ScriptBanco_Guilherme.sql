USE [Cliente]
GO
/****** Object:  User [guilherme]    Script Date: 11/04/2022 23:22:45 ******/
CREATE USER [guilherme] FOR LOGIN [guilherme] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [GUILHERME\Guilherme]    Script Date: 11/04/2022 23:22:45 ******/
CREATE USER [GUILHERME\Guilherme] FOR LOGIN [GUILHERME\Guilherme] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](60) NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[DataNascimento] [date] NOT NULL,
	[EstadoCivil] [char](1) NOT NULL,
	[CPF] [char](14) NOT NULL,
	[RG] [char](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Endereco]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Endereco](
	[ID_Endereco] [int] IDENTITY(1,1) NOT NULL,
	[ID_Tipo] [int] NULL,
	[Logradouro] [varchar](60) NULL,
	[Numero] [int] NULL,
	[Complemento] [varchar](20) NULL,
	[Cidade] [varchar](30) NULL,
	[UF] [char](2) NULL,
	[CEP] [char](9) NULL,
	[FK_ClienteEndereco] [int] NULL,
 CONSTRAINT [PK__Endereco__FDCCCFA6FF1FC1F8] PRIMARY KEY CLUSTERED 
(
	[ID_Endereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Endereco]  WITH NOCHECK ADD  CONSTRAINT [FK_ClienteEndereco] FOREIGN KEY([FK_ClienteEndereco])
REFERENCES [dbo].[Cliente] ([ID_Cliente])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Endereco] NOCHECK CONSTRAINT [FK_ClienteEndereco]
GO
/****** Object:  StoredProcedure [dbo].[SP_ClienteAlterar]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela altera um Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ClienteAlterar]
	-- Add the parameters for the stored procedure here
	@ID_Cliente int, 
	@nome nvarchar(60),
	@sexo char(1),
	@dataNascimento date,
	@estadoCivil char(1),
	@cpf char(14),
	@rg char(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


UPDATE [dbo].[Cliente]
   SET [Nome] = @nome
      ,[Sexo] = @sexo
      ,[DataNascimento] = @dataNascimento
      ,[EstadoCivil] = @estadoCivil
      ,[CPF] = @cpf
      ,[RG] = @rg
 WHERE ID_Cliente = @ID_Cliente
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ClienteExcluir]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela altera um Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ClienteExcluir]
	-- Add the parameters for the stored procedure here
	@id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

DELETE FROM ENDERECO 
WHERE FK_ClienteEndereco = @id

DELETE FROM [dbo].[Cliente]
      WHERE ID_Cliente = @id

END
GO
/****** Object:  StoredProcedure [dbo].[SP_ClienteInserir]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela insere um Cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ClienteInserir]
	-- Add the parameters for the stored procedure here
	@nome nvarchar(60),
	@sexo char(1),
	@dataNascimento date,
	@estadoCivil char(1),
	@cpf char(14),
	@rg char(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


INSERT INTO [dbo].[Cliente]
           ([Nome]
           ,[Sexo]
           ,[DataNascimento]
           ,[EstadoCivil]
           ,[CPF]
           ,[RG])
     VALUES
          (@nome
           ,@sexo
           ,@dataNascimento
           ,@estadoCivil 
           ,@cpf 
           ,@rg )

		   SELECT @@IDENTITY 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ClienteSelecionar]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela retorna todos os cliente>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ClienteSelecionar]
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SELECT [ID_Cliente]
      ,[Nome]
      ,[Sexo]
      ,[DataNascimento]
      ,[EstadoCivil]
      ,[CPF]
      ,[RG]
  FROM [dbo].[Cliente]
		
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ClienteSelecionarId]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela retorna um cliente por um ID>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ClienteSelecionarId]
	-- Add the parameters for the stored procedure here
	@Id int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT [ID_Cliente]
			,[Nome]
			,[Sexo]
			,[DataNascimento]
			,[EstadoCivil]
			,[CPF]
			,[RG]
  FROM [dbo].[Cliente] 
  WHERE ID_Cliente = @Id



END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoAlterar]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela altera um endereço>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoAlterar]
	-- Add the parameters for the stored procedure here
	@id int, 
	@idTipo int,
	@logradouro varchar(60),
	@numero int,
	@complemento varchar(20),
	@cidade varchar(30),
	@uf char(2),
	@cep char (9)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


UPDATE [dbo].[Endereco]
   SET [ID_Tipo] = @idTipo
      ,[Logradouro] = @logradouro
      ,[Numero] = @numero
      ,[Complemento] = @complemento
      ,[Cidade] = @cidade
      ,[UF] = @uf
      ,[CEP] = @cep
      
 WHERE ID_Endereco = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoExcluir]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela exclui um endereço>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoExcluir]
	-- Add the parameters for the stored procedure here
	@id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


DELETE FROM [dbo].[Endereco]
      WHERE ID_Endereco = @id

END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoExcluirPorCliente]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoExcluirPorCliente]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	DELETE FROM [dbo].[Endereco]
      WHERE FK_ClienteEndereco = @id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoInserir]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela insere um endereço>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoInserir]
	-- Add the parameters for the stored procedure here
	@idCliente int,
	@idTipo int,
	@logradouro varchar(60),
	@numero int,
	@complemento varchar(20),
	@cidade varchar(30),
	@uf char(2),
	@cep char (9)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


INSERT INTO [dbo].[Endereco]
           ([FK_ClienteEndereco]
		   ,[ID_Tipo]
           ,[Logradouro]
           ,[Numero]
           ,[Complemento]
           ,[Cidade]
           ,[UF]
           ,[CEP])
           
     VALUES
		   (@IdCliente
		   ,@idTipo
           ,@logradouro
           ,@numero           
           ,@complemento
           ,@cidade
           ,@uf
           ,@cep)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoSelecionar]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela retorna todos os endereços>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoSelecionar]
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	  SELECT [ID_Endereco]
			,[ID_Tipo]
			,[Logradouro]
			,[Numero]
			,[Complemento]
			,[Cidade]
			,[UF]
			,[CEP]
			,[FK_ClienteEndereco]
		FROM [dbo].[Endereco]
		
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoSelecionarId]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Guilherme>
-- Create date: <04/04/2022>
-- Description:	<Ela retorna um endereço por um ID>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoSelecionarId]
	-- Add the parameters for the stored procedure here
	@Id int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		SELECT [ID_Endereco]
			,[ID_Tipo]
			,[Logradouro]
			,[Numero]
			,[Complemento]
			,[Cidade]
			 ,[UF]
			,[CEP]
			,[FK_ClienteEndereco]
		FROM [dbo].[Endereco]
		WHERE ID_Endereco = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EnderecoSelecionarPorCliente]    Script Date: 11/04/2022 23:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_EnderecoSelecionarPorCliente] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID_Endereco]
			,[ID_Tipo]
			,[Logradouro]
			,[Numero]
			,[Complemento]
			,[Cidade]
			,[UF]
			,[CEP]
			,[FK_ClienteEndereco]
		FROM [dbo].[Endereco]
		WHERE FK_ClienteEndereco = @id
END
GO
