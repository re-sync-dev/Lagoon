--!strict
--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Network.luau]:
		Used for networking either across the client -> server boundary or across scripts using Signals.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders:
local ProjectRoot = script.Parent.Parent
local Packages = ProjectRoot:FindFirstChild("Packages") or ProjectRoot.Parent

-- Modules:
local Types = require(ProjectRoot.Types)

local Signal = (require)(Packages.Signal)

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
	@interface NetworkPoolItem
	.Middleware MiddlewareEntry,
	.Ref RemoteEvent | RemoteFunction | Signal<any>

]=]
type PoolItem = Types.NetworkPoolItem
type Middleware = Types.Middleware

type Network = Types.Network

-- Constants:
local IS_SERVER = RunService:IsServer()
local DEFAULT_TIMEOUT = 5

-- Locals:
local Remotes: Folder = ReplicatedStorage:FindFirstChild("Remotes")

-- Functions:
local function CreatePoolItem<T>(Ref: T): PoolItem
	return {
		Middleware = {
			Inbound = {},
			Outbound = {},
		},
		Ref = Ref,
	} :: any
end

local function CreatePool()
	local Pool = {}

	for _, Child in Remotes:GetChildren() do
		Pool[Child.Name] = CreatePoolItem(Child)
	end

	return Pool
end

local function ProcessMiddleware(MiddlewareHandlers: Array<MiddlewareCallback>, Args: any)
	for _, Handler in MiddlewareHandlers do
		local ShouldCancel = Handler(Args)

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

]=]
local Network = {} :: Network

--[=[

	@within Network
	@prop _Pool Dictionary<NetworkPoolItem>
	@readonly
	@private

]=]

--[=[

	@within Network
	@method CreateSignal
	@param Name string

	Appends a signal with the given name to the net pool.

	@return NetworkPoolItem

]=]
function Network:CreateSignal(Name: string)
	local Item: any = self._Pool[Name]

	if Item then
		return Item
	end

	Item = CreatePoolItem(Signal.new())

	self._Pool[Name] = Item

	return Item
end

--[=[

	@within Network
	@method CreateEvent
	@param Name string
	@param IsUnreliable: boolean?

	Appends a RemoteEvent with the given name to the net pool.

	@return NetworkPoolItem

]=]
function Network:CreateEvent(Name: string, IsUnreliable: boolean?)
	local Item: any = self._Pool[Name]

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

	Item = CreatePoolItem(RemoteEvent)

	self._Pool[Name] = Item

	return Item
end

--[=[

	@within Network
	@method CreateFunction
	@param Name string

	Appends a RemoteFunction with the given name to the net pool.

	@return NetworkPoolItem

]=]
function Network:CreateFunction(Name: string)
	local Item: any = self._Pool[Name]

	if Item then
		return Item
	end

	local RemoteFunction: RemoteFunction = Instance.new("RemoteFunction")

	RemoteFunction.Name = Name
	RemoteFunction.Parent = Remotes

	Item = CreatePoolItem(RemoteFunction)

	self._Pool[Name] = Item

	return Item
end

--[=[

	@within Network
	@method Get
	@param Name string
	@param Timeout number?

	@return NetworkPoolItem?

]=]
function Network:Get(Name: string, Timeout: number?)
	local Result = self._Pool[Name]

	if Result then
		return Result
	end

	if Timeout then
		repeat
			local Remote = Remotes:FindFirstChild(Name) :: (RemoteEvent | UnreliableRemoteEvent | RemoteFunction)?

			if not Result and Remote then
				Result = CreatePoolItem(Remote)
				self._Pool[Remote.Name] = Result
			end

			Timeout -= 0.1
			task.wait(0.1)
		until Result or Timeout <= 0
	end

	return Result
end

--[=[

	@within Network
	@method WaitFor
	@param Name string
	@param Timeout number?

	Wraps around the `:Get` and passes a default timeout to `:Get` if one is not provided.

	@return NetworkPoolItem?

]=]
function Network:WaitFor(Name: string, Timeout: number?)
	return self:Get(Name, Timeout or DEFAULT_TIMEOUT)
end

--[=[

	@within Network
	@method AddMiddleware
	@param Name string
	@param ... Middleware

]=]
function Network:AddMiddleware(Name: string, ...: Middleware)
	local Item: PoolItem? = self._Pool[Name]

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
	local Item: PoolItem = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	local Signal: Signal

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" then
		if ItemRef:IsA("BaseRemoteEvent") then
			Signal = (ItemRef :: any)[IS_SERVER and "OnServerEvent" or "OnClientEvent"] --> Type assertion is free :100:
		else
			error(`[Network]: {Name} is not a RemoteEvent or Signal`)
		end
	else
		Signal = ItemRef
	end

	return (
		Signal:Connect(function(...: any)
			local Args = { ... }

			if not ProcessMiddleware(Item.Middleware.Inbound, Args) then
				return
			end

			Callback(table.unpack(Args))
		end) :: any
	) :: any
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
	local Item: PoolItem? = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	local Signal: Signal

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" then
		if ItemRef:IsA("BaseRemoteEvent") then
			Signal = (ItemRef :: any)[IS_SERVER and "OnServerEvent" or "OnClientEvent"] --> Type assertion is free :100:
		else
			error(`[Network]: {Name} is not a RemoteEvent or Signal`)
		end
	else
		Signal = ItemRef
	end

	return (
		Signal:Once(function(...)
			local Args = { ... }

			if not ProcessMiddleware(Item.Middleware.Inbound, Args) then
				return
			end

			Callback(table.unpack(Args))
		end)
	) :: any
end

--[=[

	@within Network
	@method Bind
	@param Name string
	@param Callback (..any) -> ()

	Sets a callback for a RemoteFunction

]=]
function Network:Bind(Name: string, Callback: (...any) -> any)
	local Item: PoolItem? = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	end

	local ItemRef = Item.Ref

	if typeof(ItemRef) ~= "Instance" then
		return
	elseif ItemRef:IsA("BaseRemoteEvent") then
		return
	end

	local Function = IS_SERVER and "OnServerInvoke" or "OnClientInvoke";

	-- Unsafe dynamic setting of field warning
	(ItemRef :: any)[Function] = function(...: any)
		local Args = { ... }

		if not ProcessMiddleware(Item.Middleware.Inbound, Args) then
			return
		end

		local Result = { Callback(table.unpack(Args)) }

		if not ProcessMiddleware(Item.Middleware.Outbound, Result) then
			return
		end

		return table.unpack(Result)
	end

	return function()
		-- Unsafe dynamic setting of field warning
		(ItemRef :: any)[Function] = nil
	end
end

--[=[

	@within Network
	@method Fire
	@param Name string
	@param ... any

]=]
function Network:Fire(Name: string, ...: any)
	local Item: PoolItem = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	elseif typeof(Item.Ref) == "Instance" then
		if not Item.Ref:IsA("BaseRemoteEvent") then
			warn(`[Network]: {Name} is not a RemoteEvent`)
			return
		end
	elseif type(Item.Ref) ~= "table" then
		warn(`[Network]: {Name} is not a Signal`)
		return
	end

	local Args = { ... }

	if not ProcessMiddleware(Item.Middleware.Outbound, Args) then
		return
	end

	local ItemRef = Item.Ref

	if typeof(ItemRef) == "Instance" and ItemRef:IsA("BaseRemoteEvent") then
		local Method = ""

		if IS_SERVER then
			local HasPlayer = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player")

			Method = HasPlayer and "FireClient" or "FireAllClients"
		else
			Method = "FireServer"
		end

		local RetypedRef = ItemRef :: any

		RetypedRef[Method](RetypedRef, table.unpack(Args))
	else
		(ItemRef :: any):Fire(table.unpack(Args))
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
	local Item: PoolItem = self._Pool[Name]

	if not Item then
		warn(`[Network]: Cannot find '{Name}'`)
		return
	elseif typeof(Item.Ref) ~= "Instance" or Item.Ref:IsA("BaseRemoteEvent") then
		warn(`[Network]: {Name} is not a RemoteFunction`)
		return
	end

	local Args = { ... }

	if not ProcessMiddleware(Item.Middleware.Outbound, Args) then
		return
	end

	local ItemRef = Item.Ref
	local InvokeMethod = IS_SERVER and "InvokeClient" or "InvokeServer"

	-- Unsafe dynamic setting of field warning
	return (ItemRef :: any)[InvokeMethod](ItemRef, table.unpack(Args))
end

-- Init:
if not Remotes then
	local Ref = Instance.new("Folder")
	Ref.Name = "Remotes"
	Ref.Parent = ReplicatedStorage
	Remotes = Ref
end

Network._Pool = CreatePool()

-- Connections:
Remotes.ChildAdded:Connect(function(Child: Instance)
	if not Child:IsA("RemoteEvent") and not Child:IsA("UnreliableRemoteEvent") and not Child:IsA("RemoteFunction") then
		return
	end

	if Child:GetAttribute("NoPool") then
		return
	end

	Network._Pool[Child.Name] = CreatePoolItem(Child)
end)

return Network
