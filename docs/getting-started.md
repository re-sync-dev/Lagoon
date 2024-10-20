---
sidebar_position: 2
---

# Getting Started
## Installation Guides
- [Studio](/docs/installation/studio)
- [Wally](/docs/installation/wally)

## Steps to Success
### Creating your first Service
In the context of Lagoon a service is a module required on the server, and can be defined using `Lagoon.MakeService` like in the example below:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

local MyService = {}

function MyService.Print()
	print("Hello from the server!")
end

return Lagoon.MakeService(MyService)
```

### Creating a controller
On the other hand we have controllers which you may have expected are modules required on the client. Controllers can be created by calling `Lagoon.MakeController` like in the example:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

local MyController = {}

function MyController.Print()
	print("Hello from the client!")
end

return Lagoon.MakeService(MyController)
```

### Understanding Traits
[Traits](https://en.wikipedia.org/wiki/Trait_(computer_programming)#Rationale) are essentially modules that contain methods, functions, and fields that can be used by Services / Controllers. This reduces the need to copy + paste code and allows necessary abstractions to occur.

In this example we create a Trait called 'MyCustomTrait' that has a function 'Sum' and takes in 2 arguments of type 'number'
**MyCustomTrait.luau**
```lua
-- This is in a ModuleScript
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

local MyCustomTrait = {}

function MyCustomTrait.Sum(a: number, b: number)
	return a + b
end

return Lagoon.MakeTrait(MyCustomTrait)
```

We can access our 'Sum' function by applying the trait to something like a Service.
**MyService.luau**
```lua
-- This is in a ModuleScript
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
local MyCustomTrait = require(Path.To.MyCustomTrait)

local MyService = {}
MyService.A = 1
MyService.B = 2

-- self = MyService
function MyService:Print()
	-- We now have access to self.Sum due to inheriting 'MyCustomTrait'
	print(`Sum: {self.Sum(self.A, self.B)}`)
end

return Lagoon.MakeController(MyService):ApplyTrait(MyCustomTrait)
```
In the code above we use `:ApplyTrait` which iterates over the trait and essentially merges `MyService` and `MyCustomTrait` giving access to our 'Sum' function.