///Contains the send/capture options
///
///This bool must be check in the required function for send or not the information
///to the sdk
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
