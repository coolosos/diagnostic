library diagnostic_manager;

import 'dart:async';

import 'package:meta/meta.dart';

import '../diagnostic/diagnostic.dart';

export "../diagnostic/diagnostic.dart";

part "diagnostic_options_manager.dart";

///Manage all the Diagnostic SDK on the project.
///Choose where is the better sdk for each function and filter if it is neccesary.
///
///Generic can be provide for change the type of Diagnostic use in the project
base class DiagnosticManager<T extends Diagnostic> implements Diagnostic {
  const DiagnosticManager({
    required List<T> diagnostics,
    required this.options,
  }) : _diagnostics = diagnostics;

  ///List of diagnostic used in the current project.
  final List<T> _diagnostics;

  ///Diagnostic must be use only in the extension of the manager and not outside the package.
  @protected
  List<T> get diagnostic => _diagnostics;

  ///Provide the multiple options for manage the diferent diagnostics sdk.
  ///
  ///Contains also the bool options for send or not exception, event or logs.
  @override
  final DiagnosticManagerOption options;

  ///This function must be call at the begining of the initilalization.
  ///
  ///Call all the [init] function of each sdk provide in the [diagnostic] list.
  @override
  @mustCallSuper
  Future<void> init() async {
    if (!(options.mustInitializeDiagnostics)) return;

    final instanciates =
        Future.wait(_diagnostics.map((diagnostic) => diagnostic.init()));

    await instanciates;
  }

  ///Send an exception with the custom informate implement to all the diagnostic.
  ///
  ///A [DiagnosticExpection] extension can be create if you need a
  ///custom information.
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

  ///Send an analytic with the custom informate implement to all the diagnostic.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if you need a
  ///custom information.
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

  ///Send an log with the custom informate implement to all the diagnostic.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if you need a
  ///custom information.
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

  ///This function must be call before the instance is created an usually have close streams or dispose clients.
  @override
  @mustCallSuper
  Future<void> dispose() {
    final disposables = _diagnostics.map((diagnostic) => diagnostic.dispose());
    return Future.wait(disposables);
  }
}
