## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [License](#license)
<br>

## Overview

Using diagnostic tools such as Firebase Analytic with Firebase Crashlytics, Sentry, CloudWatch or others or interchanging between them is a common practice in software development. Switching from one sdk to another often causes headaches as they are used or handled in very different ways.

For this purpose there is this development package, it provides an interface for the implementation of the different sdk, favoring the change and/or the use between them.

For the multiple use it is also provided a FlutteDiagnosticManager that is in charge of initializing all the FlutteDiagnostic of a project and send the events to each one of them.

Translated with DeepL.com (free version)

## Getting Started

The first step is to implement the FlutteDiagnostic interface for the corresponding diagnostic sdk.

```dart
import 'package:complicate_diagnostic_tool/complicate_diagnostic_tool.dart';

final class AwesomeDiagnostic implements FlutterDiagnostic {
    const AwesomeDiagnostic({required this.options});

    ...

    ComplicateDiagnosticTool get _diagnostic => ComplicateDiagnosticTool.instance;

    @override
    Future<void> init() async {
      await ComplicateDiagnosticTool.initializeApp(
        options: options.defaultComplicateOptions,
      );
    }

    @override
    RouteObserver<Route>? navigatorObserver({
      required String? Function(RouteSettings? route) nameExtractor,
    }) =>
        ComplicateDiagnosticToolObserver(
          analytics: _diagnostic,
          nameExtractor: nameExtractor,
        );

    @override
    FutureOr<void> captureException({required DiagnosticExpection exception}) {
      if (!options.mustCaptureExceptions) return null;

      _diagnostic.captureException( exception,
          stackTrace: stackTrace,
          withScope: (scope) {
            arguments?.forEach((key, value) {
              scope.setTag(key, value);
            });
          },
        );
    }

    @override
    FutureOr<void> sendAnalyticEvent({required DiagnosticAnalyticEvent event}) {
      if (!options.mustSendAnalyticsEvents) return null;

      _diagnostic.logEvent(
        name: event.name,
        parameters: event.parameters,
      );
    }

    @override
    FutureOr<void> sendLogEvent({required DiagnosticLogsEvent event}) {
      if (!options.mustSendLogsEvents) return null;

      _diagnostic.logEvent(
        name: event.name,
        parameters: {
          'category': event.category ?? 'event.track',
          'level': event.level.name,
          ...(event.parameters ?? {}),
          ...(_defaultParameters ?? {}),
        },
      );
    }

}
```

Once it is initialized, it can be used by instantiating the class and launching the init function before its use through a FlutteDiagnosticManager.

FlutteDiagnosticManager already has a basic implementation of how it works so that it can be used in the project directly by providing it with a list of Diagnostic. You can also extend the FlutteDiagnosticManager if other behavior is desired.

## Usage

Once the FlutteDiagnostic and/or its FlutteDiagnosticManager have been created, the different tools can be used with the same interface, facilitating their use and future changes.


## License

MIT © Coolosos