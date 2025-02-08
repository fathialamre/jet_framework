import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/send_otp_controller.dart';
import 'package:jet_app/modules/posts/auth/register/models/otp_response.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_form.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/resources/views/jet_widget.dart';
import 'package:jet_framework/resources/widgets/jet_app_bar.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';
import 'package:jet_framework/resources/widgets/jet_page_header.dart';
import 'package:jet_framework/router/jet_router.dart';

class RegisterPage extends JetWidget<SendOtpController> {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JetAppBar(title: 'Create account'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JetForm<OtpResponse>(
              header: JetPageHeader(
                title: 'Create account'.tr,
                description: 'Please enter your credentials'.tr,
                icon: Icons.person_outline,
              ),
              controller: controller,
              submitLabel: 'Create account'.tr,
            ),
            JetButton.text(
              label: 'Login'.tr,
              onPressed: () {
                routeBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}
