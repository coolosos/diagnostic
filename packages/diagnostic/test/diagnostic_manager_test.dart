import 'package:diagnostic/diagnostic.dart';
import 'package:test/test.dart';

class _FakeDiagnostic implements Diagnostic {
  _FakeDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  bool didInit = false;
  DiagnosticException? capturedException;
  DiagnosticAnalyticEvent? analyticEvent;
  DiagnosticLogsEvent? logEvent;
  bool userConsentCalled = false;
  Map<String, String>? userProperties;

  @override
  Future<void> init() async {
    didInit = true;
  }

  @override
  Future<void> captureException({
    required covariant DiagnosticException exception,
  }) async {
    capturedException = exception;
  }

  @override
  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  }) async {
    analyticEvent = event;
  }

  @override
  Future<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  }) async {
    logEvent = event;
  }

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {
    userConsentCalled = true;
  }

  @override
  Future<void> setUserProperties({
    required Map<String, String> properties,
  }) async {
    userProperties = properties;
  }
}

void main() {
  setUp(() {
    DiagnosticManager.consentModeMeasurement = false;
    DiagnosticManager.consentModeAdvertising = false;
  });

  test('DiagnosticManager.init initializes each diagnostic when allowed',
      () async {
    final diagnostic = _FakeDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: true,
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

    expect(diagnostic.didInit, isTrue);
  });

  test(
      'captureException forwards only when capture is enabled and measurement consent is granted',
      () async {
    final diagnostic = _FakeDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: true,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: false,
      ),
    );

    final manager = DiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: true,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: false,
      ),
    );

    DiagnosticManager.consentModeMeasurement = true;
    await manager.captureException(
      exception: DiagnosticException(
        throwable: Exception('test'),
        stackTrace: StackTrace.current,
        level: DiagnosticLevel.error,
      ),
    );

    expect(diagnostic.capturedException, isNotNull);
    expect(diagnostic.capturedException?.throwable, isException);
  });

  test('sendAnalyticEvent respects analytic type and consent mode', () async {
    final diagnostic = _FakeDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: true,
      ),
    );

    final manager = DiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: true,
      ),
    );

    DiagnosticManager.consentModeMeasurement = false;
    DiagnosticManager.consentModeAdvertising = false;

    await manager.sendAnalyticEvent(
      event: const DiagnosticAnalyticEvent(
        name: 'needed_event',
        diagnosticAnalyticType: DiagnosticAnalyticType.needed,
        parameters: {'key': 'value'},
      ),
    );

    expect(diagnostic.analyticEvent, isNotNull);
    expect(diagnostic.analyticEvent?.name, equals('needed_event'));

    diagnostic.analyticEvent = null;
    await manager.sendAnalyticEvent(
      event: const DiagnosticAnalyticEvent(
        name: 'measurement_event',
        diagnosticAnalyticType: DiagnosticAnalyticType.measurement,
        parameters: {},
      ),
    );

    expect(diagnostic.analyticEvent, isNull);
  });

  test(
      'sendLogEvent forwards only when logs are enabled and measurement consent is granted',
      () async {
    final diagnostic = _FakeDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: false,
      ),
    );

    final manager = DiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: false,
      ),
    );

    DiagnosticManager.consentModeMeasurement = true;
    await manager.sendLogEvent(
      event: const DiagnosticLogsEvent(
        level: DiagnosticLevel.info,
        name: 'info_log',
      ),
    );

    expect(diagnostic.logEvent, isNotNull);
    expect(diagnostic.logEvent?.name, equals('info_log'));
  });

  test('setUserConsentMode and setUserProperties propagate to all diagnostics',
      () async {
    final diagnostic = _FakeDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: false,
      ),
    );

    final manager = DiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: false,
        mustSendLogsEvents: false,
        mustSendAnalyticsEvents: false,
      ),
    );

    await manager.setUserConsentMode(measurement: true, advertising: true);
    await manager.setUserProperties(properties: {'foo': 'bar'});

    expect(diagnostic.userConsentCalled, isTrue);
    expect(diagnostic.userProperties, equals({'foo': 'bar'}));
  });
}
