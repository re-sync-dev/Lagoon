--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Serializer.luau]:
		Used to create serialized packets in Lagoon's Network trait. 

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Folders:
local ProjectRoot = script.Parent.Parent.Parent
local Packages = ProjectRoot:FindFirstChild("Packages") or ProjectRoot.Parent

-- Modules:
local JSON = require(script.Parent.JSON)

local Squash = require(Packages.Squash)

-- Constants:
local CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[]{}'\","
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

-- Functions:
local function GetNameFromEnum(Enum: number): string?
	for Key, Value in SERIALIZER_ENUMS :: { [string]: number } do
		if Value ~= Enum then
			continue
		end

		return Key
	end

	return nil
end

--[=[

	@class Serializer

	Utility module used by the Network for serializing data.

]=]

--[=[

	@within Serializer
	@function Serialize
	@param ... any

	Utilizes [Squash](https://data-oriented-house.github.io/Squash/) for packet serialization and adds a byte to the beginning of a packet section to indicate what type the object was.

	**Packet Section:** `<section_type><data>`

	There are special section types specifically for Instances and Tables

	**Instance:** `<section_type><index>` - The index represents a point in the packet after the packet string`

	**Table:** `<section_type><encoded_table>` - The table is encoded using Roblox's JSON functions (This might be changed in the future to use a type of lossless compression to save on bandwidth)

	From some basic tests that were run using a packet that was sending an instance reference and a bunch of relevant color information & CFrames saved around ~1.1KB in bandwidth.

	@return { [1]: string, ...: Instance }

]=]
local function Serialize(...): { string | Instance }
	local Args = { ... }
	local Packet = { "" }

	for _, Arg in Args do
		local ArgType = typeof(Arg)

		if not SERIALIZER_ENUMS[ArgType] then
			warn(`'{ArgType}' is not a serializable value.`)
			continue
		end

		local Kind = string.char(SERIALIZER_ENUMS[ArgType])
		local Value = ""

		if ArgType == "Instance" then
			local Location = #Packet + 1
			table.insert(Packet, Location, Arg)

			Value = Location
		elseif ArgType == "table" then
			local EncodedValue = JSON.Encode(Arg)
			Value = Squash.string.ser(EncodedValue, CHARACTERS)
		else
			Value = Squash[ArgType].ser(Arg)
		end

		Packet[1] ..= `{Kind}{Value}{string.char(SERIALIZER_ENUMS.End)}`
	end

	return Packet
end

--[=[

	@within Serializer
	@function Deserialize
	@param Packet { [1]: string, ...: Instance }

	Reads the first byte of a packet section the "section_type" and continues deserialization from there.

	@return { any }

]=]
local function Deserialize(Packet: { string | Instance })
	local Args: { any } = {}

	local PacketString = Packet[1] :: string
	local PacketData = PacketString:split(string.char(SERIALIZER_ENUMS.End))

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
			local SerializedValue = Value:sub(2, #Value)
			local DeserializedValue = Squash.string.des(SerializedValue, CHARACTERS)
			local DecodedTable = JSON.Decode(DeserializedValue)

			table.insert(Args, DecodedTable)
		else
			local DeserializedValue = Squash[GetNameFromEnum(Type)].des(Value:sub(2))

			table.insert(Args, DeserializedValue)
		end
	end

	return Args
end

return {
	Serialize = Serialize,

	Deserialize = Deserialize,
}
