delete from Localidade

use [testaduais]

alter table [dbo].[AlunoCompleto] 


alter table [dbo].[AlunoCompleto] add  codTipo int  
alter table [dbo].[EnsinoSuperiorMG] add  codTipo int 
alter table [dbo].[EstaduaisSaidaCompleto] add  codTipo int   

update [dbo].[AlunoCompleto]
set codTipo = '3'

update [dbo].[EnsinoSuperiorMG]
set codTipo = '1'


update [dbo].[EnsinoSuperiorMG]
set codTipo = '2'



alter table [dbo].[EnsinoSuperiorMG] add  ChaveSubistituta int identity primary key

alter table [dbo].[EstaduaisSaidaCompleto]  add  ChaveSubistituta int identity primary key

alter table [dbo].[Localidade] add ChaveSubistituta int

select * from AlunoCompleto
select * from [dbo].[EnsinoSuperiorMG]

-- carga na dimensão localidade 
INSERT INTO [DwProjeto].[dbo].[Localidade] (Municipio, Latitude, Longitude, Uf, ChaveSubistituta)
  SELECT distinct [testaduais].[dbo].[EstaduaisSaidaCompleto].Municipio,
          [testaduais].[dbo].[EstaduaisSaidaCompleto].Latitude,
          [testaduais].[dbo].[EstaduaisSaidaCompleto].Longitude,
		  [testaduais].[dbo].[EstaduaisSaidaCompleto].Uf,
		  [testaduais].[dbo].[EstaduaisSaidaCompleto].ChaveSubistituta
   FROM [testaduais].[dbo].[EstaduaisSaidaCompleto]

   select * from Localidade

   INSERT INTO [DwProjeto].[dbo].[Localidade] (Municipio, Latitude, Longitude, Uf, ChaveSubistituta)
  
  SELECT DISTINCT UPPER([testaduais].[dbo].[AlunoCompleto].nom_municipio_ibge),
				  [testaduais].[dbo].[AlunoCompleto].latitude,
                  [testaduais].[dbo].[AlunoCompleto].longitude,
				   [testaduais].[dbo].[AlunoCompleto].cod_uf,
				    [testaduais].[dbo].[AlunoCompleto].ChaveSubistituta
   FROM [testaduais].[dbo].[AlunoCompleto]
   EXCEPT 
   SELECT DISTINCT[DwProjeto].[dbo].[Localidade].Municipio,
				  [DwProjeto].[dbo].[Localidade].Latitude,
				  [DwProjeto].[dbo].[Localidade].Longitude,
				  [DwProjeto].[dbo].[Localidade].Uf,
				   [DwProjeto].[dbo].[Localidade].ChaveSubistituta
   FROM [DwProjeto].[dbo].[Localidade]

   select * from Localidade


   INSERT INTO [DwProjeto].[dbo].[Localidade] (Municipio, Latitude, Longitude, Uf, ChaveSubistituta)
  
  SELECT DISTINCT UPPER([testaduais].[dbo].[EnsinoSuperiorMG].Município),
				  [testaduais].[dbo].[EnsinoSuperiorMG].Latitude,
                  [testaduais].[dbo].[EnsinoSuperiorMG].Longitude,
				   [testaduais].[dbo].[EnsinoSuperiorMG].Uf,
				   [testaduais].[dbo].[EnsinoSuperiorMG].ChaveSubistituta
   FROM  [testaduais].[dbo].[EnsinoSuperiorMG]
   EXCEPT 
   SELECT DISTINCT[DwProjeto].[dbo].[Localidade].Municipio,
				  [DwProjeto].[dbo].[Localidade].Latitude,
				  [DwProjeto].[dbo].[Localidade].Longitude,
				  [DwProjeto].[dbo].[Localidade].Uf,
				  [DwProjeto].[dbo].[Localidade].ChaveSubistituta
   FROM [DwProjeto].[dbo].[Localidade]


   create index  [ChaveSubistituta] on  [dbo].[AlunoCompleto] ([ChaveSubistituta])

   create index  [ChaveSubistituta] on [dbo].[EnsinoSuperiorMG] ([ChaveSubistituta])

   create index  [ChaveSubistituta] on [dbo].[EstaduaisSaidaCompleto] ([ChaveSubistituta])

   create index  [ChaveSubistituta] on  [dbo].[Localidade] ([ChaveSubistituta])


   create index [codTipo]  on  [dbo].[AlunoCompleto] ([codTipo])
   create index [codTipo]  on  [dbo].[EnsinoSuperiorMG] ([codTipo])
   create index [codTipo]  on  [dbo].[EstaduaisSaidaCompleto] ([codTipo])

   create index [CodTipo]  on  [dbo].[Tipo] ([CodTipo])


insert into fato (Quantidade, CodLocalidade,CodTipo)
select top 3
count (*),
DimLocalidade.CodLocalidade,
t.CodTipo
from
Tipo t,
[testaduais].[dbo].[AlunoCompleto] Aluno,
[testaduais].[dbo].[EnsinoSuperiorMG] EnsMg,
[testaduais].[dbo].[EstaduaisSaidaCompleto] Estadual,
[DwProjeto].[dbo].[Localidade] DimLocalidade
where 
(Aluno.ChaveSubistituta = DimLocalidade.ChaveSubistituta OR
EnsMg.ChaveSubistituta = DimLocalidade.ChaveSubistituta or
Estadual.ChaveSubistituta = DimLocalidade.ChaveSubistituta)
AND
(t.CodTipo = Aluno.codTipo or
t.CodTipo = EnsMg.codTipo or
t.CodTipo = Estadual.codTipo)
group by
DimLocalidade.CodLocalidade,
t.CodTipo 

SELECT * FROM AlunoCompleto
SELECT * FROM EnsinoSuperiorMG
SELECT * FROM EstaduaisSaidaCompleto

  
SELECT * FROM Localidade

SELECT * FROM Tipo
