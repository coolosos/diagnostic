import 'package:diagnostic/diagnostic.dart';

final class AwesomeDiagnostic implements Diagnostic {
  const AwesomeDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  @override
  Future<void> init() async {
    print('AwesomeDiagnostic initialized');
  }

  @override
  Future<void> captureException({
    required covariant DiagnosticException exception,
  }) async {
    print('Captured exception: ${exception.throwable}');
  }

  @override
  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  }) async {
    print(
      'Analytic event: ${event.name}, type: ${event.diagnosticAnalyticType}, parameters: ${event.parameters}',
    );
  }

  @override
  Future<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  }) async {
    print(
      'Log event: ${event.name}, level: ${event.level}, category: ${event.category}',
    );
  }

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {
    print(
      'Consent mode updated: measurement=$measurement, advertising=$advertising',
    );
  }

  @override
  Future<void> setUserProperties({
    required Map<String, String> properties,
  }) async {
    print('User properties: $properties');
  }
}

Future<void> main() async {
  const diagnostic = AwesomeDiagnostic(
    options: DiagnosticOption(
      mustCaptureExceptions: true,
      mustSendLogsEvents: true,
      mustSendAnalyticsEvents: true,
    ),
  );

  final manager = DiagnosticManager(
    diagnostics: [diagnostic],
    options: DiagnosticManagerOption(
      mustInitializeDiagnostics: true,
      mustCaptureExceptions: true,
      mustSendLogsEvents: true,
      mustSendAnalyticsEvents: true,
    ),
  );

  await manager.init();
  await manager.setUserConsentMode(measurement: true, advertising: false);

  await manager.captureException(
    exception: const DiagnosticException(
      throwable: 'Example exception',
      stackTrace: null,
      level: DiagnosticLevel.error,
    ),
  );

  await manager.sendAnalyticEvent(
    event: const DiagnosticAnalyticEvent(
      name: 'example_event',
      diagnosticAnalyticType: DiagnosticAnalyticType.measurement,
      parameters: {'source': 'example'},
    ),
  );

  await manager.sendLogEvent(
    event: const DiagnosticLogsEvent(
      name: 'button_pressed',
      level: DiagnosticLevel.info,
      category: 'example',
    ),
  );

  await manager.setUserProperties(properties: {'user_id': '12345'});
}
