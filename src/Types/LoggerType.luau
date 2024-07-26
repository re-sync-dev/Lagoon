--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[LoggerType.luau]:
		Static types for the Logger trait.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
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
}

return {}
