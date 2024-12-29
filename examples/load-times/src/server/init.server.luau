--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.server.luau]:
		Server side of the 'basic' Lagoon example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main:
local TTL, Report = Lagoon.Load(script.Services)

print(`[Server]: Loaded modules in {string.format("%.2fms", TTL * 1000)}`)

for Name, Time in Report do
	print(`{Name}: {string.format("%.2fms", Time * 1000)}`)
end
