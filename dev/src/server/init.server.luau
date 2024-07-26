--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[init.server.luau]:
	Testing environment on the server.
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local MyService = require(script.MyService)
local Network = require(ReplicatedStorage.Shared.Network)

-- Main:
MyService:Init()

do --> Standard remotes
	Network:CreateEvent("Event")

	Network:Connect("Event", function(Player: Player)
		Network:Fire("Event", Player, "Event")
	end)

	Network:CreateFunction("Function")

	Network:Bind("Function", function(Player: Player)
		return "Function"
	end)
end

do --> Standard remote middleware
	local function AddMiddlwareSuffix(_, Message: { string })
		table.insert(Message, "Middleware")
	end

	Network:CreateEvent("EventMiddleware")

	Network:AddMiddleware("EventMiddleware", {
		Outbound = AddMiddlwareSuffix,
	})

	Network:Connect("EventMiddleware", function(Player: Player, Message: { string })
		Network:Fire("EventMiddleware", Player, Message)
	end)

	Network:CreateFunction("FunctionMiddleware")

	Network:AddMiddleware("FunctionMiddleware", {
		Inbound = AddMiddlwareSuffix,
	})

	Network:Bind("FunctionMiddleware", function(Player: Player, Message: { string })
		return Message
	end)
end

do --> Serialized remotes
	Network:CreateEvent("EventSerialized").Ref:SetAttribute("Serialize", true)

	Network:Connect("EventSerialized", function(Player: Player, Message: string)
		Network:Fire("EventSerialized", Player, "Event" .. Message)
	end)

	Network:CreateFunction("FunctionSerialized").Ref:SetAttribute("Serialize", true)

	Network:Bind("FunctionSerialized", function(Player: Player, Message: string)
		return "Function" .. Message
	end)
end

do --> Serialized remote middleware
	local function AddMiddlwareSuffix(_, Message: { string })
		table.insert(Message, "Middleware")
	end

	Network:CreateEvent("EventSerializedMiddleware").Ref:SetAttribute("Serialize", true)

	Network:AddMiddleware("EventSerializedMiddleware", {
		Outbound = AddMiddlwareSuffix,
	})

	Network:Connect("EventSerializedMiddleware", function(Player: Player, Message: { string })
		table.insert(Message, 1, "Event")

		Network:Fire("EventSerializedMiddleware", Player, Message)
	end)

	Network:CreateFunction("FunctionSerializedMiddleware").Ref:SetAttribute("Serialize", true)

	Network:AddMiddleware("FunctionSerializedMiddleware", {
		Inbound = AddMiddlwareSuffix,
	})

	Network:Bind("FunctionSerializedMiddleware", function(Player: Player, Message: { string })
		table.insert(Message, 1, "Function")

		return Message
	end)
end

do --> Fire All
	Network:CreateEvent("FireAll")

	Network:Connect("FireAll", function(_)
		Network:Fire("FireAll", "FireAll")
	end)
end

do --> Serialized Fire All
	Network:CreateEvent("SerializedFireAll")

	Network:Connect("SerializedFireAll", function(_, Prefix: string)
		Network:Fire("SerializedFireAll", Prefix .. "FireAll")
	end)
end
