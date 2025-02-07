import 'package:flutter/material.dart';
import 'package:jet_app/modules/posts/auth/login/forms/login_form.dart';
import 'package:jet_app/modules/posts/auth/login/models/user.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/forms/jet_form.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:jet_framework/router/jet_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController formController = find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'.tr).titleMedium(context).bold(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            JetForm<User>(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.person_outline, size: 60),
                  Text('Login'.tr)
                      .titleLarge(context)
                      .bold()
                      .paddingSymmetric(vertical: 10),
                  Text('Please enter your credentials'.tr).titleMedium(context),
                ],
              ),
              formController: formController,
            ),
            InkWell(
              onTap: () {
                routeTo('/register');
              },
              child: Text('Register'.tr)
                  .titleMedium(context)
                  .color(context.theme.primaryColor)
                  .bold()
                  .paddingSymmetric(vertical: 10),
            )
          ],
        ),
      ),
    );
  }
}
