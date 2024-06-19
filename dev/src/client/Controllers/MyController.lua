--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[MyController.lua]:
	Dummy service for testing purposes
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local MyController = {}

function MyController:Print()
	print("Hello World!")
end

return Lagoon.MakeController(MyController):ApplyTrait(Lagoon.Traits.Net)
