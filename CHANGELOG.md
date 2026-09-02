## 1.2.0

* **Breaking:** Removed the fixed `Flavor` enum. `EnvironmentConfig.init` now takes an `AppFlavor` interface instead — each consuming app declares its own flavor enum implementing `AppFlavor` (see README "Usage" section). `DependencyInjection` no longer depends on `Flavor.mock` directly; mock detection is now name-convention based via `EnvironmentConfig.isMockFlavor` (configurable through `mockFlavorName`/`productionFlavorName` params on `init`).

## 0.0.1

* TODO: Describe initial release.
