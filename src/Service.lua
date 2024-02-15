--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Service.lua]:
		Class for creating services with or without traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")

-- Types:
-- Private:
type Service = {
	ApplyTrait: <S, T>(self: S, Trait: T) -> S & T,
}

-- Constants:
local IS_SERVER = RunService:IsServer()

-- Functions:
local function SafeSetMetatable<S, T>(Table: S, Metatable: T): S & T
	return setmetatable(Table :: any, Metatable :: any)
end

-- Main Module:
--[=[
	@class Service
	Class for creating services with or without traits.
]=]
local Service = {}
Service.__index = Service

--[=[
	@within Service
	@function new
	@param Module S
	@ignore

	Constructs a new Service object.

	@return S & Service
]=]
function Service.new<S, T>(Module: S)
	if not IS_SERVER then
		error("[Lagoon.Service]: Cannot create services on the client.")
		return {} :: Service & S
	end

	local self = SafeSetMetatable(Module, Service :: Service)

	return self
end

--[=[
	@within Service
	@method ApplyTrait
	@param Trait T

	Applies a traits method(s) and properties to the specified service.

	@return S & T
]=]
function Service.ApplyTrait<S, T>(self: S, Trait: T): S & T
	for Key, Value in getmetatable(Trait :: any).__index do
		if Key == "Name" then
			continue
		end

		(self :: any)[Key] = Value
	end

	return self :: any
end

return Service
