# Changelog

All notable changes to this project will be documented in this file.

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