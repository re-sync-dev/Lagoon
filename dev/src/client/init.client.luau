--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.client.luau]:
		Testing environment on the client.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

local MyController = require(script.Controllers.MyController)

MyController:Connect("Thing1", function(Response: string)
	print(Response)

	return
end)

MyController:Fire("Thing1", {
	Thing = 1,
	You = false,
	Your = "not real.",
})
