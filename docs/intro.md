---
sidebar_position: 1
---

# About
Lagoon is a barebones framework that can be added anywhere with low integration requirements. Usage examples can be found [here](https://github.com/re-sync-dev/Lagoon/releases).

## Why Lagoon?
### Simplicity
Lagoon is only as complex as you make it, due to it's barebones nature the complexity of the framework scales with your code!

### Non Intrusive
Lagoon by design does not require complete integration into your project, and will function without using all the features.

### Extensible
Even with the few things Lagoon does provide, Lagoon makes it a point to give developers as much freedom over their systems as possible.

## What are Services / Controllers?
In the context of Lagoon they are just modules that are run in different contexts. For example Services conventionally run on the server while on the other hand Controllers are typically ran on the client. Ultimately however under the hood of both `.MakeService` and `.MakeController` they just call `.Wrap` after checking the run context meaning they do the same thing.

## Do I Need To Completely Rewrite My Project With Lagoon?
Put simply no, if you have a module that doesn't need to directly access lagoon a feature like traits for example you can declare the module the same as if you weren't using Lagoon at all.

If you still want to have the benefit of runtime initialization you'd only need to add an `:Init` method to the module and `Lagoon.Load` will treat it the same as any other module.

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

## Inheritance VS Composition
Lagoon's core design is based on the principle that everything related to it should be barebones and simple. [Inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)) famously goes against that philosophy in many cases by creating sometimes very large trees while trees do vary the concept remains the same. The branches CAN tangle which is why Lagoon uses [Composition](https://en.wikipedia.org/wiki/Composition_over_inheritance) in the first place, in short Lagoon aims to present Composition in a digestible format.

:::info
The best time to use a trait is when you want to share functions and methods across multiple modules or classes
:::

## Where can I learn about traits?
A brief explanation can be found [here](/Lagoon/docs/getting-started#understanding-traits)