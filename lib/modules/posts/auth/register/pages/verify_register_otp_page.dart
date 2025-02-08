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
import 'package:jet_framework/resources/widgets/jet_app_bar.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';
import 'package:jet_framework/resources/widgets/jet_page_header.dart';

class VerifyRegisterOtpPage extends StatelessWidget {
  VerifyRegisterOtpPage({super.key});

  final VerifyAndRegisterController controller =
      find<VerifyAndRegisterController>();

  final SendOtpController sendOtpController = find<SendOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JetAppBar(title: 'Verify account'.tr),
      body: Column(
        children: [
          JetForm<OtpResponse>(
            header: JetPageHeader(
              title: 'Verify account'.tr,
              description: 'Enter the code sent to your phone'.tr,
              icon: Icons.lock_open_sharp,
            ),
            controller: controller,
            submitLabel: 'Verify'.tr,
          ),
          OtpTimerWidget(
            remainingTime: controller.remainingTime,
            resendOtp: () async {
              await controller.resendOtp();
            },
          ),
        ],
      ),
    );
  }
}


