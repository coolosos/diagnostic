# diagnostic

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Example](#example)
- [Usage](#usage)
- [License](#license)

## Overview

The `diagnostic` package provides a pure Dart interface for implementing diagnostic SDKs in a consistent way.

It defines:

- `Diagnostic`: a contract for exceptions, logs, analytics, consent, and user properties.
- `DiagnosticManager`: an orchestrator that initializes all diagnostics and forwards events to them.

## Getting Started

Implement the `Diagnostic` interface for your SDK.

```dart
import 'package:diagnostic/diagnostic/diagnostic.dart';
import 'package:diagnostic/diagnostic_manager/diagnostic_manager.dart';

final class AwesomeDiagnostic implements Diagnostic {
  const AwesomeDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  @override
  Future<void> init() async {
    // Initialize your SDK here.
  }

  @override
  Future<void> captureException({required DiagnosticException exception}) async {
    // Send exception information to the SDK.
  }

  @override
  Future<void> sendAnalyticEvent({required DiagnosticAnalyticEvent event}) async {
    // Send analytics event to the SDK.
  }

  @override
  Future<void> sendLogEvent({required DiagnosticLogsEvent event}) async {
    // Send log event to the SDK.
  }

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {
    // Update consent state in the SDK.
  }

  @override
  Future<void> setUserProperties({required Map<String, String> properties}) async {
    // Send user properties to the SDK.
  }
}
```

## Example

```dart
final manager = DiagnosticManager(
  diagnostics: [
    const AwesomeDiagnostic(
      options: DiagnosticOption(
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
    ),
  ],
  options: DiagnosticManagerOption(
    mustInitializeDiagnostics: true,
    mustCaptureExceptions: true,
    mustSendLogsEvents: true,
    mustSendAnalyticsEvents: true,
  ),
);

await manager.init();

await manager.captureException(
  exception: const DiagnosticException(
    throwable: Exception('Something went wrong'),
    level: DiagnosticLevel.error,
  ),
);

await manager.sendAnalyticEvent(
  event: const DiagnosticAnalyticEvent(
    name: 'user_signup',
    diagnosticAnalyticType: DiagnosticAnalyticType.measurement,
    parameters: {'method': 'email'},
  ),
);

await manager.sendLogEvent(
  event: const DiagnosticLogsEvent(
    name: 'button_click',
    level: DiagnosticLevel.info,
    category: 'ui',
  ),
);

await manager.setUserConsentMode(measurement: true, advertising: false);
await manager.setUserProperties(properties: {'user_id': '12345'});
```

## Usage

`DiagnosticManager` helps you control initialization and event forwarding from a single place. It also supports:

- exception capture
- analytics events
- log events
- consent mode management
- user property updates

## Example directory

A runnable example is available in the `example/` directory:

```bash
cd packages/diagnostic/example
dart pub get
dart run bin/main.dart
```

## License

MIT © Coolosos

