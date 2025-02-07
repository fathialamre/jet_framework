import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/router/jet_router.dart';
import 'package:jet_framework/theme/jet_style.dart';

class ThemeSwitcher {
  static showSwitcher(BuildContext context) {
    Rx<ThemeMode> theme = JetApp.style.getThemeMode.obs;

    return showModalBottomSheet(
      isScrollControlled: false,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Obx(() {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Wrap(
                children: [
                  Center(
                      child: Text(
                    'Display Options'.tr,
                  ).titleSmall(context)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: Icon(Icons.light_mode_outlined),
                    trailing: Icon(
                      Icons.check_circle,
                      color: theme.value == ThemeMode.light
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).secondaryHeaderColor,
                    ),
                    title: Text('Light'.tr).labelMedium(context),
                    onTap: () {
                      JetStyle.themeToLight();
                      routeBack();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode_outlined),
                    trailing: Icon(
                      Icons.check_circle,
                      color: theme.value == ThemeMode.dark
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).secondaryHeaderColor,
                    ),
                    title: Text('Dark'.tr).labelMedium(context),
                    onTap: () {
                      JetStyle.themeToDark();
                      routeBack();
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
