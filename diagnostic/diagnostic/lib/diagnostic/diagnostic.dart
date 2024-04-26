library diagnostic;

import 'dart:async';

import 'diagnostic_options.dart';
import 'diagnostic_params.dart';

export 'diagnostic_options.dart';
export 'diagnostic_params.dart';

///Interface for manage differents diagnostics tool as Firebase/Sentry/Cloudwatch.
///
///Provide a common interface for manage the different SDK.
abstract interface class Diagnostic {
  const Diagnostic({required this.options});

  ///Provide the multiple options for initialize or manage the diagnostic sdk
  ///
  ///Contains also the bool options for send or not exception, event or logs.
  final DiagnosticOption options;

  ///This function must be call at the begining of the initilalization.
  ///
  ///Usually set the sdk with the needed options
  Future<void> init();

  ///Send an exception with the custom informate implement.
  ///Should check for the class runtime if filter is required.
  ///
  ///A [DiagnosticExpection] extension can be create if the sdk need or have
  ///custom information
  FutureOr<void> captureException({
    required covariant DiagnosticExpection exception,
  });

  ///Send an log with the custom informate implement.
  ///Should filter what level is not required.
  ///
  ///A [DiagnosticLogsEvent] extension can be create if the sdk need or have
  ///custom information
  FutureOr<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  });

  ///Send an analyticEvent with the custom informate implement.
  ///Should filter what level is not required.
  ///
  ///A [DiagnosticAnalyticEvent] extension can be create if the sdk need or have
  ///custom information
  FutureOr<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  });

  ///This function must be call before the instance is created an usually have close streams or dispose clients
  Future<void> dispose();
}
