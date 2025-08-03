INSERT INTO dbo.CropInventory (CropID, CropName, Variety, QuantityKg, HarvestDate, ClimateExpFlag, ExpectedSellPricePerKg) VALUES
('MAIZE001', 'Maize', 'Hybrid', 1000.50, '2025-07-10', 1, 120.00),
('MAIZE002', 'Maize', 'Local', 850.00, '2025-07-12', 0, 105.00),
('SORGHUM01','Sorghum','Improved', 600.25, '2025-07-08', 1, 95.00);

INSERT INTO dbo.FarmInput (InputID, InputName, QuantityUnits, UnitType, ReorderThreshold) VALUES
('FERT_NPK', 'NPK Fertilizer', 8, 'Bag', 10),
('SEED_MAIZE', 'Maize Seed', 50, 'Bag', 20);
