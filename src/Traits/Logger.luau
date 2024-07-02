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
local Trait = require(script.Parent.Base)
local Types = require(script.Parent.Parent.Types)

-- Types:
-- Private:
--[=[

	@within LoggerTrait
	@type LogContext "Debug" | "Info" | "Warn" | "Error" | "Fatal"

]=]
type LogContext = Types.LogContext

--[=[

	@within LoggerTrait
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
	Name = "Logger",
	Debug = IS_DEVELOPMENT,
	Timestamp = false,
}

-- Main Module:
--[=[

	@class LoggerTrait
	Used for logging information in a production or development environment.

	Inherits from [TraitBase](/api/TraitBase)

]=]
local Logger = {} :: Logger

--[=[

	@within LoggerTrait
	@prop LogOptions LogOptions

]=]

--[=[

	@within LoggerTrait
	@method Log
	@param Context LogContext
	@param ... any

	Displays message(s) in the output.

	:::info
	Debug logs can change context provided there is a delimeter for example 'Debug/Info' while the primary context will be 'Debug' the displayed context will be 'Info'
	:::

]=]
function Logger:Log(Context: LogContext, ...)
	local LogOptions = self.LogOptions or DEFAULT_OPTIONS

	if Context:sub(1, 5) == "Debug" then
		if not LogOptions.Debug or not IS_DEVELOPMENT then
			return
		end

		local NewContext = Context:sub(7, #Context)

		Context = NewContext ~= "" and NewContext or "Debug" :: LogContext --> Debug logs should be separated by a delimiter at all times, hence the starting index of 7.
	end

	local Prefix = LogOptions.Timestamp and `[{os.date("%H:%M:%S")}] ` or ""

	if LogOptions.Name and LogOptions.Name ~= "" then
		Prefix ..= `[{LogOptions.Name}({Context:upper()})]`
	end

	if Context == "Info" then
		print(Prefix, ...)
	elseif Context == "Warn" then
		warn(Prefix, ...)
	elseif Context == "Error" or Context == "Fatal" then
		error(`{Prefix} {...}`, 0)
	end
end

return Trait.new(Logger)
