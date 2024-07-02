--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.luau]:
		Module containing references to built-in traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Types = require(script.Parent.Types)

-- Types:
-- Private:
type Net = Types.Net
type Logger = Types.Logger

type Traits = {
	Net: Net,
	Logger: Logger,
}

-- Variables:
local Cache = {} :: Traits

-- Main Module:
--[=[

	@class Traits
	Module containing references to built-in traits.

	**Built-in traits:**
	- [Net](/api/NetTrait) is for networking either across the boundary or within it
	- [Logger](/api/Logger) is used for logging information in a production or development environment.

]=]
local Traits = setmetatable({}, {
	__index = function(self: Traits, Key: string)
		if not Cache[Key] then
			local TraitModule = script:FindFirstChild(Key)

			if not TraitModule then
				return
			end

			Cache[Key] = require(TraitModule)
		end

		return Cache[Key]
	end,
})

return Traits :: Traits
