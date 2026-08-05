import 'package:diagnostic/diagnostic.dart';

import 'package:flutter/foundation.dart' hide DiagnosticLevel, DiagnosticsNode;
import 'package:flutter/widgets.dart' hide DiagnosticLevel, DiagnosticsNode;

import 'flutter_diagnostic.dart';

base class FlutterDiagnosticManager extends DiagnosticManager {
  const FlutterDiagnosticManager({
    required super.diagnostics,
    required super.options,
    required this.screenRecord,
  });

  ///Usually one or more of the diagnostic usually have a screen record for errors, but only one is recommend to use.
  ///
  ///Probably you can nest multiple diagnostic
  final Widget Function(Widget child)? screenRecord;

  ///This function must be call at the beginning of the initialization.
  ///
  ///Call all the [init] function of each sdk provide in the [diagnostic] list and
  ///track [FlutterError] and [PlatformDispatcher].
  @override
  Future<void> init() async {
    await super.init();

    FlutterError.onError = (details) {
      for (final diagnostic in diagnostics) {
        diagnostic.captureException(
          exception: DiagnosticException(
            level: DiagnosticLevel.error,
            throwable: details.exception,
            stackTrace: details.stack,
          ),
        );
      }
    };

    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      for (final diagnostic in diagnostics) {
        diagnostic.captureException(
          exception: DiagnosticException(
            level: DiagnosticLevel.error,
            throwable: exception,
            stackTrace: stackTrace,
          ),
        );
      }
      return false;
    };
  }

  ///Return all custom Route observer instantiate for your Flutter app.
  ///
  ///Usually a list of [RouteObserver] can be set in your WidgetApp/MaterialApp/CupertinoApp
  ///should be your entry point for track navigator changes
  @mustCallSuper
  List<RouteObserver<Route>>? navigatorObservers({
    required String? Function(RouteSettings? route) nameExtractor,
  }) {
    if (!options.mustInitializeDiagnostics) return null;

    return diagnostics
        .whereType<FlutterDiagnostic>()
        .map((e) => e.navigatorObserver(nameExtractor: nameExtractor))
        .whereType<RouteObserver>()
        .toList();
  }
}
