import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_request.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_response.dart';
import 'package:jet_app/modules/posts/auth/register/services/register_service.dart';
import 'package:jet_framework/forms/jet_filed.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/router/jet_router.dart';

class SendOtpController extends JetFormController<OtpResponse?, OtpRequest> {
  RegisterService registerService = RegisterService();

  @override
  List<JetField> get fields => [
        JetTextField(
          name: 'phone',
          initialValue: '0913335399',
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
          name: 'name',
          initialValue: 'Fathi',
          decoration: InputDecoration(
            labelText: 'Name'.tr,
            prefixIcon: const Icon(Icons.person),
          ),
          validator: JetValidator.compose([
            JetValidator.required(),
          ]),
        ),
        JetTextField(
          name: 'password',
          initialValue: 'password',
          decoration: InputDecoration(
            labelText: 'Password'.tr,
            prefixIcon: const Icon(Icons.password),
          ),
          validator: JetValidator.compose([
            JetValidator.required(),
            JetValidator.minLength(6),
          ]),
        ),

      ];

  @override
  Future<OtpResponse?> submitAction() {
    return registerService.registerOtp(otpRequest: formValue);
  }

  @override
  onSuccess(result) {
    if (result != null) {
      routeTo('/register/verify-otp', arguments: {
        'request': formValue,
        'ttl': result.ttl,
      });
    }
  }

  @override
  ModelParser<OtpRequest>? get modelParser => OtpRequest.fromJson;
}
