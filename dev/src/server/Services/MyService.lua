--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[MyService.lua]:
	Dummy service for testing purposes
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local MyService = {}
MyService.LogOptions = {
	Name = "MyService",
	Debug = true,
	Timestamp = false,
}

function MyService:Print()
	print("Hello World!")
end

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Net):ApplyTrait(Lagoon.Traits.Logger)
