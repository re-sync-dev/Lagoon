--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[NetType.luau]:
		Static types for the Net trait.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Generic = require(script.Parent.Generic)

-- Types:
-- Generic:
type Array<T> = Generic.Array<T>
type Dictionary<T> = Generic.Dictionary<T>

type Signal<T...> = Generic.Signal<T...>
type Connection = Generic.Connection

-- Public:
export type MiddlewareCallback = (...any) -> boolean?
export type MiddlewareEntry = {
	Inbound: Array<MiddlewareCallback>,
	Outbound: Array<MiddlewareCallback>,
}

export type Middleware = {
	Inbound: MiddlewareCallback?,
	Outbound: MiddlewareCallback?,
}

type EventPoolItem = {
	Ref: RemoteEvent,
	Middleware: MiddlewareEntry,
}

type FunctionPoolItem = {
	Ref: RemoteFunction,
	Middleware: MiddlewareEntry,
}

type SignalPoolItem<T> = {
	Ref: Signal<T>,
	Middleware: MiddlewareEntry,
}

export type NetworkPoolItem = EventPoolItem | FunctionPoolItem | SignalPoolItem<any>

export type Network = {
	_Pool: Dictionary<NetworkPoolItem>,

	CreateEvent: (self: Network, Name: string, IsUnreliable: boolean?) -> EventPoolItem,
	CreateSignal: (self: Network, Name: string) -> SignalPoolItem<any>,
	CreateFunction: (self: Network, Name: string) -> FunctionPoolItem,

	Get: (self: Network, Name: string, Timeout: number?) -> NetworkPoolItem?,

	WaitFor: (self: Network, Name: string, Timeout: number?) -> NetworkPoolItem?,

	AddMiddleware: (self: Network, Name: string, ...Middleware) -> (),

	Once: (self: Network, Name: string, Callback: (...any) -> ()) -> RBXScriptConnection?,
	Connect: (self: Network, Name: string, Callback: (...any) -> ()) -> RBXScriptConnection?,

	Bind: (self: Network, Name: string, Callback: (...any) -> ()) -> (() -> ())?,

	Fire: (self: Network, Name: string, ...any) -> (),
	Invoke: (self: Network, Name: string, ...any) -> any,
}

return {}
