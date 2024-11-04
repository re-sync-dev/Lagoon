--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.luau]:
		Lagoon is a barebones typesafe framework that can be integrated anywhere.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")

-- Modules:
local BaseModule = require(script.BaseModule)

-- Constants:
local IS_SERVER = RunService:IsServer()
local IS_CLIENT = RunService:IsClient()

-- Variables:
local Modules = {}

-- Types:
-- Private:
type Service = { --> Type alias for BaseModule
	Name: string,
	ApplyTrait: <S, T>(self: S, Trait: T) -> S & T,
}

type Controller = { --> Type alias for BaseModule
	Name: string,
	ApplyTrait: <S, T>(self: S, Trait: T) -> S & T,
}

-- Functions:
-- Main Module:
--[=[

	@class Lagoon
	Lagoon is a barebones typesafe framework that can be integrated anywhere.

]=]
local Lagoon = {}
Lagoon.Traits = require(script.Traits)

--[=[

	@within Lagoon
	@function MakeService
	@param Module T
	Takes in a table for the 'Module' parameter and wraps the module with a Lagoon Service.

	**Usage:**   
	**MyService.lua**
	```lua
	-- This is in a ModuleScript
	local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

	local MyService = {}
	MyService.IsService = true

	function MyService.PrintFromServer()
		print("Hello from the server!")
	end

	return Lagoon.MakeService(MyService)
	```

	@return Service & T

]=]
function Lagoon.MakeService<T>(Module: T): Service & T
	if not IS_SERVER then
		error("[Lagoon]: MakeService can only be called from the server.")
	end

	return Lagoon.Wrap(Module)
end

--[=[

	@within Lagoon
	@function MakeController
	@param Module T
	Takes in a table for the 'Module' parameter and wraps the module with a Lagoon Controller.

	**Usage:**   
	**MyController.lua**
	```lua
	-- This is in a ModuleScript
	local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

	local MyController = {}
	MyController.IsController = true

	function MyController.PrintFromClient()
		print("Hello from the client!")
	end

	return Lagoon.MakeController(MyController)
	```

	@return Controller & T

]=]
function Lagoon.MakeController<T>(Module: T): Controller & T
	if not IS_CLIENT then
		error("[Lagoon]: MakeController can only be called from the client.")
	end

	return Lagoon.Wrap(Module)
end

--[=[

	@within Lagoon
	@function Wrap
	@param Module T

	Integrates a module into the lagoon environment

	@return Module & T

]=]
function Lagoon.Wrap<T>(Module: T)
	local Object = BaseModule.new(Module)

	Modules[Object.Name] = Object

	return Object
end

--[=[

	@within Lagoon
	@function Load
	@param List Instance | {Instance}

	Requires and initializes the Parent's children.

]=]
function Lagoon.Load(List: Instance | { Instance })
	local Modules: { Instance }

	if typeof(List) == "Instance" then
		Modules = List:GetChildren()
	else
		Modules = List
	end

	debug.setmemorycategory(`Lagoon.Load`)

	for _, Child in Modules do
		if not Child:IsA("ModuleScript") then
			continue
		end

		local Success, Result = pcall(require, Child)

		if not Success then
			warn(`[Lagoon.Load]: Failed to require {Child.Name}: {Result}`)
			continue
		end

		if typeof(Result) == "table" and Result.Init then
			task.defer(Result.Init, Result)
		end
	end

	debug.resetmemorycategory()
end

--[=[

	@within Lagoon
	@function Get
	@param Name string

	:::warning
	Function provides no typesafety.
	:::

	@return any

]=]
function Lagoon.Get(Name: string): any
	return Modules[Name]
end

return Lagoon
