


Select * 
From PortfolioProject..Nashvillehousing


--1.Number of Property on the basis of Land use

Select [Land Use],Count([Land Use])As PropertyCount
From PortfolioProject..Nashvillehousing
Group by [Land Use]
Order by 2 desc


--2. Number of Property on the basis of Grade

Select Grade,Count(Grade) As GradePropertyCount
From PortfolioProject..Nashvillehousing
Where Grade is not null
Group by [Grade]
Order by 2 desc


-- 3. ProfitMarginPercentage on Sales of the property

Alter Table  PortfolioProject..Nashvillehousing
Add  ProfitPercentage int

Update PortfolioProject..Nashvillehousing
Set ProfitPercentage = (([Sale Price]-[Total Value])/[Total Value])*100


Select [Land Use],[Owner Name],[PropertySplitAddress],[PropertySplitCity],[SaleDateConverted],[Total Value],[Sale Price],ProfitPercentage
--Where [Total Value] Is not null
From PortfolioProject..Nashvillehousing
Order by ProfitPercentage Desc




-- 4. ProfitMarginPercentage on Sales of the property by date

Select [SaleDateConverted],[Total Value],[Sale Price],ProfitPercentage
From PortfolioProject..Nashvillehousing
--Where [Total Value] Is not null
Order by  ProfitPercentage  Desc


--Select [Land Use],[Land Value],[Building Value],[Total Value],[Sale Price],ProfitPercentage
--From PortfolioProject..Nashvillehousing
--Order by 3

Select Year([SaleDateConverted]) As SaleYear  
From PortfolioProject..Nashvillehousing

Select * 
From PortfolioProject..Nashvillehousing

-- 5. Year of sale - Year of build of Property

Select [Land Use],[Owner Name],[Year Built],Year([SaleDateConverted]) As SaleYear ,Year([SaleDateConverted])-[Year Built] As PropertyYear
From PortfolioProject..Nashvillehousing


-- 6.Number of Property Sold As Vacant

Select [Sold As Vacant],Count([Sold As Vacant]) As PropertyCount
From  PortfolioProject..Nashvillehousing
Group by [Sold As Vacant]


