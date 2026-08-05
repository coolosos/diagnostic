# flutter_diagnostic

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Flutter usage](#flutter-usage)
- [License](#license)

## Overview

The `flutter_diagnostic` package extends the core `diagnostic` package with Flutter-specific integrations.

It adds:

- `FlutterDiagnostic`: a Flutter-aware version of `Diagnostic`.
- `FlutterDiagnosticManager`: a manager that captures Flutter framework and platform errors automatically and provides navigator observers.

## Getting Started

Create a `FlutterDiagnostic` implementation for your Flutter tracking SDK.

```dart
import 'package:flutter_diagnostic/flutter_diagnostic/flutter_diagnostic.dart';
import 'package:flutter_diagnostic/flutter_diagnostic_manager/flutter_diagnostic_manager.dart';

final class AwesomeFlutterDiagnostic implements FlutterDiagnostic {
  const AwesomeFlutterDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  @override
  Future<void> init() async {
    // Initialize your Flutter diagnostic SDK here.
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
    // Update user properties in the SDK.
  }

  @override
  RouteObserver? navigatorObserver({
    required String? Function(RouteSettings? route) nameExtractor,
  }) {
    return RouteObserver<Route>();
  }
}

## Flutter usage

```dart
final manager = FlutterDiagnosticManager(
  diagnostics: [
    const AwesomeFlutterDiagnostic(
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
  screenRecord: (child) => child,
);

await manager.init();

final observers = manager.navigatorObservers(
  nameExtractor: (settings) => settings?.name,
);
```

`FlutterDiagnosticManager` automatically registers `FlutterError.onError` and `PlatformDispatcher.instance.onError`. The `navigatorObservers` method returns route observers from diagnostics that implement `FlutterDiagnostic`.

## License

MIT © Coolosos
