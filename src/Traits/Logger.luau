--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Logger.luau]:
		Used for logging information in a production or development environment.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local RunService = game:GetService("RunService")

-- Modules:
local Types = require(script.Parent.Parent.Types)

-- Types:
-- Private:
--[=[

	@within Logger
	@type LogContext "Debug" | "Info" | "Warn" | "Error" | "Fatal"

]=]
type LogContext = Types.LogContext

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
local IS_DEVELOPMENT = RunService:IsStudio()

local DEFAULT_OPTIONS = {
	Debug = IS_DEVELOPMENT,
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
	@param Context LogContext
	@param ... any

	Displays message(s) in the output.

	:::info
	Debug logs can change context provided there is a delimeter for example 'Debug/Info' while the primary context will be 'Debug' the displayed context will be 'Info'
	:::

]=]
function Logger:Log(Context: LogContext, ...: any)
	local LogOptions: LogOptions = self.LogOptions or DEFAULT_OPTIONS

	if Context:sub(1, 5) == "Debug" then
		if not LogOptions.Debug or not IS_DEVELOPMENT then
			return
		end

		local NewContext = Context:sub(7, #Context)

		Context = NewContext ~= "" and NewContext or "Debug" :: LogContext --> Debug logs should be separated by a delimiter at all times, hence the starting index of 7.
	end

	local Prefix = LogOptions.Timestamp and `[{os.date("%H:%M:%S")}] ` or ""

	local Name = LogOptions.Name or self.Name or "Logger"

	if Name and Name ~= "" then
		Prefix ..= `[{Name}({Context:upper()})]`
	end

	if Context == "Info" then
		print(Prefix, ...)
	elseif Context == "Warn" then
		warn(Prefix, ...)
	elseif Context == "Error" or Context == "Fatal" then
		error(`{Prefix} {...}`, 0)
	end
end

return Logger
