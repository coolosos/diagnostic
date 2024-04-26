part of "diagnostic_manager.dart";

///Contains the send/capture and initialice options
///
///When some of them are set to false Diagnostic will not be call his function
base class DiagnosticManagerOption extends DiagnosticOption {
  DiagnosticManagerOption({
    required super.mustCaptureExceptions,
    required super.mustSendLogsEvents,
    required super.mustSendAnalyticsEvents,
    required this.mustInitializeDiagnostics,
  });

  final bool mustInitializeDiagnostics;
}
