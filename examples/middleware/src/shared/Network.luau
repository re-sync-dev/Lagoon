--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Network.luau]:
		An example of how Lagoon built-in Network can be created.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
return Lagoon.Traits.Network
