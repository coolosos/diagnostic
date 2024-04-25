import 'package:diagnostic/diagnostic/diagnostic.dart';
import 'package:flutter/widgets.dart';

abstract interface class FlutterDiagnostic implements Diagnostic {
  RouteObserver? navigatorObserver({
    required String? Function(RouteSettings? route) nameExtractor,
  });
}
