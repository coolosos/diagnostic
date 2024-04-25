import 'package:flutter/widgets.dart';

import '../diagnostic/diagnostic.dart';

abstract interface class DiagnosticTool implements Diagnostic {
  RouteObserver? navigatorObserver({
    required String? Function(RouteSettings? route) nameExtractor,
  });
}
