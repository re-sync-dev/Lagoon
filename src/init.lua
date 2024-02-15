--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.lua]:
		Lagoon is a barebones typesafe framework that can be integrated anywhere.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Controller = require(script.Controller)
local Service = require(script.Service)
local Trait = require(script.Traits.Base)

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
	return Service.new(Module)
end

--[=[
	@within Lagoon
	@function MakeCotnroller
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
	return Controller.new(Module)
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

return Lagoon
