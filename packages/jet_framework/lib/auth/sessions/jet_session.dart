import 'package:get/get.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/helpers/jet_storage.dart';

class JetSession {
  static authenticate({
    dynamic data,
    String? token,
    bool? redirectToHome,
    String? homeRoute = '/jet-home',
  }) async {
    if (data != null) {
      assert(data is Map, '''Data must be a Map or a Model
      Example:
      Auth.authenticate(data: {
        "token": "abc123",
      });
      or
      Auth.authenticate(data: user);''');
    }

    JetStorage.writeJson(key: 'auth', value: data);

    if (token != null) {
      JetStorage.write(key: 'token', value: token);
    }

    if (redirectToHome == true) {
      if (homeRoute == null) {
        throw Exception('Home route is not defined.');
      }
      Get.offAllNamed(homeRoute);
    }
  }

  static logout({Function? beforeLogout, Function? afterLogout}) async {
    if (beforeLogout != null) {
      beforeLogout.call();
    }
    JetStorage.remove(key: 'auth');
    if (afterLogout != null) {
      afterLogout.call();
    }

    // Get.offAllNamed(Jet.authRoute);
  }

  static T auth<T>({Decoder<T>? decoder}) {
    // Retrieve the local session data from storage
    final localSession = JetStorage.readJson(key: 'auth');

    // Check if the session data exists
    if (localSession == null) {
      throw Exception('User is not authenticated or session data is missing.');
    }

    if (decoder != null) {
      return decoder(localSession);
    }

    // if (T != dynamic) {
    //   final decoder = Jet.instance.authDecoder;
    //   final decodedData = decoder(localSession);
    //
    //   if (decodedData is T) {
    //     return decodedData;
    //   } else {
    //     throw Exception('Decoded data is not of type $T.');
    //   }
    // }

    // If T is dynamic, return the decoded data as-is
    return localSession;
  }

  static bool get isAuthenticated {
    return JetStorage.readJson(key: 'auth') != null;
  }

  static String get token =>
      isAuthenticated ? JetStorage.read(key: 'token') : '';
}

T auth<T>({Decoder<T>? decoder}) {
  return JetSession.auth<T>(decoder: decoder);
}

authenticate({
  dynamic data,
  String? token,
  bool? redirectToHome,
  String? homeRoute = '/jet-home',
}) {
  JetSession.authenticate(
    data: data,
    token: token,
    redirectToHome: redirectToHome,
    homeRoute: homeRoute,
  );
}

logout({Function? beforeLogout, Function? afterLogout}) {
  JetSession.logout(beforeLogout: beforeLogout, afterLogout: afterLogout);
}

isAuthenticated() {
  return JetSession.isAuthenticated;
}
