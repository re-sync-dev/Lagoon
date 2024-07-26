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
type Network = Types.Network
type Logger = Types.Logger

type Traits = {
	Net: Network, --> Backwards compatibility
	Network: Network,
	Logger: Logger,
}

-- Constants:
local REDIRECTS = {
	Net = "Network",
}

-- Variables:
local Cache = {} :: Traits

-- Main Module:
--[=[

	@class Traits
	Module containing references to built-in traits.

	**Built-in traits:**
	- [Network](/api/Network) is for networking either across the boundary or within it
	- [Logger](/api/Logger) is used for logging information in a production or development environment.
	- [TraitBase](/api/TraitBase) is the base class used for all traits.

]=]
local Traits = setmetatable({}, {
	__index = function(self: Traits, Key: string)
		if REDIRECTS[Key] then --> Used for backwards compatibility
			Key = REDIRECTS[Key]
		end

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
