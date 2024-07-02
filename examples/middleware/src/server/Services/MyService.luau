--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[MyService.luau]:
		Service example

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
local Network = require(ReplicatedStorage.Shared.Network)

-- Main Module:
local MyService = {}

function MyService:Init()
	-- Remotes:
	-- Events:
	Network:CreateEvent("Greet", {
		-- If defined the inbound function will be called before any connections or
		-- bindings receive the data.
		Inbound = function(
			_: Player,
			Data: {
				Message: string,
			}
		)
			Data.Message ..= "world! "
		end,

		-- If defined the function will be called before anything is fired / invoked.
		Outbound = function(
			_: Player,
			Data: {
				Message: string,
			}
		)
			Data.Message ..= "Server was here! "
		end,
	})

	-- Connections:
	Network:Connect("Greet", function(
		Player: Player,
		Data: {
			Message: string,
		}
	)
		Network:Fire("Greet", Player, Data)
	end)
end

return Lagoon.MakeService(MyService)
