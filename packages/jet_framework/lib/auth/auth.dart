import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/helpers/jet_storage.dart';
import 'package:jet_framework/router/jet_router.dart';

class Auth {
  // Returns the key used for storing authentication data
  static final String _key = JetApp.authKey;

  /// Authenticate the user by saving data to storage.
  static Future<void> authenticate({
    required Map<String, dynamic> data,
    bool redirectToHome = true,
    String? token,
  }) async {
    assert(data.isNotEmpty, '''
      Data must be a non-empty Map.
      Example:
      Auth.authenticate(data: {
        "token": "abc123",
      });
    ''');

    try {
      await JetStorage.writeJson(key: _key, value: data);
      if (token != null) {
        await saveToken(token);
      }
      if (redirectToHome) {
        routeToAndOffAll(JetApp.initialRoute);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Logout the user by removing authentication data from storage.
  static Future<void> logout() async {
    try {
      await JetStorage.remove(key: _key);
      routeToAndOffAll(JetApp.loginRoute);
    } catch (e) {
      rethrow;
    }
  }

  /// Check if a user is authenticated.
  static bool isAuthenticated() {
    return JetStorage.readJson(key: _key) != null;
  }

  /// Retrieve the authenticated user data, optionally decoded into a specific model type [T].
  static T? user<T>({ModelParser<T>? decoder}) {
    final user = JetStorage.readJson(key: _key);
    if (user == null) return null;

    // If a decoder is provided, use it to decode the stored data.
    if (decoder != null) return decoder(user);

    // Check if a global decoder for the type [T] exists.
    if (T != dynamic) {
      final globalDecoder = JetApp.apiDecoders[T];
      if (globalDecoder != null) return globalDecoder(user);
    }

    // Return the raw data if no decoding is required.
    return user as T?;
  }

  static saveToken(String token) async {
    await JetStorage.writeSecuredData(key: 'token', value: token);
  }

  static Future<String> token() async {
    return await JetStorage.readSecuredData(key: 'token');
  }
}
