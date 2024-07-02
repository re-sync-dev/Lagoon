--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyService.luau]:
		Basic Lagoon service example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local MyService = {}

function MyService.Hello()
	print("Hello, world!")
end

return Lagoon.MakeService(MyService)
