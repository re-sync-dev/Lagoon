--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[Generic.luau]:
		Generic / utility types

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
-- Generic:
export type Array<T> = { T }
export type Dictionary<T> = { [string]: T }

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

return {}
