## 1.3.0

 - **FIX**: Update CHANGELOG files for diagnostic and flutter_diagnostic packages to reflect recent changes and improvements. ([34a8da3c](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/34a8da3c40f384bc1820dff54fe6bbde21ca94d4))
 - **FIX**: Update README files for diagnostic and flutter_diagnostic packages to enhance clarity and structure. ([e823b4d5](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/e823b4d52357df1323b0b9ca17270faac1d3412c))
 - **FIX**: Update package descriptions and Flutter SDK constraints in pubspec.yaml. ([d535fd73](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/d535fd73c1f48341db22216d4a8531036dbdcd90))
 - **FEAT**: Add test dependencies and implement diagnostic tests for Flutter and Dart packages. ([868d8129](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/868d8129065518680b00f40105021a2c136c3e11))
 - **FEAT**: Restructure diagnostic package and add Flutter support. ([44ae4d47](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/44ae4d472708b7a53d5a012ff783c84d5b2fb263))

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