--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[init.server.lua]:
	Testing environment on the server.
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local MyService = require(script.Services.MyService)
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Init:
Lagoon.Load(script.Services)

-- Main:
MyService:Log("Debug/Info", "Hello, world!")
