## 1.5.0
- Strict mode is now the standard throughout src
- Removed Fatal as a log type
- Renamed LogContext and references to it to LogType
- Added Debug/* to LogType
- Fixed some bugs found in Network trait
- Fixed type warnings in the Network trait
- Fixed type warnings in the Logger trait
- Changed log format from Module(CONTEXT) -> Module.CallingFunc:Line
- Added doc section for the logger trait
- Added doc section for the network trait
- Updated portions of intro page in docs
- Updated potions of getting-started page in docs
- Removed aftman tool in favor of rokit

## 1.4.6
- Function `Lagoon.Load` now takes a second optional argument `ShouldTime` which will provide the time each module took to load
- Added folder based module loading
- Added module depth constraint
- Updated docs

## 1.4.5
- Completely removed the Trait base class (Unneeded & complicated trait creation for no good reason)
- Loaded traits can now be directly accessed from `Lagoon.Traits`
- Added `:Get` method to the Network trait (functions almost the same as the old `:WaitFor`)
- `:WaitFor` now wraps around `:Get`, it has the same signature only difference is when it calls `:Get` it will ensure there is a timeout.
- Removed properties `.Connection`, `.Handlers`, and `.IsAttached` from `PoolItem`
- `:Connect` now functions much closer to normal remotes previously it return a universal connection to the remote/signal which can obviously cause problems so is now remedied.
- `:Bind` now returns a function to unbind the callback from a RemoteFunction, this is more syntax sugar than anything doesn't really serve a technical purpose aside from QoL
- Remotes can now be added to the Remotes folder without being included in the pool using the `NoPool` attribute
- Updated the network type to reflect trait changes
- Controllers & services are now derived from a base module class (There is no difference between controllers & services they are just there for compatibility)
- Fixed middleware bug
- Added `Lagoon.Wrap` which allows modules to be integrated into the lagoon environment without conforming to an architecture
- `Lagoon.MakeService` and `Lagoon.MakeController` now wraps around the `Lagoon.Wrap` function and has context checks to maintain the 'Service' and 'Controller' architecture (Checking if the script is running on the client or server)
- Updated docs to reflect version changes
- Removed Network/Serializer
- Removed Network/JSON
- Removed Squash dependency
- Switched signal dependency to [LemonSignal](https://data-oriented-house.github.io/LemonSignal/)

## 1.4.4
- `Lagoon.Load` accepts both an Instance and array of instances
- Middleware callbacks are now provided an argument table so data can be manipulated in the middleware without a work around.
- Fixed middleware issue where BindableFunction will not call Outbound middleware
- Updated documentation info regarding services & controllers, as well as what Lagoon is about.

## 1.4.3
- RemoteEvents and RemoteFunction can now be added to the pool even after runtime (old behavior required you to use `:WaitFor` in order to add the Event/Function to the pool)
- Switched to [rokit](https://github.com/rojo-rbx/rokit)
- Removed 'Net' compatibility redirect
- `Lagoon.Load` now accepts an array of modules rather than just the parent script (type is Array of Instance because Roblox can be funky about certain type conversions)

## 1.4.2
- Fixed issue with `:Once` that would disconnect the main handler connection when a request was received.

## 1.4.0
- Removed Trait:Apply due to type clutter & general complexity concerns
- `Service:ApplyTrait` & `Controller:ApplyTrait` no longer use Trait:Apply and have gone back to the original way traits were applied
- Net & NetTrait renamed to Network
- Split up the Network Serialization logic into a separate module.
- Fixed issues with table serialization
- Updated NetworkType to reflect the changes made to the trait.
- Added the `:Once` method to the Network trait (Disconnects after one request has been received)
- Added the `:AddMiddleware` method to the Network
- Modified the Network's pool structure to use [Pool Items](/Lagoon/api/Network#NetworkPoolItem%3CT%3E)
- Added `dev` folder to .gitignore
- Added internal trait redirects for backwards compatibility for older traits (I.E. Net -> Network)
- Services & Controllers now have their names automatically applied at construction
- Logger now supports the automatic service and controller names (Setting the logging name using LogOptions still works.)
- Added warning for Key overlapping upon trait application
- Updated examples using the Network & Logger traits
- Added [this page](/Lagoon/docs/limitations) dedicated to the limitations of Lagoon
- Added additional info about minimally using Lagoon on the [intro page](/Lagoon/docs/intro#do-i-need-to-wrap-everything-in-the-lagoon-api)
- Temporarily removed Lagoon icon
- Updated aftman package versions

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