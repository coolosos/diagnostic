part of "diagnostic_manager.dart";

base class DiagnosticManagerOption extends DiagnosticOption {
  DiagnosticManagerOption({
    required super.mustCaptureExceptions,
    required super.mustSendLogsEvents,
    required super.mustSendAnalyticsEvents,
    required this.mustInitializeDiagnostics,
  });

  final bool mustInitializeDiagnostics;
}
