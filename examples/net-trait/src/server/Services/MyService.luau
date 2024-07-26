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

function MyService:Init()
	-- Remotes:
	-- Functions:
	self:CreateFunction("Ping")

	-- Bindings:
	self:Bind("Ping", function()
		return "Pong"
	end)
end

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Network) --> Using ':ApplyTrait' allows the service to implement the methods & properties of said trait.
