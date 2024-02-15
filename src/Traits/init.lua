--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.lua]:
		Module containing references to built-in traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Main Module:
--[=[

	@class Traits
	Module containing references to built-in traits.

	**Built-in traits:**
	- [Net](/api/NetTrait) is for networking either across the boundary or within it

]=]
local Traits = {}
Traits.Net = require(script.Net)

return Traits
