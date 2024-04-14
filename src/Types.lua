--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Types.lua]:
		Static types that are used within Lagoon.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
-- Public:
export type Connection = {
	Disconnect: (self: Connection) -> (),
	Destroy: (self: Connection) -> (),
	Connected: boolean,
}

export type Signal<T...> = {
	Fire: (self: Signal<T...>, T...) -> (),
	FireDeferred: (self: Signal<T...>, T...) -> (),
	Connect: (self: Signal<T...>, fn: (T...) -> ()) -> Connection,
	Once: (self: Signal<T...>, fn: (T...) -> ()) -> Connection,
	DisconnectAll: (self: Signal<T...>) -> (),
	GetConnections: (self: Signal<T...>) -> { Connection },
	Destroy: (self: Signal<T...>) -> (),
	Wait: (self: Signal<T...>) -> T...,
}

-- Traits:
export type Net = {
	Name: string,

	_Pool: { RemoteEvent | RemoteFunction | Signal<any> },

	SerializePacket: (...any) -> { string | Instance },
	DeserializePacket: (Packet: { string | Instance }) -> { any },

	WaitFor: (self: Net, Name: string, Timeout: number?) -> (RemoteEvent | RemoteFunction | Signal<any>)?,

	CreateSignal: (self: Net, Name: string) -> Signal<any>?,
	CreateEvent: (self: Net, Name: string, IsUnreliable: boolean?) -> (RemoteEvent | UnreliableRemoteEvent)?,
	CreateFunction: (self: Net, Name: string) -> RemoteFunction?,

	Connect: (self: Net, Name: string, Callback: (...any) -> ()) -> (RBXScriptConnection | Connection)?,
	Bind: (self: Net, Name: string, Callback: (...any) -> ()) -> (),

	Fire: (self: Net, Name: string, ...any) -> (),
	Invoke: (self: Net, Name: string, ...any) -> any,
}

return {}
