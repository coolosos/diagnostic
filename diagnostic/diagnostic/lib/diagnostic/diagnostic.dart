library diagnostic;

import 'dart:async';

import 'diagnostic_options.dart';
import 'diagnostic_params.dart';

export 'diagnostic_options.dart';
export 'diagnostic_params.dart';

abstract interface class Diagnostic {
  const Diagnostic({required this.options});

  final DiagnosticOption options;

  Future<void> init();

  FutureOr<void> captureException({
    required covariant DiagnosticExpection exception,
  });

  FutureOr<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  });

  FutureOr<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  });

  Future<void> dispose();
}
