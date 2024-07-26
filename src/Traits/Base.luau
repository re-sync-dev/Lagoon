--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Base.luau]:
		Base class for traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Main Module:
--[=[

	@class TraitBase
	Base class for traits.

]=]
local Trait = {}
Trait.__index = Trait

--[=[

	@within TraitBase
	@function new
	@param Module T
	Creates a new userdata to serve as a trait container.

	@return T

]=]
function Trait.new<T>(Module: T): T
	local UserData = newproxy(true)

	getmetatable(UserData).__index = Module

	return UserData :: T
end

return Trait
