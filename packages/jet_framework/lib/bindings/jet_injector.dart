import 'package:get/get.dart';
import 'package:jet_framework/jet.dart';

class JetInjector {
  T put<T>(
    T builder, {
    String? tag,
    bool permanent = false,
  }) {
    return Get.put<T>(builder, tag: tag, permanent: permanent);
  }

  void lazyPut<T>(
    T Function() builder, {
    String? tag,
    bool fenix = false,
  }) {
    Get.lazyPut<T>(builder, tag: tag, fenix: fenix);
  }

  /// Registers an asynchronous instance of type [T] with an optional [tag] and [permanent] flag.
  /// Returns a Future that resolves to the registered instance.
  Future<T> putAsync<T>(
    Future<T> Function() builder, {
    String? tag,
    bool permanent = false,
  }) {
    return Get.putAsync<T>(() => builder(), tag: tag, permanent: permanent);
  }

  T singletonPut<T>(
    T instance, {
    String? tag,
  }) {
    return Get.put<T>(instance, tag: tag, permanent: true);
  }

  /// Helper function to register a lazy singleton instance.
  /// Returns the lazy registered instance.
  void singletonLazyPut<T>(
    T Function() builder, {
    String? tag,
  }) {
    Get.lazyPut<T>(builder, tag: tag, fenix: true);
  }
}

S find<S>({String? tag}) => GetInstance().find<S>(tag: tag);

Jet get JetApp => find<Jet>();

/// Registers an instance of type [T] with an optional [tag] and [permanent] flag.
/// Returns the registered instance.
T put<T>(
  T builder, {
  String? tag,
  bool permanent = false,
}) {
  return Get.put<T>(builder, tag: tag, permanent: permanent);
}

/// Lazily registers an instance of type [T] with an optional [tag] and [fenix] flag.
/// Returns the lazy registered instance.
void lazyPut<T>(
  T Function() builder, {
  String? tag,
  bool fenix = false,
}) {
  Get.lazyPut<T>(builder, tag: tag, fenix: fenix);
}

/// Registers an asynchronous instance of type [T] with an optional [tag] and [permanent] flag.
/// Returns a Future that resolves to the registered instance.
Future<T> putAsync<T>(
  Future<T> Function() builder, {
  String? tag,
  bool permanent = false,
}) {
  return Get.putAsync<T>(() => builder(), tag: tag, permanent: permanent);
}

/// Injects a list of bindings.
bindingsBuilder(List<Function()> bindings) {
  return BindingsBuilder(() {
    for (final binding in bindings) {
      binding(); // Execute each binding function
    }
  });
}

/// Helper function to register a singleton instance.
/// Returns the registered singleton instance.
T singletonPut<T>(
  T instance, {
  String? tag,
}) {
  return put<T>(instance, tag: tag, permanent: true);
}

/// Helper function to register a lazy singleton instance.
/// Returns the lazy registered instance.
void singletonLazyPut<T>(
  T Function() builder, {
  String? tag,
}) {
  lazyPut<T>(builder, tag: tag, fenix: true);
}

/// Helper function to find an instance of a type, and if not found, register it.
/// Returns the found or registered instance.
S findOrPut<S>(
  S Function() builder, {
  String? tag,
  bool permanent = false,
}) {
  if (Get.isRegistered<S>(tag: tag)) {
    return find<S>(tag: tag);
  } else {
    return put<S>(builder(), tag: tag, permanent: permanent);
  }
}
