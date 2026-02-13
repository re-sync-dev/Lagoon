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
local Network = require(ReplicatedStorage.Shared.Network)

local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

-- Main Module:
local MyService = {}

function MyService:Init()
	-- Remotes:
	-- Events:
	Network:CreateEvent("Greet")
	Network:AddMiddleware("Greet", {
		-- If defined the inbound function will be called before any connections or
		-- bindings receive the data.
		Inbound = function(Args: { any })
			local _Player: Player, Data: { Message: string } = table.unpack(Args)

			Data.Message ..= "world! "
		end,

		-- If defined the function will be called before anything is fired / invoked.
		Outbound = function(Args: { any })
			local _Player: Player, Data: { Message: string } = table.unpack(Args)

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
