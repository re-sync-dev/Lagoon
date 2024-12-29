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

local MAXIMUM_SEARCH_DEPTH = 25 -- Nobody should need more than this

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
local function TimeCall(Func: (...any) -> any, ...)
	local Start = os.clock()

	local Args = { Func(...) }

	Args[#Args + 1] = os.clock() - Start

	return table.unpack(Args)
end

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
	@param ShouldTime boolean?

	Requires and initializes the provided modules.
	This function always returns the time in total it took to load the modules, however if `ShouldTime` is provded the second return value will have the time each module took to load.

	@return (number, Dictionary<number>)
]=]
function Lagoon.Load(List: Instance | { Instance }, ShouldTime: boolean?)
	local Modules: { Instance }

	if typeof(List) == "Instance" then
		Modules = List:GetChildren()
	else
		Modules = List
	end

	local LoadTimes = {}

	local function Load(List: { Instance }, Depth: number)
		if Depth > MAXIMUM_SEARCH_DEPTH then
			warn(`[Lagoon.Load]: Maximum search depth reached ({MAXIMUM_SEARCH_DEPTH})`)
			return
		end

		Depth += 1

		for _, Child in List do
			if Child:IsA("ModuleScript") then
				local Success: boolean, Result: any, Time: number = TimeCall(pcall, require, Child)

				if ShouldTime and Time then
					local AdjustedTime = math.max(math.floor(Time * 100_000) / 100_000, 0) -- Keeps enough precision times to be formatted as 100.12ms

					LoadTimes[`{Child.Parent and Child.Parent.Name .. "." or ""}{Child.Name}`] = AdjustedTime
				end

				if not Success then
					warn(`[Lagoon.Load]: Failed to require {Child.Name}: {Result}`)
					continue
				end

				if typeof(Result) == "table" and Result.Init then
					task.defer(Result.Init, Result)
				end
			elseif Child:IsA("Folder") then
				Load(Child:GetChildren(), Depth)
			else
				warn(
					`[Lagoon.Load]: Invalid object {Child:GetFullName()} ({Child.ClassName}), object must be of class ModuleScript/Folder`
				)
			end
		end
	end

	debug.setmemorycategory(`Lagoon.Load`)

	local Time: number = TimeCall(Load, Modules, 0)

	debug.resetmemorycategory()

	return Time, LoadTimes
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
