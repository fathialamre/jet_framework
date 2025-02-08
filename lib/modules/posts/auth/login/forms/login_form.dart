import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/login/models/login_request.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/login/services/login_service.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/forms/jet_filed.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/helpers/helper.dart';
import 'package:jet_framework/jet_framework.dart';

class LoginController extends JetFormController<User?, LoginRequest> {
  LoginService loginService = LoginService();

  @override
  bool get showErrorToast => true;

  @override
  List<JetField> get fields => [
        JetTextField(
          name: 'phone',
          initialValue: '0913335394',
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone),
            hintText: '09xxxxxxxx',
          ),
          validator: JetValidator.compose([
            JetValidator.required(),
            JetValidator.phoneNumber(
              regex: RegExp(r'^(091|092|094|093|096|095)\d{7}$'),
            ),
          ]),
        ),
        JetTextField(
          name: 'password',
          decoration: InputDecoration(
            hintText: 'Password'.tr,
            prefixIcon: const Icon(Icons.password),
          ),
          initialValue: 'password',
          validator: JetValidator.compose([
            JetValidator.required(),
          ]),
        ),
      ];

  @override
  Future<User?> action() {
    return loginService.login(loginRequest: formValue);
  }

  @override
  onSuccess(result) {
    if (result != null) {
      Auth.authenticate(
        data: result.toJson(),
        token: result.token,
      );
    }
  }

  @override
  JetDecoder<LoginRequest>? get decoder => LoginRequest.fromJson;
}
