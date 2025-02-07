import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/send_otp_controller.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/verify_and_register_controller.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_response.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_form.dart';
import 'package:jet_framework/forms/mixins/otp_timer_mixin.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/resources/widgets/buttons/jet_label_button.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';

class VerifyRegisterOtpPage extends StatelessWidget {
  VerifyRegisterOtpPage({super.key});

  final VerifyAndRegisterController controller =
      find<VerifyAndRegisterController>();

  final SendOtpController sendOtpController = find<SendOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'.tr).titleMedium(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            JetForm<OtpResponse>(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline, size: 60),
                  Text('Verify OTP'.tr)
                      .titleLarge(context)
                      .bold()
                      .paddingSymmetric(vertical: 10),
                  Text('Enter your data to receive OTP'.tr)
                      .titleMedium(context),
                ],
              ),
              formController: controller,
            ),
            OtpTimerWidget(
              remainingTime: controller.remainingTime,
              resendOtp: () async {
                await controller.resendOtp();
              },
            ),
          ],
        ),
      ),
    );
  }
}
