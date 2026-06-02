library;

import 'dart:async';

import 'package:meta/meta.dart';

import '../analytics.dart';
import '../diagnostic/diagnostic.dart';

export '../diagnostic/diagnostic.dart';

part 'diagnostic_options_manager.dart';

///Manage all the Diagnostic SDK on the project.
///Choose where is the better sdk for each function and filter if it is necessary.
base class DiagnosticManager implements Analytic {
  const DiagnosticManager({
    required List<Diagnostic> diagnostics,
    required this.options,
  }) : _diagnostics = diagnostics;

  ///List of diagnostic used in the current project.
  final List<Diagnostic> _diagnostics;

  ///Diagnostic must be use only in the extension of the manager and not outside the package.
  @protected
  List<Diagnostic> get diagnostics => _diagnostics;

  ///Provide the multiple options for manage the different diagnostics sdk.
  ///
  ///Contains also the bool options for send or not exception, event or logs.
  @override
  final DiagnosticManagerOption options;

  static bool consentModeMeasurement = false;
  static bool consentModeAdvertising = false;

  ///This function must be call at the beginning of the initialization.
  ///
  /// Calls all the [init] functions of each SDK provided in the [diagnostics] list.
  @override
  @mustCallSuper
  Future<void> init() async {
    if (!options.mustInitializeDiagnostics) return;
    final instances = _diagnostics.map((diagnostic) => diagnostic.init());
    await Future.wait(instances);
  }

  ///Send an exception with the custom informative implement to all the diagnostic.
  ///
  ///A [DiagnosticException] extension can be create if you need a
  ///custom information.
  @override
  @mustCallSuper
  Future<void> captureException({
    required covariant DiagnosticException exception,
  }) async {
    if (!options.mustCaptureExceptions || !consentModeMeasurement) {
      return;
    }

    for (final diagnostic in _diagnostics) {
      diagnostic.captureException(exception: exception).ignore();
    }
  }

  ///Send an analytic with the custom informative implement to all the diagnostic.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if you need a
  ///custom information.
  @override
  @mustCallSuper
  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  }) async {
    if (!options.mustSendAnalyticsEvents) return;

    final isEventValidToSend = event.diagnosticAnalyticType.resolve(
      onMeasurement: consentModeMeasurement,
      onAdvertising: consentModeAdvertising,
      onNeeded: true,
    );

    if (!isEventValidToSend) return;

    for (final diagnostic in _diagnostics) {
      diagnostic.sendAnalyticEvent(event: event).ignore();
    }
  }

  ///Send an log with the custom informative implement to all the diagnostic.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if you need a
  ///custom information.
  @override
  @mustCallSuper
  Future<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  }) async {
    if (!options.mustSendLogsEvents || !consentModeMeasurement) return;

    for (final diagnostic in _diagnostics) {
      diagnostic.sendLogEvent(event: event).ignore();
    }
  }

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {
    consentModeMeasurement = measurement;
    consentModeAdvertising = advertising;

    for (final diagnostic in _diagnostics) {
      diagnostic
          .setUserConsentMode(
            measurement: measurement,
            advertising: advertising,
          )
          .ignore();
    }
  }

  @override
  Future<void> setUserProperties({
    required Map<String, String> properties,
  }) async {
    for (final diagnostic in _diagnostics) {
      diagnostic.setUserProperties(properties: properties).ignore();
    }
  }
}
