--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[BaseModule.luau]:
		Base class for lagoon related modules

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
-- Private:
type Module = {
	Name: string,
	ApplyTrait: <S, T>(self: S, Trait: T) -> S & T,
}

-- Functions:
--[=[

	@within BaseModule
	@function SafeSetMetatable
	@ignore

	Prevents type conflicts from using setmetatable and setting the table and metatable as any

	@return string

]=]
local function SafeSetMetatable<S, T>(Table: S, Metatable: T): S & T
	return setmetatable(Table :: any, Metatable :: any)
end

--[=[

	@within BaseModule
	@function CollectName
	@ignore

	Uses 'getfenv' to get the name of then script that called the function

	@return string

]=]
local function CollectName(): string
	local GetFenv = getfenv
	local Env = GetFenv(0)

	return Env.script.Name
end

-- Main Module:
--[=[

	@class BaseModule
	@ignore
	Base class for lagoon related modules

]=]
local BaseModule = {}
BaseModule.__index = BaseModule

--[=[

	@within BaseModule
	@function new
	@param Module S
	@ignore

	Constructs a new Module object.

	@return Module & S

]=]
function BaseModule.new<S, T>(Module: S): Module & S
	local self = SafeSetMetatable(Module, BaseModule)

	if not self.Name then
		self.Name = CollectName()
	end

	return self
end

--[=[

	@within BaseModule
	@method ApplyTrait
	@param Trait T

	Applies a traits method(s) and properties to the specified module.

	@return S & T

]=]
function BaseModule.ApplyTrait<S, T>(self: S, Trait: T): S & T
	local RetypedSelf: any = self

	for Key, Value in Trait :: any do
		if RetypedSelf[Key] then
			warn(`[{RetypedSelf.Name}]: Trait key '{Key}' is overlapping with another key`)
		end

		RetypedSelf[Key] = Value
	end

	return RetypedSelf
end

return BaseModule
