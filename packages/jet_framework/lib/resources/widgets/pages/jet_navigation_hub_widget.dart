import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/resources/widgets/navigation_hub/jet_drawer.dart';
import 'package:jet_framework/resources/widgets/navigation_hub/navigation_hub.dart';

class JetNavigationHubWidget extends StatelessWidget {
  JetNavigationHubWidget({super.key});

  JetNavigationHub get navigationHub {
    throw UnimplementedError(
      'You must implement the navigationHub getter',
    );
  }

  final NavigationHubController controller = NavigationHubController();

  AppBar appBar(BuildContext context) => AppBar(
        title: Text(
          JetApp.name,
        ).titleMedium(context),
      );

  JetDrawer? get drawer => null;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: drawer,
        appBar: appBar(context),
        body: IndexedStack(
          index: controller.index,
          children: navigationHub.items
              .map(
                (item) => item.page,
              )
              .toList(),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            for (var item in navigationHub.items)
              NavigationDestination(
                label: item.label,
                icon: item.icon,
              ),
          ],
          selectedIndex: controller.index,
          onDestinationSelected: controller.setActiveIndex,
        ),
      );
    });
  }
}
