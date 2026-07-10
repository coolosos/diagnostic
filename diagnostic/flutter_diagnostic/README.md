## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
  - [Pure Dart Implementation](#pure-dart-implementation)
  - [Flutter Extension (Optional)](#flutter-extension-optional)
- [License](#license)

<br>

## Overview

Using multiple diagnostic tools (such as Firebase Analytics, Sentry, CloudWatch, or Datadog) and switching between them is a common practice in software development. However, migrating or managing multiple SDKs often causes headaches because they are handled in very different ways.

This package provides a **pure Dart, UI-agnostic interface** to standardize different diagnostic SDKs, making it seamless to add, remove, or swap tracking tools without changing your core business logic.

It features a robust `DiagnosticManager` that unifies all diagnostics under a single orchestrator, handling initialization, GDPR compliance/User Consent filtering, and event broadcasting out of the box.

## Getting Started

The first step is to implement the `Diagnostic` interface for your specific tracking SDK.

```dart
import 'package:complicate_diagnostic_tool/complicate_diagnostic_tool.dart';
import 'package:your_diagnostic_package/your_diagnostic_package.dart';

final class AwesomeDiagnostic implements Diagnostic {
  const AwesomeDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  ComplicateDiagnosticTool get _sdk => ComplicateDiagnosticTool.instance;

  @override
  Future<void> init() async {
    await ComplicateDiagnosticTool.initializeApp(
      options: options.defaultComplicateOptions,
    );
  }

  @override
  Future<void> captureException({required DiagnosticException exception}) async {
    // Basic options check is handled by the manager, but you can add custom logic
    await _sdk.captureException(
      exception.throwable,
      stackTrace: exception.stackTrace,
    );
  }

  @override
  Future<void> sendAnalyticEvent({required DiagnosticAnalyticEvent event}) async {
    await _sdk.logEvent(
      name: event.name,
      parameters: event.parameters,
    );
  }

  @override
  Future<void> sendLogEvent({required DiagnosticLogsEvent event}) async {
    await _sdk.logEvent(
      name: event.name,
      parameters: {
        'category': event.category ?? 'event.track',
        'level': event.level.name,
        ...(event.parameters ?? {}),
      },
    );
  }

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {
    await _sdk.setConsent(
      analytics: measurement,
      ads: advertising,
    );
  }

  @override
  Future<void> setUserProperties({required Map<String, String> properties}) async {
    await _sdk.setCustomKeys(properties);
  }

  @override
  Future<void> dispose() async {
    await _sdk.closeStreams();
  }
}

Once it is initialized, it can be used by instantiating the class and launching the init function before its use through a FlutterDiagnosticManager.

FlutterDiagnosticManager already has a basic implementation of how it works so that it can be used in the project directly by providing it with a list of Diagnostic. You can also extend the FlutterDiagnosticManager if other behavior is desired.

## Usage

Once the FlutterDiagnostic and/or its FlutterDiagnosticManager have been created, the different tools can be used with the same interface, facilitating their use and future changes.


## License

MIT © Coolosos