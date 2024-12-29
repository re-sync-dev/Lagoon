--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[SecondService.luau]:
		Service example

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local SecondService = {}

-- Artificially increase the time it takes to load this module
task.wait(3)

return Lagoon.MakeService(SecondService)
