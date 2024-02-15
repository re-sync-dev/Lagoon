--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyService.lua]:
		Lagoon service with traits example.

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
	self:CreateRemote("Ping", "RemoteFunction")
	self:Bind("Ping", function()
		return "Pong"
	end)
end

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Net) --> Using ':ApplyTrait' allows the service to implement the methods & properties of said trait.
