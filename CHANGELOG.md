## 1.3.0
- Added [Trait:Apply](/Lagoon/api/Trait#Apply) so non services/controllers can inherit traits as well
- Changed `Service:ApplyTrait` & `Controller:ApplyTrait` to use the newly added `Trait:Apply` method
- Added static type for the `TraitBase`
- Cleaned up the codebase a little bit (mostly making doc comments consistent)
- Renamed all files ending in .lua -> .luau
- Updated file headers to use .luau instead of .lua

## 1.2.0
- Added `Logger` trait
- Added static types for Logger Trait
- Added functions [Lagoon.Get](/Lagoon/api/Lagoon#Get) & [Lagoon.Load](/Lagoon/api/Lagoon#Load)
- Added file headers to files without them.
- Added `logger-trait` example
- Added `middleware` example
- Fixed middleware being called on separate threads
- Middleware is now set everytime `:CreateX` is called
- Fixed middleware being boundary locked
- Small code cleanup in the `Net` trait
- Removed old `Net` property

## 1.1.0
- Added server-side Networking middleware
	- Added compatibility for requests that are serialized
- Added static types for generics Array and Dictionary
- Separated type file and multiple different files for workspace cleanliness

## 1.0.7
- Separated `Net:CreateRemote` into `Net:CreateEvent` and `Net:CreateFunction`
- Added lazy loading for built-in traits to reduce bloating
- Added static typing for `Net`
- Updated `net-trait` example to use updated API

## 1.0.6
- Fixed bug with `NetTrait:WaitFor` that would yield for a remote and then not add the remote to the pool if it exists.
- Fixed old debugging relating code for `NetTrait` that was used in <1.0.0 versions.

## 1.0.1 - 1.0.5
- Fixes to Remote related methods
- Updated `NetTrait` description
- Updated documentation
- Added `net-trait` example

## 1.0.0
- Created docs page (https://re-sync-dev.github.io/Lagoon/)
- Added basic Lagoon usage examples
- Modified release action
- Added headers to the package files