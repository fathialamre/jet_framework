import 'package:jet_framework/jet.dart';

/// An abstract class that serves as an provider for initializing and configuring a `Jet` instance.
abstract class JetProvider {
  /// This method is called during the `boot` phase of the application.
  /// It allows the provider to modify the `Jet` instance or perform setup tasks.
  ///
  /// Returns a modified `Jet` instance or `null` if no modifications are needed.
  Future<Jet?> boot(Jet jet) async => null;

  /// This method is called after the `boot` phase has completed.
  /// It allows the provider to perform tasks that depend on the `Jet` instance being fully initialized.
  Future<void> afterBoot(Jet jet) async {}
}

/// Boots the application by initializing all providers in the provided map.
///
/// - [providers]: A map where the key is the provider type and the value is the provider instance.
///
/// Returns the initialized `Jet` instance.
///
/// Example usage:
/// ```dart
/// final jet = await bootApplication({
///   Myprovider: Myprovider(),
///   Anotherprovider: Anotherprovider(),
/// });
/// ```
Future<Jet> bootApplication(Map<Type, JetProvider> providers) async {
  Jet jet = Jet();
  for (final provider in providers.values) {
    // Allow each provider to modify the `Jet` instance during the boot phase.
    final jetObject = await provider.boot(jet);
    if (jetObject != null) {
      jet = jetObject; // Update `Jet` instance if modified by the provider.
    }
  }

  return jet; // Return the initialized `Jet` instance.
}

/// Finalizes the boot process by performing post-boot tasks for each provider and saving the `Jet` instance.
///
/// - [jet]: The initialized `Jet` instance.
/// - [providers]: A map where the key is the provider type and the value is the provider instance.
///
/// Returns the finalized `Jet` instance.
///
/// Example usage:
/// ```dart
/// final jet = await bootApplication(myproviders);
/// await bootFinished(jet, myproviders);
/// ```
Future<Jet> bootFinished(Jet jet, Map<Type, JetProvider> providers) async {
  for (final provider in providers.values) {
    // Perform post-boot tasks for each provider.
    await provider.afterBoot(jet);
  }

  return jet; // Return the finalized `Jet` instance.
}
