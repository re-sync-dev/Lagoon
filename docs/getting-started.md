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
[Traits](https://en.wikipedia.org/wiki/Trait_(computer_programming)#Rationale) is built around the concept of [Composition](https://en.wikipedia.org/wiki/Composition_over_inheritance). This means that we can define a trait with various functions and methods and share those functions and traits with another module without needing to copy + paste those functions into the module we want.

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

### Real World Example Of Traits
Maybe you want to print something in game maybe to catch a bug or just understand what's going on at a given point in time. In a situation like this you could use Lagoon's built-in trait module. It has support for debug logging as well as the roblox log contexts used in functions like [print](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals#print), [warn](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals#warn), and [error](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals#error).

First let's create our base module:
**MyModule.luau**
```lua
local MyModule = {}

function MyModule:Init()
	-- TODO: Log I <3 Code
end

return Lagoon.Wrap(MyModule)
```

Next lets apply Lagoon's logger trait to our module:
```lua
local Lagoon = require(Path.To.Lagoon)

local MyModule = {}

function MyModule:Init()
	-- TODO: Log I <3 Code!
end

return Lagoon.Wrap(MyModule):ApplyTrait(Lagoon.Traits.Logger)
```

Now that we've done that lets go ahead and log our phrase:
```lua
local Lagoon = require(Path.To.Lagoon)

local MyModule = {}

function MyModule:Init()
	self:Log("Info", "I <3 Code!")
end

return Lagoon.Wrap(MyModule):ApplyTrait(Lagoon.Traits.Logger)
```

In the output we'll see a message along the lines of `[MyModule.Init:7] I <3 Code!`. This shows us the name of the module, the function that called `:Log`, and the line `:Log` was called on.