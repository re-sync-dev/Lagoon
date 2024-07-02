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
function Trait.new<T>(Module: T)
	local UserData = newproxy(true)
	getmetatable(UserData).__index = Module

	return UserData :: T
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
