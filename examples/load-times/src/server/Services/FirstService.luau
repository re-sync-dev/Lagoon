--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[FirstService.luau]:
		Service example

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local FirstService = {}

function FirstService.Hello()
	print("Hello, world!")
end

return Lagoon.MakeService(FirstService)
