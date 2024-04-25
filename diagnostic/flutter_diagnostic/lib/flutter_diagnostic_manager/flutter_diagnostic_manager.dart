library diagnostic_manager;

import 'package:diagnostic/diagnostic_manager/diagnostic_manager.dart';
import 'package:flutter/widgets.dart' hide DiagnosticLevel, DiagnosticsNode;

import '../flutter_diagnostic/flutter_diagnostic.dart';

base class FlutterDiagnosticManager
    extends DiagnosticManager<FlutterDiagnostic> {
  const FlutterDiagnosticManager({
    required super.diagnostics,
    required super.options,
    required this.screenRecord,
  });

  ///Usually one of the diagnostic usually have a screen record for errors.
  ///
  ///Probably you can anidate multiple diagnostic
  final Widget Function(Widget child)? screenRecord;

  ///Return the current RouteObserver availables in all the diagnostic
  @mustCallSuper
  List<RouteObserver<Route>>? navigatorObservers({
    required String? Function(RouteSettings? route) nameExtractor,
  }) {
    if (!(options.mustInitializeDiagnostics)) return null;

    return diagnostic
        .map((e) => e.navigatorObserver(nameExtractor: nameExtractor))
        .whereType<RouteObserver>()
        .toList();
  }
}
