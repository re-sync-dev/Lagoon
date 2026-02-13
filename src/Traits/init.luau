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
	Network: Network,
	Logger: Logger,
}

-- Main Module:
--[=[

	@class Traits
	Module containing references to built-in traits.

	**Built-in traits:**
	- [Network](/api/Network) is for networking either across the boundary or within it
	- [Logger](/api/Logger) is used for logging information in a production or development environment.

]=]
local Traits = setmetatable({}, {
	__index = function(self: Traits, Key: string)
		if not rawget(self, Key) then
			local TraitModule = script:FindFirstChild(Key)

			if not TraitModule then
				return
			end

			rawset(self, Key, (require)(TraitModule))
		end

		return rawget(self, Key)
	end,
})

return (Traits :: any) :: Traits -- The types are definitely related
