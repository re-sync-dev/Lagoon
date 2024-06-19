--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[NetType.lua]:
		Static types for the Net trait.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Modules:
local Generic = require(script.Parent.Generic)

-- Types:
-- Generic:
type Dictionary<T> = Generic.Dictionary<T>

type Signal<T...> = Generic.Signal<T...>
type Connection = Generic.Connection

-- Public:
export type MiddlewareEntry = {
	Inbound: (...any) -> (),
	Outbound: (...any) -> (),
}

export type Net = {
	Name: string,

	_Pool: Dictionary<RemoteEvent | RemoteFunction | Signal<any>>,
	_Middleware: Dictionary<MiddlewareEntry>,

	SerializePacket: (...any) -> { string | Instance },
	DeserializePacket: (Packet: { string | Instance }) -> { any },

	WaitFor: (self: Net, Name: string, Timeout: number?) -> (RemoteEvent | RemoteFunction | Signal<any>)?,

	CreateSignal: (self: Net, Name: string, Middleware: MiddlewareEntry?) -> Signal<any>?,
	CreateEvent: (
		self: Net,
		Name: string,
		Middleware: MiddlewareEntry?,
		IsUnreliable: boolean?
	) -> (RemoteEvent | UnreliableRemoteEvent)?,
	CreateFunction: (self: Net, Name: string, Middleware: MiddlewareEntry?) -> RemoteFunction?,

	Connect: (self: Net, Name: string, Callback: (...any) -> ()) -> (RBXScriptConnection | Connection)?,
	Bind: (self: Net, Name: string, Callback: (...any) -> ()) -> (),

	Fire: (self: Net, Name: string, ...any) -> (),
	Invoke: (self: Net, Name: string, ...any) -> any,
}

return {}
