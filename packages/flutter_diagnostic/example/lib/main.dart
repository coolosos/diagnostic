import 'package:flutter/material.dart' hide DiagnosticLevel;
import 'package:flutter_diagnostic/flutter_diagnostic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final manager = FlutterDiagnosticManager(
    diagnostics: [
      AwesomeFlutterDiagnostic(
        options: DiagnosticManagerOption(
          mustInitializeDiagnostics: true,
          mustCaptureExceptions: true,
          mustSendLogsEvents: true,
          mustSendAnalyticsEvents: true,
        ),
      ),
    ],
    options: DiagnosticManagerOption(
      mustInitializeDiagnostics: true,
      mustCaptureExceptions: true,
      mustSendLogsEvents: true,
      mustSendAnalyticsEvents: true,
    ),
    screenRecord: (child) => child,
  );

  await manager.init();
  await manager.setUserConsentMode(measurement: true, advertising: false);

  runApp(MyApp(manager: manager));
}

final class AwesomeFlutterDiagnostic implements FlutterDiagnostic {
  const AwesomeFlutterDiagnostic({required this.options});

  @override
  final DiagnosticOption options;

  @override
  Future<void> init() async {
    debugPrint('AwesomeFlutterDiagnostic initialized');
  }

  @override
  Future<void> captureException(
      {required covariant DiagnosticException exception}) async {
    debugPrint('Captured Flutter exception: ${exception.throwable}');
  }

  @override
  Future<void> sendAnalyticEvent(
      {required covariant DiagnosticAnalyticEvent event}) async {
    debugPrint('Flutter analytic event: ${event.name}');
  }

  @override
  Future<void> sendLogEvent(
      {required covariant DiagnosticLogsEvent event}) async {
    debugPrint('Flutter log event: ${event.name}');
  }

  @override
  Future<void> setUserConsentMode(
      {required bool measurement, required bool advertising}) async {
    debugPrint(
        'Flutter consent mode: measurement=$measurement, advertising=$advertising');
  }

  @override
  Future<void> setUserProperties(
      {required Map<String, String> properties}) async {
    debugPrint('Flutter user properties: $properties');
  }

  @override
  RouteObserver? navigatorObserver(
      {required String? Function(RouteSettings? route) nameExtractor}) {
    return RouteObserver<Route>();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({required this.manager, super.key});

  final FlutterDiagnosticManager manager;

  @override
  Widget build(BuildContext context) {
    final observers = manager
        .navigatorObservers(nameExtractor: (settings) => settings?.name)
        ?.cast<NavigatorObserver>();

    return MaterialApp(
      title: 'flutter_diagnostic example',
      navigatorObservers: observers ?? const <NavigatorObserver>[],
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_diagnostic example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await manager.sendAnalyticEvent(
                    event: const DiagnosticAnalyticEvent(
                      name: 'example_screen_view',
                      diagnosticAnalyticType:
                          DiagnosticAnalyticType.measurement,
                      parameters: {'screen': 'home'},
                    ),
                  );
                },
                child: const Text('Send analytic event'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  await manager.sendLogEvent(
                    event: const DiagnosticLogsEvent(
                      name: 'button_pressed',
                      level: DiagnosticLevel.info,
                      category: 'ui',
                    ),
                  );
                },
                child: const Text('Send log event'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  throw StateError('Example uncaught Flutter error');
                },
                child: const Text('Throw test exception'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
