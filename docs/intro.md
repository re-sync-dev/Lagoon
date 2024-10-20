---
sidebar_position: 1
---

# About
Lagoon is a barebones framework that can be added anywhere with low requirements for integration. Usage examples can be found [here](https://github.com/re-sync-dev/Lagoon/releases).

## Why Lagoon?
### Simplicity
Lagoon is only as complex as you make it, due to it's barebones nature the complexity of the framework scales with your code!

### Non Intrusive
Lagoon by design does not require complete integration into your project, and will function without using all the features.

### Extensible
Even with the few things Lagoon does provide, Lagoon makes it a point to give developers as much freedom over their systems as possible.

## What are Services / Controllers?
In the context of Lagoon they are just modules that run in the context of the server or client. Services are modules ran on the server and Controllers are modules ran on the client.

## Do I Need to wrap everything in the Lagoon API???
Put simply no, if you have a module that does not need to directly access the lagoon framework you can declare the module the same as if you weren't using Lagoon at all.

If you still want to have the benefit of runtime initialization you can just add an `Init` method to the module and `Lagoon.Load` will treat it the same.

Example:
```lua
-- Modules/MyModule.luau:
local Module = {}

function Module:Init()
	print("This module got initialized as well!")
end

return Module

-- init.server.luau:
Lagoon.Load(script.Modules)
```

:::info
The best time to use a trait is when you need to have methods, properties or a behavior accessible in multiple locations.
:::

## Where can I learn about traits?
A brief explanation can be found [here](/Lagoon/docs/getting-started#understanding-traits)