import 'package:jet_app/modules/posts/auth/login/data/models/post.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_response.dart';
import 'package:jet_app/modules/posts/auth/register/models/register_request.dart';
import 'package:jet_framework/networking/jet_service.dart';

final JetDecoder apiDecoders = {
  List<Post>: (data) => (data as List).map((e) => Post.fromJson(e)).toList(),
  User: (data) => User.fromJson(data),
  OtpResponse: (data) => OtpResponse.fromJson(data),
  RegisterRequest: (data) => RegisterRequest.fromJson(data),
};
