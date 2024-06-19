--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Network.lua]:
		An example of how Lagoon built-in NetTrait can be created.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Constants:
local IS_SERVER = RunService:IsServer()

-- Main Module:
local Network = {}

if IS_SERVER then
	return Lagoon.MakeService(Network):ApplyTrait(Lagoon.Traits.Net)
else
	return Lagoon.MakeController(Network):ApplyTrait(Lagoon.Traits.Net)
end
