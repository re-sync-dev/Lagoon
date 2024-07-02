--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyService.luau]:
		Lagoon service with traits example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
local SharedTrait = require(ReplicatedStorage.Shared.SharedTrait)

-- Main Module:
local MyService = {}

function MyService.Hello()
	print("Hello, world!")
end

return Lagoon.MakeService(MyService):ApplyTrait(SharedTrait) --> Using ':ApplyTrait' allows the service to implement the methods & properties of said trait.
