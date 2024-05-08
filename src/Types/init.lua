--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Types.lua]:
		Static types that are used within Lagoon.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Generic = require(script.Generic)
local NetType = require(script.NetType)

-- Types:
-- Public:
export type Array<T> = Generic.Array<T>
export type Dictionary<T> = Generic.Dictionary<T>

export type Signal<T...> = Generic.Signal<T...>
export type Connection = Generic.Connection

-- Traits:
export type Net = NetType.Net
export type MiddlewareEntry = NetType.MiddlewareEntry

return {}
