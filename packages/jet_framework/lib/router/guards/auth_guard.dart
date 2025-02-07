import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/bindings/jet_injector.dart';

typedef JetGuard = GetMiddleware;

class AuthGuard extends JetGuard {
  @override
  RouteSettings? redirect(String? route) {
    if (!Auth.isAuthenticated()) {
      return RouteSettings(name: JetApp.loginRoute);
    }
    return super.redirect(route);
  }
}
