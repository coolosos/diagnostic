## 1.4.1

* **FIX**: correct CHANGELOG entries.

## 1.4.0

 - **FIX**: format method signatures for consistency in FlutterDiagnostic implementation. ([bf484019](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/bf48401979f6bdc8d4a5ed8659d31937a82b2516))
 - **FIX**(docs): replace AUTHORS and LICENSE symlinks with real copies for web rendering. ([ae621764](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/ae6217642c0bb2ba20bf2b1a01340d03dfa897ef))
 - **FEAT**: add example applications for diagnostic and flutter_diagnostic packages. ([c1fef8de](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/c1fef8de8cf26a4e90d13e6cb47257e53695ea7d))

## 1.3.0

 - **FIX**: Update CHANGELOG files for diagnostic and flutter_diagnostic packages to reflect recent changes and improvements. ([34a8da3c](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/34a8da3c40f384bc1820dff54fe6bbde21ca94d4))
 - **FIX**: Update README files for diagnostic and flutter_diagnostic packages to enhance clarity and structure. ([e823b4d5](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/e823b4d52357df1323b0b9ca17270faac1d3412c))
 - **FIX**: Update package descriptions and Flutter SDK constraints in pubspec.yaml. ([d535fd73](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/d535fd73c1f48341db22216d4a8531036dbdcd90))
 - **FEAT**: Add test dependencies and implement diagnostic tests for Flutter and Dart packages. ([868d8129](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/868d8129065518680b00f40105021a2c136c3e11))
 - **FEAT**: Restructure diagnostic package and add Flutter support. ([44ae4d47](https://github.com/coolosos/diagnostic/coolosos/diagnostic/commit/44ae4d472708b7a53d5a012ff783c84d5b2fb263))

## 1.2.0

* **feat**: Added unit and integration tests.
* **feat**: Improved internal file structure and location (`lib/src/`).
* **chore**: Updated package documentation and READMEs.

## 1.1.0

* **refactor**: Decoupled core `DiagnosticManager` from Flutter dependencies into 100% pure Dart.
* **refactor**: Removed generic types (`<T extends Diagnostic>`) from managers to leverage true polymorphism.
* **fix**: Updated internal asynchronous event loops with modern `.ignore()` patterns for safer telemetry broadcasting.
* **chore**: Rewrote README documentation with pure Dart implementation guides.

## 1.0.0

* **feat**: Initial release with core diagnostic interfaces and base implementations.