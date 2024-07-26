--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Network.luau]:
		Exports the lagoon network trait for direct access.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
return Lagoon.Traits.Network
