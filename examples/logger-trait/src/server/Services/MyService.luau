--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyService.luau]:
		Lagoon service with trait.

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
	Debug = true,
}

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Logger) --> Using ':ApplyTrait' allows the service to implement the methods & properties of said trait.
