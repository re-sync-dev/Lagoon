--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[LoggerType.luau]:
		Static types for the Logger trait.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local TraitType = require(script.Parent.TraitType)

-- Types:
-- Private:
type TraitBase = TraitType.TraitBase

-- Public:
export type LogContext = "Debug" | "Info" | "Warn" | "Error" | "Fatal"
export type LogOptions = {
	Name: string?,
	Debug: boolean?,
	Timestamp: boolean?,
}

export type Logger = {
	LogOptions: LogOptions,

	Log: <T>(self: T, Context: LogContext, ...any) -> (),
} & TraitBase

return {}
