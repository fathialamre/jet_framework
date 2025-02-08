import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';

abstract class JetWidget<T> extends StatelessWidget {
  final String? tag = null;

  T get controller => find<T>(tag: tag);

  const JetWidget({super.key});

  @override
  Widget build(BuildContext context);
}
