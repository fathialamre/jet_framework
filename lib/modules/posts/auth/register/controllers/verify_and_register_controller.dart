import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/send_otp_controller.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_request.dart';
import 'package:jet_app/modules/posts/auth/register/models/register_request.dart';
import 'package:jet_app/modules/posts/auth/register/services/register_service.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_filed.dart';
import 'package:jet_framework/forms/jet_form_controller.dart';
import 'package:jet_framework/forms/jet_pin_filed.dart';
import 'package:jet_framework/forms/mixins/otp_timer_mixin.dart';
import 'package:jet_framework/helpers/helper.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/router/jet_router.dart';

class VerifyAndRegisterController extends JetFormController with OtpTimerMixin {
  @override
  RegisterService get service => RegisterService();

  final SendOtpController sendOtpController = find<SendOtpController>();

  @override
  List<JetField> get fields => [
        JetPinField(
          name: 'otp',
          validator: JetValidator.compose([
            JetValidator.required(),
            JetValidator.minLength(6),
          ]),
        )
      ];

  @override
  Future<User?> action() {
    final OtpRequest otpRequest = routeArgs('request');
    final finalRequest = RegisterRequest(
      phone: otpRequest.phone,
      name: otpRequest.name,
      password: otpRequest.password,
      otp: formValue.otp,
    );
    return service.register(registerRequest: finalRequest);
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
  JetDecoder<RegisterRequest>? get decoder => RegisterRequest.fromJson;

  @override
  void onInit() {
    startTimer(routeArgs('ttl'));
    super.onInit();
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }

  resendOtp() async {
    final OtpResponse = await sendOtpController.action();
    if (OtpResponse != null) {
      startTimer(OtpResponse.ttl);
      showSuccess( 'Code sent successfully'.tr);
    } else {
      showError('Failed to resend OTP'.tr);
    }
  }
}
