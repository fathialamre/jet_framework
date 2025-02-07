import 'package:jet_app/modules/posts/auth/login/models/login_request.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_framework/networking/jet_service.dart';

class LoginService extends JetService {
  Future<User?> login({
    required LoginRequest loginRequest,
  }) async {
    final c = await post<User>(
      '/login',
      data: loginRequest,
    );
    return c;
  }
}
