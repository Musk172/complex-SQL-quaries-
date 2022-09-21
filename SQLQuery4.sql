with W as (
	select * from Warehouse),
	days as (
	select  top 1 OnHandQuantity,event_datetime,
			DATEADD(day,-90,event_datetime) as days_90,
			DATEADD(day,-180,event_datetime) as days_180,
			DATEADD(day,-270,event_datetime) as days_270,
			DATEADD(day,-365,event_datetime) as days_365
	from W ),
	day_90 as (
	select case when (sum(OnHandQuantityDelta) > D.OnHandQuantity) then D.OnHandQuantity
				ELSE sum(OnHandQuantityDelta)
				end as '0-90 days old'
	from W
	cross join days D 
	where event_type = 'InBound' and W.event_datetime > days_90
	group by D.OnHandQuantity),
	day_180 as (
	select  case when ((D.OnHandQuantity - d9.[0-90 days old]) < D.OnHandQuantity) then (D.OnHandQuantity - [0-90 days old])
				 else D.OnHandQuantity 
				 END as '91-180 days old'
	from W
	cross join days D 
	cross join day_90 d9
	where W.event_datetime between days_180 and days_90
		  and event_type = 'InBound'
	)
select * from day_90
cross join day_180