import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';

enum JetPageHeaderAlignment { left, center, right }

class JetPageHeader extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String? description;
  final double spacing;
  final JetPageHeaderAlignment alignment;

  const JetPageHeader({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    this.description,
    this.spacing = 10.0,
    this.alignment = JetPageHeaderAlignment.center, // Default alignment
  });

  Widget? _buildIcon(BuildContext context) {
    return Icon(
      icon as IconData,
      size: 90,
      color: iconColor ?? Theme.of(context).primaryColor,
    );
  }

  MainAxisAlignment _getAlignment() {
    switch (alignment) {
      case JetPageHeaderAlignment.center:
        return MainAxisAlignment.center;
      case JetPageHeaderAlignment.right:
        return MainAxisAlignment.end;
      case JetPageHeaderAlignment.left:
        return MainAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Row(
            mainAxisAlignment: _getAlignment(),
            children: [_buildIcon(context)!],
          ),
          SizedBox(height: spacing),
        ],
        Row(
          mainAxisAlignment: _getAlignment(),
          children: [
            Text(title.tr).titleLarge(context).bold(),
          ],
        ),
        if (description != null) ...[
          SizedBox(height: spacing),
          Row(
            mainAxisAlignment: _getAlignment(),
            children: [
              Text(description!.tr).titleSmall(context).color(
                    Colors.grey,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
