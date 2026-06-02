import 'dart:async';

import '../analytics.dart';
import 'diagnostic_options.dart';
import 'diagnostic_params.dart';

export 'diagnostic_options.dart';
export 'diagnostic_params.dart';

///Interface for manage different diagnostics tool as Firebase/Sentry/Cloudwatch.
///
///Provide a common interface for manage the different SDK.
abstract interface class Diagnostic implements Analytic {
  const Diagnostic({required this.options});

  ///Provide the multiple options for initialize or manage the diagnostic sdk
  ///
  ///Contains also the bool options for send or not exception, event or logs.
  @override
  final DiagnosticOption options;

  ///This function must be call at the beginning of the initialization.
  ///
  ///Usually set the sdk with the needed options
  @override
  Future<void> init();

  ///Send an exception with the custom informative implement.
  ///Should check for the class runtime if filter is required.
  ///
  ///A [DiagnosticException] extension can be create if the sdk need or have
  ///custom information
  @override
  Future<void> captureException({
    required covariant DiagnosticException exception,
  });

  ///Send an log with the custom informative implement.
  ///Should filter what level is not required.
  ///
  ///A [DiagnosticLogsEvent] extension can be create if the sdk need or have
  ///custom information
  @override
  Future<void> sendLogEvent({required covariant DiagnosticLogsEvent event});

  ///Send an analyticEvent with the custom informative implement.
  ///Should filter what level is not required.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if the sdk need or have
  ///custom information
  @override
  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  });

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  });
}
