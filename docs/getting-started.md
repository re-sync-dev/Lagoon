---
sidebar_position: 2
---

# Getting Started
## Installation Guides
- [Studio](/docs/installation/studio)
- [Wally](/docs/installation/wally)

## Steps to Success
### Creating your first Service
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
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)

local MyController = {}

function MyController.Print()
	print("Hello from the client!")
end

return Lagoon.MakeService(MyController)
```
### Adding traits to a service
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

**MyService.lua**
```lua
-- This is in a ModuleScript
local Lagoon = require(ReplicatedStorage.Packages.Lagoon)
local MyCustomTrait = require(Path.To.MyCustomTrait)

local MyService = {}
MyService.A = 1
MyService.B = 2

function MyService:Print()
	print(`Sum: {self.Sum(self.A, self.B)}`)
end

return Lagoon.MakeController(MyService):ApplyTrait(MyCustomTrait)
```