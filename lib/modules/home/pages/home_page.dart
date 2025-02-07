import 'package:flutter/material.dart';
import 'package:jet_framework/auth/auth.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:jet_framework/resources/widgets/navigation_hub/jet_drawer.dart';
import 'package:jet_framework/resources/widgets/navigation_hub/navigation_hub.dart';
import 'package:jet_framework/resources/widgets/pages/jet_navigation_hub_widget.dart';

class HomePage extends JetNavigationHubWidget {
  @override
  JetNavigationHub get navigationHub => JetNavigationHub(items: [
        NavigationHubItem(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
          page: Center(
              child: ElevatedButton(onPressed: () async {
                var c =await Auth.token();
                dump(c);
              }, child: Text("AAA"))),
        ),
        NavigationHubItem(
          label: 'Settings',
          icon: Icon(Icons.settings_outlined),
          page: Text('Settings'),
        ),
      ]);

  @override
  JetDrawer? get drawer => JetDrawer(
        items: [
          JetDrawerItem(
            title: 'Home',
            icon: Icons.remove,
            onTap: () {},
          ),
        ],
        showLogout: true,
        showTheme: true,
        showLanguage: true,
      );
}
