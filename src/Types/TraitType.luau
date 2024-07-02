--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[TraitType.luau]:
		Static types for traits.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Types:
-- Public:
export type TraitBase = {
	Apply: <S, T>(self: S, Module: T) -> S & T,
}

return {}
