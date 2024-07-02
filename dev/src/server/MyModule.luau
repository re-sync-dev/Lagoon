local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[MyModule.luau]:
	Dummy module for testing purposes
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]

-- Main Module:
local MyModule = {}
MyModule.Name = "Hi"


return Lagoon.Traits.Net:Apply(MyModule)