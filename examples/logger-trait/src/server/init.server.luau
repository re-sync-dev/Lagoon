--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.server.luau]:
		Server side of the 'logger-trait' Lagoon example.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local MyService = require(script.Services.MyService)

-- Main:
MyService:Log("Debug/Info", "Hello, World!")
