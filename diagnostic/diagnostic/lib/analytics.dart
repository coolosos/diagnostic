import 'dart:async';

import 'diagnostic/diagnostic_options.dart';
import 'diagnostic/diagnostic_params.dart';

abstract interface class Analytic {
  const Analytic({required this.options});

  final DiagnosticOption options;

  Future<void> init();
  Future<void> captureException({
    required covariant DiagnosticException exception,
  });
  Future<void> sendLogEvent({required covariant DiagnosticLogsEvent event});

  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  });

  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  });

  Future<void> setUserProperties({required Map<String, String> properties});
}
