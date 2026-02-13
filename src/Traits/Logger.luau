--!strict
--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Logger.luau]:
		Used for logging information in a production or development environment.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Types = require(script.Parent.Parent.Types)

-- Types:
-- Private:
--[=[

	@within Logger
	@type LogType "Info" | "Warn" | "Error" | "Debug/Info" | "Debug/Warn" | "Debug/Error"

]=]
type LogType = Types.LogType

--[=[

	@within Logger
	@interface LogOptions
	.Name string?,
	.Debug boolean?,
	.Timestamp boolean?,

]=]
type LogOptions = Types.LogOptions
type Logger = Types.Logger

-- Constants:
local DEFAULT_OPTIONS = {
	Debug = false,
	Timestamp = false,
}

-- Main Module:
--[=[

	@class Logger
	Used for logging information in a production or development environment.

]=]
local Logger = {} :: Logger

--[=[

	@within Logger
	@prop LogOptions LogOptions

]=]

--[=[

	@within Logger
	@method Log
	@param Type LogType
	@param ... any

	Displays message(s) in the output.

	:::info
	Debug logs can change Type provided there is a delimeter for example 'Debug/Info' while the primary Type will be 'Debug' the displayed Type will be 'Info'
	:::

]=]
function Logger.Log(self, Type: LogType, ...: any)
	local RetypedSelf = (self :: any) :: { Name: string?, LogOptions: LogOptions? }
	local LogOptions: LogOptions = RetypedSelf.LogOptions or DEFAULT_OPTIONS

	if Type:sub(1, 5) == "Debug" then
		if not LogOptions.Debug then
			return
		end

		local NewType = Type:sub(7, #Type)

		-- Debug logs should be separated by a delimiter at all times, hence the starting index of 7.
		Type = ((NewType ~= "" and NewType or "Debug") :: any) :: LogType
	end

	local Prefix = LogOptions.Timestamp and `[{os.date("%H:%M:%S")}] ` or ""

	local Name = LogOptions.Name or RetypedSelf.Name or "Logger"

	local Caller, Line = debug.info(2, "nl")

	if Name and Name ~= "" then
		Prefix ..= `[{Name}.{Caller}:{Line}]`
	end

	if Type == "Info" then
		print(Prefix, ...)
	elseif Type == "Warn" then
		warn(Prefix, ...)
	elseif Type == "Error" then
		error(`{Prefix} {...}`, 2)
	end
end

return Logger
