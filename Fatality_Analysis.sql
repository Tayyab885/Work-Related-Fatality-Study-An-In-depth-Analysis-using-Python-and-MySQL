Select *
From Projects.dbo.Fatality;

-- Task#1: Calculate the total number of incidents reported in the given dataset.
Select Count(*) AS Total_Number_of_Incidents
From Projects.dbo.Fatality;

-- Task#2: Calculates the total number of fatalities that recieved a citation
Select Count(*) as recieved_citations
From Projects.dbo.Fatality
Where citation = 'yes';

-- Task#3: Calculates day of the week that reported more number of fatalities and percentage(Rounds the percentage to two decimal places).
Select day_of_week,
	Count(day_of_week) as total_fatalities,
	Round(Count(day_of_week)*100.0 /  Sum(Count(day_of_week)) Over(),2) as Percentage
From Projects.dbo.Fatality
Group By day_of_week;

-- Task#4: Calculates the total number of fatalities during welding
Select Count(*) as total_fatalities_during_welding
From Projects.dbo.Fatality
Where description Like '%welding%';

-- Task#5:  Calculates the last 5 fatalities during welding
Select Top 5 *
From Projects.dbo.Fatality
Where description Like '%welding%'
Order By incident_date Desc;

-- Task#6: Calculates the top 5 states which have most fatal incidents
Select Top 5 state,
	Count(*) As total_fatalities
From Projects.dbo.Fatality
Group By state
Order By total_fatalities Desc;

-- Task#7: Calculates the top 5 states which have most fatal incidents happed from stabbing
Select Top 5 state,
	Count(*) as total_fatalities
From Projects.dbo.Fatality
Where description Like '%stabbing%'
Group By state
Order By total_fatalities Desc;

-- Task#8: Calculates the top 10 states which have most fatal incidents happed from shooting
Select Top 10 state,
	Count(*) as total_fatalities
From Projects.dbo.Fatality
Where description Like '%shooting%'
Group By state
Order By total_fatalities Desc;

-- Task#9: Calculates the total number of deaths caused by shooting each year
Select YEAR(incident_date) as Years,
	Count(*) as total_fatalities
From Projects.dbo.Fatality
Where description Like '%shooting%'
Group By YEAR(incident_date)
Order By total_fatalities Desc;

-- Task#10: Calculates the year-to-year percentage changes(Round it of to nearest whole number) in the number of fatalities for each incident year,
-- excluding the year 2022

With Tab1 as(
	Select *,
		YEAR(incident_date) as Years
	From Projects.dbo.Fatality
	Where YEAR(incident_date) != 2022
)
Select Years,
	COUNT(*) as total_fatalities,
	Round(Count(*)*100.0 / Sum(Count(*)) Over(),2) as Percentages
From Tab1
Group By Years
Order By total_fatalities Desc;
