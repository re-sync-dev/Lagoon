--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Controller.luau]:
		Class for creating controllers with or without traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")

-- Types:
-- Private:
type Controller = {
	ApplyTrait: <S, T>(self: S, Trait: T) -> S & T,
}

-- Constants:
local IS_CLIENT = RunService:IsClient()

-- Functions:
local function SafeSetMetatable<S, T>(Table: S, Metatable: T): S & T
	return setmetatable(Table :: any, Metatable :: any)
end

-- Main Module:
--[=[

	@class Controller
	Class for creating controllers with or without traits.

]=]
local Controller = {}
Controller.__index = Controller

--[=[

	@within Controller
	@function new
	@param Module S
	@ignore

	Constructs a new controller object.

	@return S & Controller

]=]
function Controller.new<S, T>(Module: S)
	if not IS_CLIENT then
		error("[Lagoon.Controller]: Cannot create controllers on the server.")
		return {} :: Controller & S
	end

	local self = SafeSetMetatable(Module, Controller :: Controller)

	return self
end

--[=[

	@within Controller
	@method ApplyTrait
	@param Trait T

	Applies a traits method(s) and properties to the specified controller.

	@return S & T

]=]
function Controller.ApplyTrait<S, T>(self: S, Trait: T): S & T
	return (Trait :: any):Apply(self)
end

return Controller
