import 'package:get/get.dart';
import 'models/jet_page.dart';

class JetRouter {
  final List<JetPage> _pages = [];

  /// Adds a single page to the router.
  void addPage(JetPage page) {
    _pages.add(page);
  }

  /// Adds multiple pages to the router.
  void addPages(List<JetPage> pages) {
    _pages.addAll(pages);
  }

  /// Returns an unmodifiable list of pages.
  List<JetPage> get pages {
    try {
      return List.unmodifiable(_pages);
    } catch (e) {
      throw StateError('No pages found. Ensure at least one page is added.');
    }
  }

  /// Returns the initial route based on the first page marked as initial.
  String get initialRoute {
    try {
      return _pages.firstWhere((page) => page.initial).name;
    } catch (e) {
      throw StateError(
        'No initial route found. Ensure at least one page is marked as initial.',
      );
    }
  }
}

/// Creates and configures a [JetRouter] instance using a builder function.
///
/// Example:
/// ```dart
/// final router = createJetRouter((router) {
///   router.addPage(JetPage(
///     name: '/home',
///     page: () => HomeScreen(),
///     initial: true,
///   ));
///   router.addPage(JetPage(
///     name: '/profile',
///     page: () => ProfileScreen(),
///   ));
/// });
/// ```
JetRouter jetRouter(void Function(JetRouter router) builder) {
  final JetRouter router = JetRouter();
  builder(router);
  return router;
}

routeArgs(String? key) {
  return key != null ? Get.arguments[key] : Get.arguments;
}

routeTo(String page, {dynamic arguments}) {
  return Get.toNamed(page, arguments: arguments);
}

routeToAndOffAll(String page, {dynamic arguments}) {
  return Get.offAllNamed(page, arguments: arguments);
}

routeBack<T>({
  T? result,
  bool closeOverlays = false,
  bool canPop = true,
  int? id,
}) {
  return Get.back();
}
