SELECT 
    ClimateExpFlag,
    AVG(ExpectedSellPricePerKg) AS AvgExpectedPricePerKg,
    COUNT(*) AS CropCount
FROM dbo.CropInventory
GROUP BY ClimateExpFlag;
