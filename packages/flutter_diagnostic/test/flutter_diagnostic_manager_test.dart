import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_diagnostic/flutter_diagnostic.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeFlutterDiagnostic implements FlutterDiagnostic {
  _FakeFlutterDiagnostic({required this.options, required this.observer});

  @override
  final DiagnosticOption options;
  final RouteObserver<Route> observer;
  int captureExceptionCount = 0;
  DiagnosticException? lastException;

  @override
  Future<void> init() async {}

  @override
  Future<void> captureException({
    required covariant DiagnosticException exception,
  }) async {
    captureExceptionCount += 1;
    lastException = exception;
  }

  @override
  Future<void> sendAnalyticEvent({
    required covariant DiagnosticAnalyticEvent event,
  }) async {}

  @override
  Future<void> sendLogEvent({
    required covariant DiagnosticLogsEvent event,
  }) async {}

  @override
  Future<void> setUserConsentMode({
    required bool measurement,
    required bool advertising,
  }) async {}

  @override
  Future<void> setUserProperties({
    required Map<String, String> properties,
  }) async {}

  @override
  RouteObserver? navigatorObserver({
    required String? Function(RouteSettings? route) nameExtractor,
  }) {
    return observer;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('navigatorObservers returns observers when diagnostics are initialized',
      () {
    final observer = RouteObserver<Route>();
    final diagnostic = _FakeFlutterDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: true,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      observer: observer,
    );

    final manager = FlutterDiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: true,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      screenRecord: (child) => child,
    );

    final observers = manager.navigatorObservers(nameExtractor: (_) => 'test');

    expect(observers, isNotNull);
    expect(observers, contains(same(observer)));
  });

  test('navigatorObservers returns null when initialization is disabled', () {
    final diagnostic = _FakeFlutterDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      observer: RouteObserver<Route>(),
    );

    final manager = FlutterDiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: false,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      screenRecord: (child) => child,
    );

    expect(manager.navigatorObservers(nameExtractor: (_) => 'test'), isNull);
  });

  testWidgets('init registers Flutter error handlers and forwards exceptions',
      (WidgetTester tester) async {
    final observer = RouteObserver<Route>();
    final diagnostic = _FakeFlutterDiagnostic(
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: true,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      observer: observer,
    );

    final manager = FlutterDiagnosticManager(
      diagnostics: [diagnostic],
      options: DiagnosticManagerOption(
        mustInitializeDiagnostics: true,
        mustCaptureExceptions: true,
        mustSendLogsEvents: true,
        mustSendAnalyticsEvents: true,
      ),
      screenRecord: (child) => child,
    );

    final previousFlutterOnError = FlutterError.onError;
    final previousPlatformOnError = PlatformDispatcher.instance.onError;
    try {
      await manager.init();

      FlutterError.onError!(
        FlutterErrorDetails(
          exception: Exception('flutter_error'),
          stack: StackTrace.current,
        ),
      );

      final platformResult = PlatformDispatcher.instance.onError!(
        Exception('platform_error'),
        StackTrace.current,
      );

      expect(diagnostic.captureExceptionCount, equals(2));
      expect(diagnostic.lastException?.throwable, isA<Exception>());
      expect(platformResult, isFalse);
    } finally {
      FlutterError.onError = previousFlutterOnError;
      PlatformDispatcher.instance.onError = previousPlatformOnError;
    }
  });
}
