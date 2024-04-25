library diagnostic_manager;

import 'dart:async';

import 'package:flutter/foundation.dart' hide DiagnosticLevel, DiagnosticsNode;

import '../diagnostic/diagnostic.dart';

export "../diagnostic/diagnostic.dart";

part "diagnostic_options_manager.dart";

base class DiagnosticManager<T extends Diagnostic> implements Diagnostic {
  const DiagnosticManager({
    required List<T> diagnostics,
    required this.options,
  }) : _diagnostics = diagnostics;

  final List<T> _diagnostics;

  @protected
  List<T> get diagnostic => _diagnostics;

  @override
  final DiagnosticManagerOption options;

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
