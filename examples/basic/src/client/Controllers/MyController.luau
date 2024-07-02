--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyController.luau]:
		Basic Lagoon controller example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local MyController = {}

function MyController.Hello()
	print("Hello from a controller!")
end

return Lagoon.MakeController(MyController)
