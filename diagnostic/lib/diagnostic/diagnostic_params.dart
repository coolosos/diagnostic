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

base class DiagnosticAnalyticEvent {
  const DiagnosticAnalyticEvent({required this.name, required this.parameters});

  final String name;
  final Map<String, String>? parameters;
}

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

enum DiagnosticLevel {
  debug,
  info,
  warning,
  error,
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
