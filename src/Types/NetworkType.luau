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

export type NetworkPoolItem<T> = {
	Middleware: MiddlewareEntry,
	Ref: T,
}

export type Network = {
	_Pool: Dictionary<NetworkPoolItem<RemoteEvent | RemoteFunction | Signal<any>>>,

	CreateSignal: (self: Network, Name: string) -> NetworkPoolItem<Signal<any>>,

	CreateEvent: (self: Network, Name: string, IsUnreliable: boolean?) -> NetworkPoolItem<RemoteEvent>,

	CreateFunction: (self: Network, Name: string) -> NetworkPoolItem<RemoteFunction>,

	Get: (
		self: Network,
		Name: string,
		Timeout: number?
	) -> NetworkPoolItem<RemoteEvent | RemoteFunction | Signal<any>>?,

	WaitFor: (
		self: Network,
		Name: string,
		Timeout: number?
	) -> NetworkPoolItem<RemoteEvent | RemoteFunction | Signal<any>>?,

	AddMiddleware: (self: Network, Name: string, ...Middleware) -> (),

	Once: (self: Network, Name: string, Callback: (...any) -> ()) -> RBXScriptConnection?,
	Connect: (self: Network, Name: string, Callback: (...any) -> ()) -> RBXScriptConnection?,

	Bind: (self: Network, Name: string, Callback: (...any) -> ()) -> () -> (),

	Fire: (self: Network, Name: string, ...any) -> (),
	Invoke: (self: Network, Name: string, ...any) -> any,
}

return {}
