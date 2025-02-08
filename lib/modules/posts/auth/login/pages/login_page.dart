import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/login/forms/login_form.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_form.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/resources/views/jet_widget.dart';
import 'package:jet_framework/resources/widgets/jet_app_bar.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';
import 'package:jet_framework/resources/widgets/jet_page_header.dart';
import 'package:jet_framework/router/jet_router.dart';

class LoginPage extends JetWidget<LoginController> {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JetAppBar(
        title: 'Login'.tr,
      ),
      body: Column(
        children: [
          JetForm<User>(
            header: JetPageHeader(
              title: 'Login'.tr,
              description: 'Please enter your credentials'.tr,
              icon: Icons.person_outline,
            ),
            controller: controller,
            submitLabel: 'Login'.tr,
          ),
          JetButton.text(
            label: 'Create account'.tr,
            onPressed: () {
              routeTo('/register');
            },
          )
        ],
      ),
    );
  }
}
