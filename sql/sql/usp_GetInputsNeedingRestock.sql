CREATE OR ALTER PROCEDURE dbo.usp_GetInputsNeedingRestock
AS
BEGIN
    SELECT 
        InputID,
        InputName,
        QuantityUnits,
        ReorderThreshold,
        CASE WHEN QuantityUnits <= ReorderThreshold THEN 'RESTOCK' ELSE 'OK' END AS Status
    FROM dbo.FarmInput
    WHERE QuantityUnits <= ReorderThreshold
    ORDER BY QuantityUnits ASC;
END;
