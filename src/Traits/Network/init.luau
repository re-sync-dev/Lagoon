--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Network.luau]:
		Used for networking either across the client -> server boundary or across scripts using Signals.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Folders:
local ProjectRoot = script.Parent.Parent
local Packages = ProjectRoot:FindFirstChild("Packages") or ProjectRoot.Parent

-- Modules:
local JSON = require(script.JSON)
local Trait = require(script.Parent.Base)
local Serializer = require(script.Serializer)

local Types = require(ProjectRoot.Types)

local Signal = require(Packages.Signal)

-- Types:
-- Generic:
type Array<T> = Types.Array<T>
type Dictionary<T> = Types.Dictionary<T>

type Signal = Types.Signal<...any>
type Connection = Types.Connection

-- Private:
--[=[

	@within Network
	@interface MiddlewareEntry
	.Inbound Array<MiddlewareCallback>,
	.Outbound Array<MiddlewareCallback>,

]=]
type MiddlewareEntry = Types.MiddlewareEntry

--[=[

	@within Network
	@type MiddlewareCallback (...any) -> boolean?

]=]
type MiddlewareCallback = Types.MiddlewareCallback

--[=[

	@within Network
	@interface NetworkPoolItem<T>
	.Connection RBXScriptConnection?,
	.Handlers Array<MiddlwareCallback>,
	.IsAttached boolean,
	.Middleware MiddlewareEntry,
	.Ref T

]=]
type PoolItem<T> = Types.NetworkPoolItem<T>
type Middleware = Types.Middleware

type Network = Types.Network

-- Constants:
local IS_SERVER = RunService:IsServer()
local DEFAULT_TIMEOUT = 5

-- Locals:
local Remotes: Folder = ReplicatedStorage:FindFirstChild("Remotes")

-- Functions:
local function CreatePoolItem<T>(Ref: T): PoolItem<T>
	return {
		IsAttached = false,
		Connection = nil,
		Middleware = {
			Inbound = {},
			Outbound = {},
		},
		Ref = Ref,
		Handlers = {},
	}
end

local function CreatePool()
	local Pool = {}

	for _, Child in Remotes:GetChildren() do
		Pool[Child.Name] = CreatePoolItem(Child)
	end

	return Pool
end

local function ProcessMiddleware(MiddlewareHandlers: Array<MiddlewareCallback>, ...: any)
	for _, Handler in MiddlewareHandlers do
		local ShouldCancel = Handler(...)

		if ShouldCancel == true then
			return
		end
	end

	return true
end

-- Main Module:
--[=[

	@class Network
	Used for networking either across the client -> server boundary or across scripts using Signals.

	Inherits from [TraitBase](/api/TraitBase)

]=]
local Network = {} :: Network

--[=[

	@within Network
	@prop _Pool Dictionary<NetworkPoolItem<RemoteEvent | RemoteFunction | Signal<any>>>
	@readonly
	@private

]=]

--[=[

	@within Network
	@prop Serializer Serializer

]=]
Network.Serializer = Serializer

--[=[

	@within Network
	@prop JSON JSON

]=]
Network.JSON = JSON

--[=[

	@within Network
	@method CreateSignal
	@param Name string

	Appends a signal with the given name to the net pool.

	@return PoolItem<Signal>

]=]
function Network:CreateSignal(Name: string)
	local Item = self._Pool[Name]

	if Item then
		return Item
	end

	self._Pool[Name] = CreatePoolItem(Signal.new())

	return self._Pool[Name]
end

--[=[

	@within Network
	@method CreateEvent
	@param Name string
	@param IsUnreliable: boolean?

	Appends a RemoteEvent with the given name to the net pool.

	@return PoolItem<RemoteEvent>

]=]
function Network:CreateEvent(Name: string, IsUnreliable: boolean?): PoolItem<RemoteEvent>
	local Item = self._Pool[Name]

	if Item then
		return Item
	end

	local RemoteEvent: RemoteEvent

	if IsUnreliable then
		RemoteEvent = Instance.new("UnreliableRemoteEvent") :: any
	else
		RemoteEvent = Instance.new("RemoteEvent")
	end

	RemoteEvent.Name = Name
	RemoteEvent.Parent = Remotes

	self._Pool[Name] = CreatePoolItem(RemoteEvent)

	return self._Pool[Name]
end

--[=[

	@within Network
	@method CreateFunction
	@param Name string

	Appends a RemoteFunction with the given name to the net pool.

	@return RemoteFunction

]=]
function Network:CreateFunction(Name: string): PoolItem<RemoteFunction>
	local Item = self._Pool[Name]

	if Item then
		return Item
	end

	local RemoteFunction: RemoteFunction = Instance.new("RemoteFunction")

	RemoteFunction.Name = Name
	RemoteFunction.Parent = Remotes

	self._Pool[Name] = CreatePoolItem(RemoteFunction)

	return self._Pool[Name]
end

--[=[

	@within Network
	@method WaitFor
	@param Name string
	@param Timeout number?

	@return NetworkPoolItem<RemoteEvent | RemoteFunction | Signal<any>>?

]=]
function Network:WaitFor(Name: string, Timeout: number?)
	local Time = Timeout or DEFAULT_TIMEOUT
	local Result = self._Pool[Name]

	if Result then
		return Result
	end

	repeat
		local Remote = Remotes:FindFirstChild(Name)

		if not Result and Remote then
			Result = Remote
			self._Pool[Remote.Name] = CreatePoolItem(Remote)
		end

		Time -= 0.1
		task.wait(0.1)
	until Result or Time <= 0

	return Result
end

--[=[

	@within Network
	@method AddMiddleware
	@param Name string
	@param ... Middleware

]=]
function Network:AddMiddleware(Name: string, ...: Middleware)
	local Item: PoolItem<any> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	local List = { ... }

	for _, Handlers in List do
		if Handlers.Inbound then
			table.insert(Item.Middleware.Inbound, Handlers.Inbound)
		end

		if Handlers.Outbound then
			table.insert(Item.Middleware.Outbound, Handlers.Outbound)
		end
	end
end

--[=[

	@within Network
	@method Connect
	@param Name string
	@param Callback (...any) -> ()

	Connects a callback function to a Signal or RemoteEvent

	@return RBXScriptConnection?

]=]
function Network:Connect(Name: string, Callback: (...any) -> ()): RBXScriptConnection?
	local Item: PoolItem<RemoteEvent | Signal> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	table.insert(Item.Handlers, Callback)

	if Item.IsAttached then
		return Item.Connection :: RBXScriptConnection
	end

	local Signal: Signal

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" and ItemRef:IsA("BaseRemoteEvent") then
		Signal = (ItemRef :: any)[IS_SERVER and "OnServerEvent" or "OnClientEvent"] --> Type assertion is free :100:
	else
		Signal = ItemRef
	end

	Item.IsAttached = true
	Item.Connection = Signal:Connect(function(...: any)
		local Args = { ... }

		local ShouldSerialize = typeof(ItemRef) == "Instance" and (ItemRef:GetAttribute("Serialize") :: boolean)
			or false

		if ShouldSerialize then
			local IsPlayer = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player")

			if IsPlayer then
				local Player = table.remove(Args, 1)

				Args = Serializer.Deserialize(Args[1])
				table.insert(Args, 1, Player)
			else
				Args = Serializer.Deserialize(Args[1])
			end
		end

		if not ProcessMiddleware(Item.Middleware.Inbound, table.unpack(Args)) then
			return
		end

		for _, Handler in Item.Handlers do
			task.defer(Handler, table.unpack(Args))
		end
	end) :: any

	return Item.Connection :: RBXScriptConnection
end

--[=[

	@within Network
	@method Once
	@param Name string
	@param Callback (...any) -> ()

	Connects a callback function to a Signal or RemoteEvent once

	@return RBXScriptConnection?

]=]
function Network:Once(Name: string, Callback: (...any) -> ())
	local Item: PoolItem<RemoteEvent | Signal> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	local Signal: Signal

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" and ItemRef:IsA("BaseRemoteEvent") then
		Signal = (ItemRef :: any)[IS_SERVER and "OnServerEvent" or "OnClientEvent"] --> Type assertion is free :100:
	else
		Signal = ItemRef
	end

	return Signal:Once(function(...)
		local Args = { ... }

		local ShouldSerialize = typeof(ItemRef) == "Instance" and (ItemRef:GetAttribute("Serialize") :: boolean)
			or false

		if ShouldSerialize then
			local IsPlayer = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player")

			if IsPlayer then
				local Player = table.remove(Args, 1)

				Args = Serializer.Deserialize(Args[1])
				table.insert(Args, 1, Player)
			else
				Args = Serializer.Deserialize(Args[1])
			end
		end

		if not ProcessMiddleware(Item.Middleware.Inbound, table.unpack(Args)) then
			return
		end

		Callback(...)
	end)
end

--[=[

	@within Network
	@method Bind
	@param Name string
	@param Callback (..any) -> ()

	Sets a callback for a RemoteFunction

]=]
function Network:Bind(Name: string, Callback: (...any) -> any)
	local Item: PoolItem<RemoteFunction> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	if Item.IsAttached then
		return
	end

	local ItemRef = Item.Ref
	local Function = IS_SERVER and "OnServerInvoke" or "OnClientInvoke"

	Item.IsAttached = true
	ItemRef[Function] = function(...: any)
		local Args = { ... }

		local ShouldSerialize = (ItemRef:GetAttribute("Serialize") :: boolean) or false

		if ShouldSerialize then
			local IsPlayer = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player")

			if IsPlayer then
				local Player = table.remove(Args, 1)

				Args = Serializer.Deserialize(Args[1])
				table.insert(Args, 1, Player)
			else
				Args = Serializer.Deserialize(Args[1])
			end
		end

		if not ProcessMiddleware(Item.Middleware.Inbound, table.unpack(Args)) then
			return
		end

		return Callback(table.unpack(Args))
	end
end

--[=[

	@within Network
	@method Fire
	@param Name string
	@param ... any

]=]
function Network:Fire(Name: string, ...: any)
	local Item: PoolItem<RemoteEvent | Signal> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	elseif typeof(Item.Ref) == "Instance" then
		if not Item.Ref:IsA("BaseRemoteEvent") then
			warn(`[Network]: {Name} is not a RemoteEvent`)
			return
		end
	elseif typeof(Item.Ref) ~= "table" then
		warn(`[Network]: {Name} is not a Signal`)
		return
	end

	local Args = { ... }

	if not ProcessMiddleware(Item.Middleware.Outbound, table.unpack(Args)) then
		return
	end

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" and ItemRef:IsA("BaseRemoteEvent") then
		local ShouldSerialize = (ItemRef:GetAttribute("Serialize") :: boolean) or false

		if ShouldSerialize then
			Args = { Serializer.Serialize(...) }
		end

		local Method = ""

		if IS_SERVER then
			local HasPlayer = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player")

			Method = HasPlayer and "FireClient" or "FireAllClients"
		else
			Method = "FireServer"
		end

		local RetypedRef = ItemRef :: RemoteEvent

		RetypedRef[Method](RetypedRef, table.unpack(Args))
	else
		ItemRef:Fire(table.unpack(Args))
	end
end

--[=[

	@within Network
	@method Invoke
	@param Name string
	@param ... any

	@return any

]=]
function Network:Invoke(Name: string, ...: any): any
	local Item: PoolItem<RemoteFunction> = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	elseif typeof(Item.Ref) ~= "Instance" or not Item.Ref:IsA("RemoteFunction") then
		warn(`[Network]: {Name} is not a RemoteFunction`)
		return
	end

	local Args = { ... }

	if not ProcessMiddleware(Item.Middleware.Outbound, table.unpack(Args)) then
		return
	end

	local ItemRef = Item.Ref
	local ShouldSerialize = (ItemRef:GetAttribute("Serialize") :: boolean) or false

	if ShouldSerialize then
		Args = { Serializer.Serialize(...) }
	end

	local InvokeMethod = IS_SERVER and "InvokeClient" or "InvokeServer"

	return ItemRef[InvokeMethod](ItemRef, table.unpack(Args))
end

-- Init:
if not Remotes then
	local Ref = Instance.new("Folder")
	Ref.Name = "Remotes"
	Ref.Parent = ReplicatedStorage
	Remotes = Ref

	Ref = nil
end

Network._Pool = CreatePool()

-- Connections:
Remotes.ChildAdded:Connect(function(Child: Instance)
	if not Child:IsA("RemoteEvent") and not Child:IsA("UnreliableRemoteEvent") and not Child:IsA("RemoteFunction") then
		return
	end

	Network._Pool[Child.Name] = CreatePoolItem(Child)
end)

return Trait.new(Network)
