base class DiagnosticOption {
  const DiagnosticOption({
    required this.mustCaptureExceptions,
    required this.mustSendLogsEvents,
    required this.mustSendAnalyticsEvents,
  });

  final bool mustCaptureExceptions;
  final bool mustSendLogsEvents;
  final bool mustSendAnalyticsEvents;
}
