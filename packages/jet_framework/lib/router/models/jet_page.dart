import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/router/guards/auth_guard.dart';
import 'package:jet_framework/router/models/jet_bindings_builder.dart';

class JetPage<T> extends GetPage<T> {
  final bool _initial;
  final bool authenticatedRoute;

  final List<JetGuard>? guards;
  final Function(JetInjector injector)? dependencies;

  JetPage({
    required super.name,
    required super.page,
    this.authenticatedRoute = false,
    this.dependencies,
    this.guards,
    super.parameters,
    super.title,
    super.customTransition,
    super.transitionDuration,
    super.children,
    super.arguments,
    bool initial = false,
  })  : _initial = initial,
        super(
          middlewares: [
            if (authenticatedRoute) AuthGuard(),
            ...?guards,
          ],
          binding: dependencies != null
              ? JetInjectionsBuilder(() {
                  dependencies(JetInjector());
                })
              : null,
        );

  /// Returns whether this page is the initial route.
  bool get initial => _initial;
}
