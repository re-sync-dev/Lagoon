---
sidebar_position: 4
---

# Using the Network Trait
## What is it for?
The network trait is used to simplify networking on the client and server by creating a straight forward API

## Creating a Remote
Pretty straight forward you just take the suffix of the instance for example the 'Event' part of RemoteEvent or the 'Function' part of [RemoteFunction](https://create.roblox.com/docs/reference/engine/classes/RemoteFunction) and put 'Create' infront of it.

Example of remote creation:
```lua
Network:CreateEvent("MyRemoteEvent") --> RemoteEvent
Network:CreateFunction("MyRemoteFunction") --> RemoteFunction
```

We can also create unreliable remote events utiling the same method:
```lua
Network:CreateEvent("MyUnreliableRemoteEvent", true) --> UnreliableRemoteEvent
```

## Connections & Bindings
**Connections** simply put is the association between a given RemoteEvent/Signal and a function that can occur many times. This association in the context of normal Roblox signals is called an [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection).

Using this information we can call the `:Connect` method to associate a callback with an Event like so:

```lua
-- Server.luau:
Network:Connect("Say", function(Player: Player, Message: string)
	print(`{Player.Name} said: '{Message}'`)
end)

-- Client.luau:
Network:Fire("Hello, world!")
```

Not only can you associate the callback to the Event but you can also dissociate them using the return connection's `:Disconnect` method:

```lua
local Connection = Network:Connect("Say", function(Player: Player, Message: string)
	print(`{Player.Name} said: {Message}`)
end)

task.wait(3)

Connection:Disconnect() --> Removes the association
Connection = nil --> Dereference the dead connection so it can be garbage collected
```

**Bindings** on the other hand are a bit different, there can only ever be one callback associated with the [RemoteFunction](https://create.roblox.com/docs/reference/engine/classes/RemoteFunction). While the work similarly there are some key differences between the two, for example instead of returning an [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection) `:Bind` returns a function that unbinds the callback when called.

Let's try creating a binding that returns a boolean true if the player was able to start the trade and false if the trade could not be started:
```lua
-- Server.luau:
Network:Bind("Trade", function(Player: Player, OtherPlayer: Player)
	-- Is the caller in a trade:
	if Player:GetAttribute("InTrade") then
		return false
	end

	-- Is the other player in a trade:
	if OtherPlayer:GetAttribute("InTrade") then
		return false
	end

	-- Do something to start the trade

	return true
end)

-- Client.luau:
Network:Invoke("Trade", Players.VyonEXE) --> That's me :D
```
