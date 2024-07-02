local Types = require(script.Parent.Parent.Types)
--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Base.luau]:
		Base class for traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
-- Private:
type TraitBase = Types.TraitBase

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
function Trait.new<T>(Module: T): T & TraitBase
	local UserData = newproxy(true)
	getmetatable(UserData).__index = function(_, Key: string)
		if Trait[Key] and not (Module :: any)[Key] then
			return Trait[Key]
		end

		return (Module :: any)[Key]
	end

	return UserData :: T & TraitBase
end

--[=[

	@within TraitBase
	@function Apply
	@param self S
	@param Module T
	
	Applies a traits method(s) and properties to the specified module.

	@return S & T

]=]
function Trait.Apply<S, T>(self: S, Module: T): S & T
	for Key, Value in getmetatable(self :: any).__index do
		(Module :: any)[Key] = Value
	end

	return Module :: any
end

return Trait
