# 1.1.1
Export diagnostic package from flutter_diagnostic

# 1.1.0
Modularization and architecture decoupling

## What's Changed
* refactor: 🛡️ Decoupled core `DiagnosticManager` from Flutter dependencies into 100% pure Dart.
* feat: 🔌 Added capability pattern by introducing the `FlutterRouteDiagnostic` interface.
* feat: 📱 Added `FlutterDiagnosticManager` to isolate automatic UI error catching (`FlutterError`, `PlatformDispatcher`) and route observers.
* refactor: 🧹 Removed generic types (`<T extends Diagnostic>`) from managers to leverage true polymorphism.
* fix: 🔒 Updated internal asynchronous event loops with modern `.ignore()` patterns for safer telemetry broadcasting.
* chore: 📝 Rewrote README documentation with distinct pure Dart and Flutter implementation guides.

# 1.0.0
First package integration
## What's Changed
* feat: ✨ Added diagnostic base and interface