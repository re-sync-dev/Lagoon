--[==[
	
	Copyright (C) Re-Sync - All Rights Reserved
	
	[init.server.lua]:
	Testing environment on the server.
	
	[Author(s)]:
	Vyon - https://github.com/Vyon
	
--]==]
local MyService = require(script.Services.MyService)

MyService:CreateEvent("Thing1", {
	Inbound = function(...)
		print(`Inbound:`, ...)
	end,
	Outbound = function(...)
		print(`Outbound:`, ...)
	end,
}):SetAttribute("ShouldSerialize", true)

MyService:Connect("Thing1", function(Data)
	print("Message received.", Data)
end)
