--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[JSON.luau]:
		Wrapper for Roblox's JSON Encoding/Decoding using HttpService

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Main Module:
--[=[

	@class JSON
	Wrapper for Roblox's JSON Encoding/Decoding using HttpService

	Documentation for [HttpService](https://create.roblox.com/docs/reference/engine/classes/HttpService#JSONDecode)

]=]
local JSON = {}

--[=[

	@within JSON
	@function Encode
	@param Input any

	@return string

]=]
function JSON.Encode(Input: any)
	return game:GetService("HttpService"):JSONEncode(Input)
end

--[=[

	@within JSON
	@function Decode
	@param Input string

	@return any

]=]
function JSON.Decode(Input: string)
	return game:GetService("HttpService"):JSONDecode(Input)
end

return table.freeze(JSON)
