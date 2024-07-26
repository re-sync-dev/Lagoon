--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Types.luau]:
		Static types that are used within Lagoon.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Generic = require(script.Generic)
local NetworkType = require(script.NetworkType)
local LoggerType = require(script.LoggerType)

-- Types:
-- Public:
export type Array<T> = Generic.Array<T>
export type Dictionary<T> = Generic.Dictionary<T>

export type Signal<T...> = Generic.Signal<T...>
export type Connection = Generic.Connection

--	Network:
export type Network = NetworkType.Network
export type MiddlewareEntry = NetworkType.MiddlewareEntry
export type MiddlewareCallback = NetworkType.MiddlewareCallback
export type Middleware = NetworkType.Middleware
export type NetworkPoolItem<T> = NetworkType.NetworkPoolItem<T>

--	Logger:
export type LogContext = LoggerType.LogContext
export type LogOptions = LoggerType.LogOptions
export type Logger = LoggerType.Logger

return {}
