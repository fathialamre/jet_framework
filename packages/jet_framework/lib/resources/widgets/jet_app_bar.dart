import 'package:flutter/material.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';

class JetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final double height;

  const JetAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 0.0,
    this.height = kToolbarHeight, // Default AppBar height
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title).titleMedium(context).bold(),
      leading: leading,
      actions: actions,
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
