///Generic exception param.
///
///This params contains the common diagnostic sdk exception.
///If custom implementation is needed you always can extend and required your
///custom exception in captureException function
base class DiagnosticExpection {
  const DiagnosticExpection({
    required this.throwable,
    required this.level,
    this.stackTrace,
    this.parameters,
  });

  final Object throwable;
  final StackTrace? stackTrace;
  final DiagnosticLevel level;
  final Map<String, String>? parameters;
}

///Generic analytic param.
///
///This params contains the common diagnostic sdk analytic.
///If custom implementation is needed you always can extend and required your
///custom exception in sendAnalyticEvent function
base class DiagnosticAnalyticEvent {
  const DiagnosticAnalyticEvent({required this.name, required this.parameters});

  final String name;
  final Map<String, String>? parameters;
}

///Generic event param.
///
///This params contains the common diagnostic sdk event.
///If custom implementation is needed you always can extend and required your
///custom exception in sendLogEvent function
base class DiagnosticLogsEvent {
  const DiagnosticLogsEvent({
    required this.level,
    required this.name,
    this.category,
    this.parameters,
  });

  final DiagnosticLevel level;
  final String name;
  final String? category;
  final Map<String, String>? parameters;
}

///Define the level event
enum DiagnosticLevel {
  ///Usually Develop information
  debug,

  ///Usually Tracking information
  info,

  ///Usually Failure information
  warning,

  ///Usually Uncontrol information
  error,

  ///Usually Fatal information
  fatal,
  ;

  T resolve<T>({
    required T onDebug,
    required T onInfo,
    required T onWarning,
    required T onError,
    required T onFatal,
  }) {
    switch (this) {
      case debug:
        return onDebug;
      case info:
        return onInfo;
      case warning:
        return onWarning;
      case error:
        return onError;
      case fatal:
        return onFatal;
    }
  }
}
