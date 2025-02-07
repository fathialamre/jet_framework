import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JetLoader extends StatelessWidget {
  const JetLoader({super.key});

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return const Center(child: CircularProgressIndicator());
      case TargetPlatform.iOS:
        return const Center(child: CupertinoActivityIndicator());
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
