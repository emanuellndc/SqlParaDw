CREATE TABLE dim_localidade (
CodLocalidade INTEGER PRIMARY KEY IDENTITY,
CidadeEstado VARCHAR(50),
)

CREATE TABLE dim_calendario (
CodCalendario INTEGER PRIMARY KEY IDENTITY,
Ano INTEGER,
Mes INTEGER,
Turno INTEGER,
DiaSemana VARCHAR(50)
)

CREATE TABLE fato_evento (
CodCalendario INTEGER,
CodLocalidade INTEGER,
QuantidadeEventos INTEGER,
FOREIGN KEY(CodLocalidade) REFERENCES dim_localidade (CodLocalidade)
)
ALTER TABLE fato_evento ADD FOREIGN KEY(CodCalendario) REFERENCES dim_calendario (CodCalendario)



select * from [dbo].[dim_localidade]


insert into [DwEventos].[dbo].[dim_calendario]
SELECT distinct cast(year([Eventos].dbo.[Eventos].[start_time])as char(4))as ano,
cast (month([Eventos].dbo.[Eventos].[start_time]) as char(4)) as mes, 
CASE WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <14 THEN 'Manha'
            WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <17 THEN 'Tarde'
            WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <21 THEN 'Noite' ELSE 'Noite' 
			END as turno,
datepart(dw,[Eventos].dbo.[Eventos].[start_time]) as diasemana
From [Eventos].dbo.Eventos


select * from Eventos

select count() from Eventos 
Where Endereco = 'Belo Horizonte, MG, BR'

select * from Eve

insert into [dbo].[fato_evento]
select [dbo].[dim_calendario].CodCalendario,
[dbo].[dim_localidade].CodLocalidade,
count([Eventos].[dbo].[Eventos].Endereco)
from [Eventos].[dbo].[Eventos], 
[DwEventos].[dbo].[dim_calendario], 
[DwEventos].[dbo].[dim_localidade]
where 
[Eventos].[dbo].[Eventos].Endereco = [DwEventos].[dbo].dim_localidade.CidadeEstado AND
[DwEventos].[dbo].dim_calendario.Ano = year([Eventos].dbo.[Eventos].[start_time]) and
[DwEventos].[dbo].dim_calendario.Mes = month([Eventos].dbo.[Eventos].[start_time]) and
[DwEventos].[dbo].dim_calendario.DiaSemana = datepart(dw,[Eventos].dbo.[Eventos].[start_time]) and
[DwEventos].[dbo].dim_calendario.Turno = (CASE WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <14 THEN 'Manha'
            WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <17 THEN 'Tarde'
            WHEN DATEPART(HOUR,[Eventos].dbo.[Eventos].[start_time]) <21 THEN 'Noite' ELSE 'Noite' 
			END)
group by 
[dbo].[dim_calendario].CodCalendario,
[dbo].[dim_localidade].CodLocalidade

select * from fato_evento
