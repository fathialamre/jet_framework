import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/resources/languages/language_switcher.dart';
import 'package:jet_framework/resources/widgets/dialogs/jet_dialog.dart';
import 'package:jet_framework/theme/theme_switcher.dart';

class JetDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool visible;

  const JetDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: ListTile(
        title: Text(title).titleSmall(context),
        leading: Icon(icon),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

class JetDrawer extends Drawer {
  const JetDrawer({
    super.key,
    required this.items,
    this.showLogout = false,
    this.showTheme = false,
    this.showLanguage = false,
  });

  final List<JetDrawerItem> items;
  final bool showLogout;
  final bool showTheme;
  final bool showLanguage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text(
                'Jet Framework',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Add the main navigation items
            Expanded(
              child: ListView(
                children: items,
              ),
            ),
            // Add the logout item at the bottom
            const Divider(),
            JetDrawerItem(
              title: 'Language'.tr,
              icon: Icons.translate,
              onTap: () {
                LanguageSwitcher.showBottomSheet(context);
              },
              visible: showLanguage,
            ),
            JetDrawerItem(
              title: 'Theme'.tr,
              icon: Icons.color_lens_outlined,
              onTap: () {
                ThemeSwitcher.showSwitcher(context);
              },
              visible: showTheme,
            ),
            JetDrawerItem(
              title: 'Logout'.tr,
              icon: Icons.logout,
              onTap: () {
                JetDialog.showConfirmationBottomSheet(
                  context: context,
                  title: 'Logout'.tr,
                  message: 'Are you sure you want to logout?'.tr,
                  onConfirm: () => Auth.logout(),
                );
              },
              visible: showLogout,
            ),
          ],
        ),
      ),
    );
  }
}
