---
sidebar_position: 3
---

# Using the Logger Trait
## What is it for?
The logger trait implements additional functionality for things like contextual debugging, showing more information like the timestamp or the script using the logger.

## Setting up LogOptions
LogOptions are used to modify the output message or to change how the message is shown. You can add your log options by something like this:
```lua
local MyService = {}
MySerivce.LogOptions = {
	Debug = false,
	Timestamp = false,
}

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Logger)
```

What matters is where we set the options:
```lua
LogOptions = {
	Debug = false,
	Timestamp = false,
}
```
In this snippet we define 2 options 'Debug' & 'Timestamp'. Debug is used to allow logs set in the debug context to be displayed in the output window. Timestamp on the other will show the time the log was sent.

## How do I use it?
The simplest most straight forward way is to just use the `:Log` method. This method takes in 2 arguments, the first is the `LogContext` which will be "Info", "Warn", or "Error" the second is the message to be displayed in the output window.

## Making Debug prints
You can make debug prints by adding "Debug/" before the LogContext. This will make the message show if 'Debug' is enabled.

## Usage Example
```lua
local MyService = {}
MySerivce.LogOptions = {
	Debug = true,
}

function MyService:Init()
	self:Log("Info", "Hello world!")
	self:Log("Warn", "Hello world but in orange!")
	self:Log("Debug/Info", "Hello world in using the Debug/Info log type")
end

return Lagoon.MakeService(MyService):ApplyTrait(Lagoon.Traits.Logger)
```