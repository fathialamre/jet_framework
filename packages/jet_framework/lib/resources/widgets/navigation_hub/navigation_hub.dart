import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/controllers/jet_controller.dart';

typedef JetPageBuilder = Widget Function();

class NavigationHubItem extends NavigationDestination {
  final Widget page;

  const NavigationHubItem(
      {super.key,
      required super.icon,
      required super.label,
      required this.page});
}

class JetNavigationHub {
  JetNavigationHub({
    required this.items,
  });

  final List<NavigationHubItem> items;
}

class NavigationHubController extends JetController {
  final RxInt currentIndex = 0.obs;

  int get index => currentIndex.value;

  void setActiveIndex(int index) {
    currentIndex.value = index;
  }
}
