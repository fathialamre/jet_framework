import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/login/models/login_request.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/login/services/login_service.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/forms/jet_filed.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/jet_framework.dart';

class LoginController extends JetFormController<User?, LoginRequest> {
  LoginService loginService = LoginService();

  @override
  List<JetField> get fields => [
        JetTextField(
          name: 'phone',
          initialValue: '0913335396',
          decoration: InputDecoration(
            labelText: 'Phone'.tr,
            prefixIcon: const Icon(Icons.phone),
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
            labelText: 'Password'.tr,
            prefixIcon: const Icon(Icons.password),
          ),
          initialValue: 'password',
          validator: JetValidator.compose([
            JetValidator.required(),
          ]),
        ),
      ];

  @override
  Future<User?> submitAction() {
    return loginService.login(loginRequest: formValue);
  }

  @override
  onError(Object error, StackTrace stackTrace) {
    // dump(error);
    // showErrorToast(error);
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
  ModelParser<LoginRequest>? get modelParser => LoginRequest.fromJson;
}
