--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Module.lua]:
		An example of a module that use a Network that is not related to Lagoon

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Network = require(ReplicatedStorage.Shared.Network)

-- Main Module:
local Module = {}

function Module.Ping()
	Network:WaitFor("Ping") --> Yield the current thread until the 'Ping' remote exists.

	local Start = os.time()

	Network:Invoke("Ping")

	warn(`Ping completed in {math.floor((os.time() - Start) * 1000)}ms`)
end

return Module
