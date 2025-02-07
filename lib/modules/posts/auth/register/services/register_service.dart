import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_request.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_response.dart';
import 'package:jet_app/modules/posts/auth/register/models/register_request.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:jet_framework/networking/jet_service.dart';

class RegisterService extends JetService {
  Future<OtpResponse?> registerOtp({
    required OtpRequest otpRequest,
  }) async {
    final c = await post<OtpResponse>(
      '/register/send-opt',
      data: otpRequest,
    );
    return c;
  }

  Future<User?> register({
    required RegisterRequest registerRequest,
  }) async {
    return await post<User>(
      '/register',
      data: registerRequest,
    );
  }
}
