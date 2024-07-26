--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.client.luau]:
		Client side of the 'middleware' Lagoon example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Module = require(ReplicatedStorage.Shared.Module)

Module:Init()
Module.Greet()
