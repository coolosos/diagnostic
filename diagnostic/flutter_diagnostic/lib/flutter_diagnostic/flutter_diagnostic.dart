import 'package:diagnostic/diagnostic/diagnostic.dart';
import 'package:flutter/widgets.dart';

///Interface for manage differents diagnostics tool as Firebase/Flutter_Sentry/Cloudwatch.
///
///Provide a common interface for manage the different flutter diagnostic SDK.
abstract interface class FlutterDiagnostic implements Diagnostic {
  ///Return a custom Route observer instanciate for your Flutter app.
  ///
  ///Usually a [RouteObserver] can be set in your WidgetApp/MaterialApp/CupertinoApp
  ///should be your entry point for track navigator changes
  RouteObserver? navigatorObserver({
    required String? Function(RouteSettings? route) nameExtractor,
  });
}
