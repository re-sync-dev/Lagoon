--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Net.lua]:
		Used for networking either across the client -> server boundary or across scripts using Signals.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")

-- Folders:
local ProjectRoot = script.Parent.Parent
local Packages = ProjectRoot:FindFirstChild("Packages") or ProjectRoot.Parent

-- Modules:
local Signal = require(Packages.Signal)
local Squash = require(Packages.Squash)
local Types = require(ProjectRoot.Types)
local Trait = require(script.Parent.Base)

-- Types:
-- Private:
type Signal = Types.Signal<...any>
type Connection = Types.Connection

-- Constants:
local IS_SERVER = RunService:IsServer()
local DEFAULT_TIMEOUT = 5

local SERIALIZER_ENUMS = {
	Instance = 0,
	CFrame = 1,
	Vector3 = 2,
	Color3 = 3,
	string = 4,
	number = 5,
	table = 6,

	End = 100,
}

-- Variables:
local JSON = {
	Encode = function(Input: any)
		return game:GetService("HttpService"):JSONEncode(Input)
	end,
	Decode = function(Input: any)
		return game:GetService("HttpService"):JSONDecode(Input)
	end,
}

-- Functions:
local function CreatePool()
	local Pool = {}

	for _, Child in script:GetChildren() do
		Pool[Child.Name] = Child
	end

	return Pool
end

local function ToString(Byte: number)
	return string.char(Byte)
end

local function GetNameFromEnum(Enum: number): string?
	for Key, Value in SERIALIZER_ENUMS :: { [string]: number } do
		if Value ~= Enum then
			continue
		end

		return Key
	end

	return nil
end

local function SerializePacket(...): { string | Instance }
	local Args = { ... }
	local Packet = { "" }

	for _, Arg in Args do
		local ArgType = typeof(Arg)

		if not SERIALIZER_ENUMS[ArgType] then
			warn(`'{ArgType}' is not a serializable value.`)
			continue
		end

		if ArgType == "Instance" then
			table.insert(Packet, Arg)
			Packet[1] ..= `{ToString(SERIALIZER_ENUMS.Instance)}{ToString(#Packet)}`
		elseif ArgType == "table" then
			Packet[1] ..= `{ToString(SERIALIZER_ENUMS.table)}{JSON.Encode(Arg)}`
		else
			Packet[1] ..= `{ToString(SERIALIZER_ENUMS[ArgType])}{Squash[ArgType].ser(Arg)}`
		end

		Packet[1] ..= `{ToString(SERIALIZER_ENUMS.End)}`
	end

	return Packet
end

local function DeserializePacket(Packet: { string | Instance })
	local Args: { any } = {}

	local PacketString = Packet[1] :: string
	local PacketData = PacketString:split(ToString(SERIALIZER_ENUMS.End))

	for _, Value in PacketData do
		if Value == "" then
			continue
		end

		local Type = Value:byte(1, 1)

		if not GetNameFromEnum(Type) then
			warn("Invalid value type in packet.")
			continue
		end

		if Type == SERIALIZER_ENUMS.Instance then
			local Index = Value:byte(2, 2)

			table.insert(Args, Packet[Index] :: Instance)
		elseif Type == SERIALIZER_ENUMS.table then
			local DecodedTable = JSON.Decode(Value:sub(2, #Value))

			table.insert(Args, DecodedTable)
		else
			local DeserializedValue = Squash[GetNameFromEnum(Type)].des(Value:sub(2))

			table.insert(Args, DeserializedValue)
		end
	end

	return Args
end

-- Main Module:
--[=[
	@class NetTrait
	Used for networking either across the client -> server boundary or across scripts using Signals.
]=]
local Net = {}

--[=[
	@within NetTrait
	@prop Name string
	@readonly
]=]
Net.Name = "Net"

--[=[
	@within NetTrait
	@prop _Pool { RemoteEvent | RemoteFunction | Signal }
	@readonly
	@private
]=]
Net._Pool = CreatePool()

--[=[
	@within NetTrait
	@function SerializePacket
	@param ... any

	Utilizes [Squash](https://data-oriented-house.github.io/Squash/) for packet serialization and adds a byte to the beginning of a packet section to indicate what type the object was.

	**Packet Section:** `<section_type><data>`

	There are special section types specifically for Instances and Tables

	**Instance:** `<section_type><index>` - The index represents a point in the packet after the packet string`

	**Table:** `<section_type><encoded_table>` - The table is encoded using Roblox's JSON functions (This might be changed in the future to use a type of lossless compression to save on bandwidth)

	From some basic tests that were run using a packet that was sending an instance reference and a bunch of relevant color information & CFrames around ~1.1KB in bandwidth was saved.

	@return { [1]: string, ...: Instance }
]=]
Net.SerializePacket = SerializePacket

--[=[
	@within NetTrait
	@function DeserializePacket
	@param Packet { [1]: string, ...: Instance }

	Reads the first byte of a packet section the "section_type" and continues deserialization from there.

	@return { any }
]=]
Net.DeserializePacket = DeserializePacket

--[=[
	@within NetTrait
	@method WaitFor
	@param Name string
	@param Timeout number?
	@yields

	Yields the current thread until there is an Item with the provided name or the timeout is reached.

	@return (RemoteEvent | RemoteFunction | Signal)?
]=]
function Net:WaitFor(Name: string, Timeout: number?): (RemoteEvent | RemoteFunction | Signal)?
	local Item = self._Pool[Name]

	local Time = 0

	repeat
		Time += task.wait(0.1)
		Item = self._Pool[Name] or script:FindFirstChild(Name)
	until Time > (Timeout or DEFAULT_TIMEOUT) or Item ~= nil

	if Item and not self._Pool[Name] then
		self._Pool[Name] = Item
	end

	return Item
end

--[=[
	@within NetTrait
	@method CreateSignal
	@param Name string

	Adds a signal with the given name to the net pool.

	@return Signal?
]=]
function Net:CreateSignal(Name: string): Signal?
	if self._Pool[Name] then
		error(`[Net]: Cannot create signal '{Name}' due to entry already existing.`)
		return
	end

	self._Pool[Name] = Signal.new()
	return self._Pool[Name]
end

--[=[
	@within NetTrait
	@method CreateRemote
	@param Name string
	@param Class "RemoteEvent" | "RemoteFunction"

	Adds a remote with the given name to the net pool.

	@return (RemoteEvent | RemoteFunction)?
]=]
function Net:CreateRemote(Name: string, Class: "RemoteEvent" | "RemoteFunction"): (RemoteEvent | RemoteFunction)?
	if self._Pool[Name] then
		error(`[Net]: Cannot create signal '{Name}' due to entry already existing.`)
		return
	end

	local Remote = Instance.new(Class)
	Remote.Name = Name
	Remote.Parent = script

	self._Pool[Name] = Remote
	return self._Pool[Name]
end

--[=[
	@within NetTrait
	@method Connect
	@param Name string
	@param Callback (...any) -> ()

	Can connect a callback function to a Signal or RemoteEvent

	@return RBXScriptConnection | Connection)?
]=]
function Net:Connect(Name: string, Callback: (...any) -> ()): (RBXScriptConnection | Connection)?
	local Item: RemoteEvent | Signal = self._Pool[Name]

	if not Item then
		error(`[Net]: Signal '{Name}' doesn't exist.`)
		return
	elseif typeof(Item) == "Instance" and not Item:IsA("RemoteEvent") then
		error(`[Net]: RemoteEvent '{Name}' doesn't exist.`)
		return
	end

	if typeof(Item) == "Instance" and Item:IsA("RemoteEvent") then
		local Method = IS_SERVER and "OnServerEvent" or "OnClientEvent"

		local Signal = Item[Method] :: RBXScriptSignal
		local ShouldSerialize = Item:GetAttribute("ShouldSerialize") or false

		return Signal:Connect(function(...)
			local Args = { ... }
			local Player = IS_SERVER and table.remove(Args, 1) or nil

			if ShouldSerialize then
				Args = self.DeserializePacket(unpack(Args))
			end

			if Player then
				Callback(Player, unpack(Args))
			else
				Callback(unpack(Args))
			end
		end)
	else
		return Item:Connect(Callback)
	end
end

--[=[
	@within NetTrait
	@method Bind
	@param Name string
	@param Callback (..any) -> ()

	Sets a callback for a RemoteFunction
]=]
function Net:Bind(Name: string, Callback: (...any) -> ())
	local Remote: RemoteFunction = self._Pool[Name]

	if typeof(Remote) ~= "Instance" or not Remote:IsA("RemoteFunction") then
		error(`[Net]: RemoteFunction '{Name}' doesn't exist.`)
		return
	end

	local Method = IS_SERVER and "OnServerInvoke" or "OnClientInvoke"
	local ShouldSerialize = Remote:GetAttribute("ShouldSerialize") or false

	Remote[Method] = function(...)
		local Args = { ... }
		local Player = IS_SERVER and table.remove(Args, 1)

		if ShouldSerialize then
			Args = self.DeserializePacket(unpack(Args))
		end

		return Callback(Player, unpack(Args))
	end
end

--[=[
	@within NetTrait
	@method Fire
	@param Name string
	@param ... any
]=]
function Net:Fire(Name: string, ...)
	local Args = { ... }
	local Item: RemoteEvent | Signal = self._Pool[Name]

	if not Item then
		error(`[Net]: Signal '{Name}' doesn't exist.`)
		return
	elseif typeof(Item) == "Instance" and not Item:IsA("RemoteEvent") then
		error(`[Net]: Remote '{Name}' doesn't exist.`)
		return
	end

	if typeof(Item) == "Instance" and Item:IsA("RemoteEvent") then
		local IsTargeted: boolean = typeof(Args[1]) == "Instance" and Args[1]:IsA("Player") or false
		local Method = IS_SERVER and (IsTargeted and "FireClient" or "FireAllClients") or "FireServer"

		local Func = Item[Method] :: (...any) -> ()

		local ShouldSerialize = Item:GetAttribute("ShouldSerialize") or false

		if ShouldSerialize then
			Func(Item, self.SerializePacket(...))
		else
			Func(Item, ...)
		end
	elseif typeof(Item) == "table" then
		Item:Fire(...)
	end
end

--[=[
	@within NetTrait
	@method Invoke
	@param Name string
	@param ... any
]=]
function Net:Invoke(Name: string, ...)
	local Remote: RemoteFunction = self._Pool[Name]

	if not Remote then
		error(`[Net]: RemoteFunction '{Name}' doesn't exist.`)
		return
	end

	local Method = IS_SERVER and "InvokeClient" or "InvokeServer"

	local Func = Remote[Method] :: (...any) -> ()

	local ShouldSerialize = Remote:GetAttribute("ShouldSerialize") or false

	if ShouldSerialize then
		return Func(Remote, self.SerializePacket(...))
	else
		return Func(Remote, ...)
	end
end

return Trait.new(Net)
