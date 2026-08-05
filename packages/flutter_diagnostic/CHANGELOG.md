# Changelog

All notable changes to the `flutter_diagnostic` package will be documented in this file.

## 1.2.0

* **feat**: Added unit and widget tests for Flutter bindings.
* **feat**: Improved internal file structure and location (`lib/src/`).
* **chore**: Updated package documentation and READMEs.

## 1.1.1

* **refactor**: Exported base `diagnostic` package directly from `flutter_diagnostic` to eliminate the need for secondary imports.

## 1.1.0

* **feat**: Introduced capability pattern via `FlutterRouteDiagnostic` interface.
* **feat**: Added `FlutterDiagnosticManager` to isolate automatic UI error catching (`FlutterError`, `PlatformDispatcher`) and route observers.
* **chore**: Rewrote documentation with dedicated Flutter implementation guides.

## 1.0.0

* **feat**: Initial release with Flutter diagnostic bindings.