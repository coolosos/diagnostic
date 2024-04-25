library diagnostic_manager;

import 'dart:async';

import 'package:flutter/foundation.dart' hide DiagnosticLevel, DiagnosticsNode;
import 'package:flutter/widgets.dart' hide DiagnosticLevel, DiagnosticsNode;

import '../diagnostic/diagnostic.dart';
import '../diagnostic_tool/diagnostic_tool.dart';

export "../diagnostic/diagnostic.dart";

part "diagnostic_options_manager.dart";

base class DiagnosticManager implements Diagnostic {
  const DiagnosticManager({
    required List<DiagnosticTool> diagnostics,
    required this.options,
    required this.screenRecord,
  }) : _diagnostics = diagnostics;

  final List<DiagnosticTool> _diagnostics;

  @override
  final DiagnosticManagerOption options;

  ///Usually one of the diagnostic usually have a screen record for errors.
  ///
  ///Probably you can anidate multiple diagnostic
  final Widget Function(Widget child)? screenRecord;

  ///initialice all diagnostic availables in the project
  @override
  @mustCallSuper
  Future<void> init() async {
    if (!(options.mustInitializeDiagnostics)) return;

    final instanciates =
        Future.wait(_diagnostics.map((diagnostic) => diagnostic.init()));

    await instanciates;

    FlutterError.onError = (details) {
      for (Diagnostic diagnostic in _diagnostics) {
        diagnostic.captureException(
          exception: DiagnosticExpection(
            level: DiagnosticLevel.error,
            throwable: details.exception,
            stackTrace: details.stack,
          ),
        );
      }
    };

    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      for (Diagnostic diagnostic in _diagnostics) {
        diagnostic.captureException(
          exception: DiagnosticExpection(
            level: DiagnosticLevel.error,
            throwable: exception,
            stackTrace: stackTrace,
          ),
        );
      }
      return false;
    };
  }

  ///Send the capture exception to diferent Diagnostic
  @override
  @mustCallSuper
  FutureOr<void> captureException({
    required covariant DiagnosticExpection exception,
  }) {
    if (!options.mustCaptureExceptions) return null;

    for (Diagnostic diagnostic in _diagnostics) {
      diagnostic.captureException(
        exception: exception,
      );
    }
  }

  ///Return the current RouteObserver availables in all the diagnostic
  @mustCallSuper
  List<RouteObserver<Route>>? navigatorObservers({
    required String? Function(RouteSettings? route) nameExtractor,
  }) {
    if (!(options.mustInitializeDiagnostics)) return null;

    return _diagnostics
        .map((e) => e.navigatorObserver(nameExtractor: nameExtractor))
        .whereType<RouteObserver>()
        .toList();
  }

  @override
  @mustCallSuper
  FutureOr<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  }) {
    if (!options.mustSendAnalyticsEvents) return null;

    for (Diagnostic diagnostic in _diagnostics) {
      diagnostic.sendAnalyticEvent(
        event: event,
      );
    }
  }

  @override
  @mustCallSuper
  FutureOr<void> sendLogEvent({required covariant DiagnosticLogsEvent event}) {
    if (!options.mustSendLogsEvents) return null;

    for (Diagnostic diagnostic in _diagnostics) {
      diagnostic.sendLogEvent(
        event: event,
      );
    }
  }

  @override
  @mustCallSuper
  Future<void> dispose() {
    final disposables = _diagnostics.map((diagnostic) => diagnostic.dispose());
    return Future.wait(disposables);
  }
}
