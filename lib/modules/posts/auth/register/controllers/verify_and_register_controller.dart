import 'dart:async';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/send_otp_controller.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_request.dart';
import 'package:jet_app/modules/posts/auth/register/models/register_request.dart';
import 'package:jet_app/modules/posts/auth/register/services/register_service.dart';
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
  Future<User?> submitAction() {
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
      routeTo('/register/verify-otp');
    }
  }

  @override
  ModelParser<RegisterRequest>? get modelParser => RegisterRequest.fromJson;

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
    final OtpResponse = await sendOtpController.submitAction();
    if (OtpResponse != null) {
      startTimer(OtpResponse.ttl);
    } else {
      showError('Failed to resend OTP'.tr);
    }
  }
}
