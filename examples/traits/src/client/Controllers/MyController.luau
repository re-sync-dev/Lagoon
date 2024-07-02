--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyController.luau]:
		Lagoon controller with traits example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
local SharedTrait = require(ReplicatedStorage.Shared.SharedTrait)

-- Main Module:
local MyController = {}

function MyController.Hello()
	print("Hello from a controller!")
end

return Lagoon.MakeController(MyController):ApplyTrait(SharedTrait) --> Using ':ApplyTrait' allows the controller to implement the methods & properties of said trait.
