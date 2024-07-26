--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Module.luau]:
		Exports the lagoon network trait for direct access.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Network = require(ReplicatedStorage.Shared.Network)

-- Main Module:
local Module = {}

function Module.Greet()
	Network:Fire("Greet", {
		Message = "Hello, ",
	})
end

function Module:Init()
	-- Remotes:
	-- Events:
	Network:WaitFor("Greet")
	Network:CreateEvent("Greet", {
		Inbound = function(Data: {
			Message: string,
		})
			Data.Message ..= "Client was here!"
		end,
	})

	-- Connections:
	Network:Connect("Greet", function(Data: {
		Message: string,
	})
		print(Data.Message)
	end)
end

return Module
