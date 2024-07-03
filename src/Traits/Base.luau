--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Base.luau]:
		Base class for traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Types = require(script.Parent.Parent.Types)

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

	local Ref: any = Module

	if not Ref.Apply then
		-- If the trait wants to have a function that overrides a trait
		-- function that is not our problem :shrug:
		Ref.Apply = Trait.Apply
	end

	getmetatable(UserData).__index = Module

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
