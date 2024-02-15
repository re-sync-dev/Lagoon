--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[SharedTrait.lua]:
		Example of what a shared trait using Lagoon would look like.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local SharedTrait = {}

function SharedTrait.SharedHello()
	print("Hello from your shared trait!")
end

return Lagoon.MakeTrait(SharedTrait) --> To turn your module into a trait you need to call 'Lagoon.MakeTrait'
