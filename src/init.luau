--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.luau]:
		Lagoon is a barebones typesafe framework that can be integrated anywhere.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Service = require(script.Service)
local Trait = require(script.Traits.Base)
local Controller = require(script.Controller)

-- Variables:
local Modules = {}

-- Functions:
--[=[

	@within Lagoon
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

]=]
function Lagoon.MakeService<T>(Module: T)
	local Name = CollectName()
	local NewService = Service.new(Module)

	Modules[Name] = NewService

	if NewService.Name == nil then
		NewService.Name = Name
	end

	return NewService
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

]=]
function Lagoon.MakeController<T>(Module: T)
	local Name = CollectName()
	local NewController = Controller.new(Module)

	Modules[Name] = NewController

	if NewController.Name == nil then
		NewController.Name = Name
	end

	return NewController
end

--[=[

	@within Lagoon
	@function MakeTrait
	@param Module T
	Creates a Trait using the module parameter, the created trait can be applied to
	services/controllers using `Service:ApplyTrait(MyCustomTrait)` or
	`Controller:ApplyTrait(MyCustomTrait)`

	**Usage:**   
	**MyCustomTrait.lua**
	```lua
	-- This is in a ModuleScript
	local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

	local MyCustomTrait = {}

	function MyCustomTrait.Sum(a: number, b: number)
		return a + b
	end

	return Lagoon.MakeTrait(MyCustomTrait)
	```

	**MyController.lua**
	```lua
	-- This is in a ModuleScript
	local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
	local MyCustomTrait = require(Path.To.MyCustomTrait)

	local MyController = {}
	MyController.IsController = true

	function MyController.PrintFromClient()
		print("Hello from the client!")
	end

	return Lagoon.MakeController(MyController):ApplyTrait(MyCustomTrait)
	```

]=]
function Lagoon.MakeTrait<T>(Module: T)
	return Trait.new(Module)
end

--[=[

	@within Lagoon
	@function Load
	@param List {Instance}

	Requires and initializes the Parent's children.

]=]
function Lagoon.Load(List: {Instance})
	debug.setmemorycategory("LagoonLoad")

	for _, Child in List do
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
