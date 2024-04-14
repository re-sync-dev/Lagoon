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