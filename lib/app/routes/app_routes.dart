import 'package:jet_app/modules/home/pages/home_page.dart';
import 'package:jet_app/modules/posts/auth/login/forms/login_form.dart';
import 'package:jet_app/modules/posts/auth/login/pages/login_page.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/verify_and_register_controller.dart';
import 'package:jet_app/modules/posts/auth/register/controllers/send_otp_controller.dart';
import 'package:jet_app/modules/posts/auth/register/pages/register_page.dart';
import 'package:jet_app/modules/posts/auth/register/pages/verify_register_otp_page.dart';
import 'package:jet_app/modules/profile/views/profile_page.dart';
import 'package:jet_app/modules/profile/views/profile_page_details.dart';
import 'package:jet_framework/router/models/jet_page.dart';

final List<JetPage> appPages = [
  JetPage(
    name: '/home',
    page: () => HomePage(),
    initial: true,
    authenticatedRoute: true,
    dependencies: (injector) {
      injector.lazyPut(() => LoginController());
    },
  ),
  JetPage(
    name: '/login',
    page: () => LoginPage(),
    dependencies: (injector) {
      injector.lazyPut(() => LoginController());
    },
  ),
  JetPage(
    name: '/register',
    page: () => RegisterPage(),
    dependencies: (injector) {
      injector.lazyPut(() => SendOtpController());
    },
    children: [
      JetPage(
        name: '/verify-otp',
        page: () => VerifyRegisterOtpPage(),
        dependencies: (injector) {
          injector.lazyPut(() => VerifyAndRegisterController());
        },
      ),
    ],
  ),
  JetPage(
    name: '/posts',
    page: () => PostsPage(),
    authenticatedRoute: true,
    children: [
      JetPage(
        name: '/posts-details',
        page: () => PostsPageDetails(),
      ),
    ],
  )
];
