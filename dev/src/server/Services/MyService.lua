local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

local MyService = {}

function MyService:Print()
	print("Hello World!")
end

return Lagoon.MakeService(MyService)
